package com.app.push.library.service;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Intent;
import android.graphics.BitmapFactory;
import android.os.Build;
import android.util.Log;
import android.net.Uri;
import androidx.annotation.NonNull;

import com.bee.plugin.flutter_plugin.R;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;
import com.mixpush.core.MixPushPlatform;


import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import android.os.Bundle;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import java.util.ArrayList;


public class FcmService extends FirebaseMessagingService {
    @Override
    public void onMessageReceived(@NonNull RemoteMessage remoteMessage) {
        super.onMessageReceived(remoteMessage);
        Log.d("bee_push FCM_Received",remoteMessage.toString());
        Log.d("bee_push FCM_Received ","getData: "+remoteMessage.getData().toString());
        createNotification(remoteMessage.getNotification().getTitle(),remoteMessage.getNotification().getBody(),remoteMessage.getData().toString());
    }

    void createNotification(String title,String content,String payload){
        NotificationManager manager = (NotificationManager) getSystemService(NOTIFICATION_SERVICE);
        Notification.Builder builder;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            String channelId = "notification_simple";
            NotificationChannel channel = new NotificationChannel(channelId, "simple", NotificationManager.IMPORTANCE_DEFAULT);
            manager.createNotificationChannel(channel);
            builder = new Notification.Builder(this, channelId);
        } else {
            builder = new Notification.Builder(this);
        }
        Intent intent = new Intent("com.test.notifycation.message");
        try {
            JSONObject payloadObject = new JSONObject(payload);
            if (payloadObject.has("payload")){
                JSONObject jsonObject = payloadObject.getJSONObject("payload");
                Log.e("bee_push create jsonObject",""+jsonObject.toString());
                if (jsonObject.has("browserOpenType")){
                    boolean browserOpenType = (boolean) jsonObject.get("browserOpenType");
                    intent.putExtra("browserOpenType", browserOpenType);
                }
                if (jsonObject.has("dappFlag")){
                    boolean dappFlag = (boolean) jsonObject.get("dappFlag");
                    intent.putExtra("dappFlag", dappFlag);
                }
                if (jsonObject.has("inUrl")){
                    JSONArray jsonArray = jsonObject.getJSONArray("inUrl");
                    for (int i = 0; i < jsonArray.length(); i++) {
                        String page = (String) jsonArray.get(i);
                        intent.putExtra("inUrl_"+i, page);
                    }
                }
                if (jsonObject.has("jumpType")) {
                    boolean jumpType = (boolean) jsonObject.get("jumpType");
                    intent.putExtra("jumpType", jumpType);
                }
                if (jsonObject.has("outUrl")){
                    String outUrl = (String) jsonObject.get("outUrl");
                    intent.putExtra("outUrl", outUrl);
                }
                if (jsonObject.has("joinId")){
                    int joinId = (int) jsonObject.get("joinId");
                    intent.putExtra("joinId", joinId);
                }
                 if (jsonObject.has("sendPlanDetailId")){
                    Object object = jsonObject.get("sendPlanDetailId");
                    if (object instanceof Integer){
                        int sendPlanDetailId = (int) object;
                        intent.putExtra("sendPlanDetailId", sendPlanDetailId);
                    }else if(object instanceof Long){
                        long sendPlanDetailId = (long) object;
                        intent.putExtra("sendPlanDetailId", sendPlanDetailId);
                    }
                }
                if (jsonObject.has("messageId")){
                    Object object = jsonObject.get("messageId");
                    if (object instanceof Integer){
                        int messageId = (int) object;
                        intent.putExtra("messageId", messageId);
                    }else if(object instanceof Long){
                        long messageId = (long) object;
                        intent.putExtra("messageId", messageId);
                    }
                }
            }
        } catch (JSONException e) {
            Log.e("bee_push createNotification",""+e);
        }
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        PendingIntent pendingIntent;
        Log.d("bee_push FCM_createNotification","FLAG_IMMUTABLE");
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            pendingIntent = PendingIntent.getActivity(this, 0, intent,  PendingIntent.FLAG_IMMUTABLE);
        } else {
            pendingIntent = PendingIntent.getActivity(this, 0, intent, 0);
        }

        builder.setContentTitle(title);
        builder.setContentText(content);
        builder.setContentIntent(pendingIntent);
        builder.setTicker("");//首次收到的时候，在状态栏中，图标的右侧显示的文字
        builder.setSmallIcon(R.mipmap.ic_launcher);
        builder.setLargeIcon(BitmapFactory.decodeResource(getResources(), R.mipmap.ic_launcher));
        builder.setAutoCancel(true);
        manager.notify(0, builder.build());
    }




    @Override
    public void onNewToken(@NonNull String s) {
        super.onNewToken(s);
        FirebaseMessaging.getInstance().subscribeToTopic("broadcast");
        Log.d("bee_push fcm-onNewToken",s);

    }
}
