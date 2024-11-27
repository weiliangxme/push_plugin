package com.app.push.library;

import android.content.Context;
import android.os.Build;
import android.util.Log;
import androidx.annotation.NonNull;
import com.app.push.library.revicer.LibraryPushReceiver;
import com.app.push.library.util.NotificationManagerUtils;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.installations.FirebaseInstallations;
import com.google.firebase.installations.InstallationTokenResult;
import com.google.firebase.messaging.FirebaseMessaging;
import com.hihonor.push.sdk.HonorPushCallback;
import com.hihonor.push.sdk.HonorPushClient;
import com.mixpush.core.MixPushClient;
import com.mixpush.core.MixPushLogger;

import java.util.TimeZone;


public class PushService {

    private PushService(){}

    public static PushService getInstance() {
        return SingletonFactory.instance;
    }

    static class SingletonFactory {
        private final static PushService instance = new PushService();
    }

    private IPushListener listener;

    public IPushListener getListener() {
        return listener;
    }


    /**
     * 初始化函数
     */
    public void init(Context context,IPushListener listener){
        this.listener=listener;
        MixPushClient.getInstance().setLogger(new MixPushLogger() {
            @Override
            public void log(String tag, String content, Throwable throwable) {
                Log.e("bee_push log","tag:"+tag+",content:"+content+",throwable:"+throwable.toString());
            }

            @Override
            public void log(String tag, String content) {
                Log.e("bee_push log","tag:"+tag+",content:"+content);
            }
        });
        MixPushClient.getInstance().setPushReceiver(new LibraryPushReceiver());
        MixPushClient.getInstance().register(context);
        if(isRegisterFcm()){
            // google推送
            FirebaseMessaging.getInstance().setAutoInitEnabled(true);
            FirebaseMessaging.getInstance().getToken().addOnCompleteListener(new OnCompleteListener<String>() {
                @Override
                public void onComplete(@NonNull Task<String> task) {
                    if(!task.isSuccessful()){
                        return;
                    }
                    // Get new Instance ID token
                    String token = task.getResult();
                    Log.e("bee_push fcm_getToken",token);
                    IPushListener iPushListener= PushService.getInstance().getListener();
                    if(iPushListener!=null){
                        iPushListener.onGetToken(new PushPlatform("google",token));
                    }
                }
            });
        }
//        initHonor(context);
    }

    private void initHonor(Context context) {
        boolean isSupport = HonorPushClient.getInstance().checkSupportHonorPush(context);
        Log.e("bee_push"," isSupport HonorPush"+isSupport);
        if (isSupport) {
            HonorPushClient.getInstance().init(context, true);
            Log.e("bee_push","HonorPush init");
            HonorPushClient.getInstance().getPushToken(new HonorPushCallback<String>() {
                @Override
                public void onSuccess(String pushToken) {
                    // TODO: 新Token处理
                    Log.e("bee_push","++++++HonorPushCallback onSuccess pushToken :"+pushToken);
                    IPushListener iPushListener= PushService.getInstance().getListener();
                    if(iPushListener!=null){
                        iPushListener.onGetToken(new PushPlatform("honor",pushToken));
                    }
                }
                @Override
                public void onFailure(int errorCode, String errorString) {
                    // TODO: 错误处理
                    Log.e("bee_push","++++++HonorPushCallback onFailure errorString :"+errorString);
                }
            });
        }
        // 获取PushToken

    }

    /**
     * 初始化函数
     */
    public void init(Context context){
        Log.e("bee_push","init");

        MixPushClient.getInstance().setLogger(new MixPushLogger() {
            @Override
            public void log(String tag, String content, Throwable throwable) {
                Log.e("bee_push log","tag:"+tag+",content:"+content+",throwable:"+throwable.toString());
            }

            @Override
            public void log(String tag, String content) {
                Log.e("bee_push log","tag:"+tag+",content:"+content);
            }
        });

        MixPushClient.getInstance().setPushReceiver(new LibraryPushReceiver());
        MixPushClient.getInstance().register(context);
        if(isRegisterFcm()){
            // google推送
            FirebaseMessaging.getInstance().setAutoInitEnabled(true);
            FirebaseMessaging.getInstance().getToken().addOnCompleteListener(new OnCompleteListener<String>() {
                @Override
                public void onComplete(@NonNull Task<String> task) {
                    if(!task.isSuccessful()){
                        return;
                    }
                    // Get new Instance ID token
                    String token = task.getResult();
                    Log.e("bee_push fcm_onNewToken",token);
                    IPushListener iPushListener= PushService.getInstance().getListener();
                    if(iPushListener!=null){
                        iPushListener.onGetToken(new PushPlatform("google",token));
                    }
                }
            });
        }
        initHonor(context);
    }

    private boolean isRegisterFcm() {
        boolean isCn = false;
        //Asia/Harbin  Asia/Shanghai  Asia/Chongqing  Asia/Urumqi Asia/Kashgar
//        String timeZone = TimeZone.getDefault().getID();
//        if("Asia/Shanghai".equals(timeZone)||"Asia/Harbin".equals(timeZone)||"Asia/Chongqing".equals(timeZone)||"Asia/Urumqi".equals(timeZone)||"Asia/Kashgar".equals(timeZone)){
//            isCn = true;
//        }
        //Meizu  Xiaomi HONOR // 下面是为了走厂商通道 判断
//        if (Build.MANUFACTURER.isEmpty()){
//            return  true;
//        }else if(isCn&&(Build.MANUFACTURER.equals("Xiaomi")||Build.MANUFACTURER.equals("Meizu")||Build.MANUFACTURER.equals("HONOR"))){
//            return false;
//        }
        Log.d("bee_push isRegisterFcm","true");
        return  true;
    }

    /**设置监听
     * @param listener
     */
    public void setListener(IPushListener listener){
        this.listener=listener;
    }


    /**如果没打开通知，则跳转去设置
     * @param context
     */
    public void OpenNotificationIfNeed(Context context){
        if (!NotificationManagerUtils.isPermissionOpen(context)) {
            NotificationManagerUtils.openPermissionSetting(context);
        }
    }


}
