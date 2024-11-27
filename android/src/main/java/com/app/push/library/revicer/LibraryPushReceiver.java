package com.app.push.library.revicer;

import android.content.Context;
import android.util.Log;

import com.app.push.library.IPushListener;
import com.app.push.library.PushPlatform;
import com.app.push.library.PushService;
import com.mixpush.core.MixPushMessage;
import com.mixpush.core.MixPushPlatform;
import com.mixpush.core.MixPushReceiver;


public class LibraryPushReceiver extends MixPushReceiver {
    @Override
    public void onRegisterSucceed(Context context, MixPushPlatform mixPushPlatform) {
        // 这里需要实现上传regId和推送平台信息到服务端保存，
        //也可以通过MixPushClient.getInstance().getRegisterId的方式实现
        Log.e("bee_push","onRegisterSucceed:"+mixPushPlatform.toString());
        IPushListener iPushListener= PushService.getInstance().getListener();
        if(iPushListener!=null) {
            iPushListener.onGetToken(new PushPlatform(mixPushPlatform.getPlatformName(),mixPushPlatform.getRegId()));
        }

    }

    @Override
    public void onNotificationMessageClicked(Context context, MixPushMessage message) {
        Log.e("bee_push","onNotificationMessageClicked:"+message.toString());
    }

    @Override
    public void onNotificationMessageArrived(Context context, MixPushMessage message) {
        super.onNotificationMessageArrived(context, message);
        Log.e("bee_push","onNotificationMessageArrived:"+message.toString());
    }
}
