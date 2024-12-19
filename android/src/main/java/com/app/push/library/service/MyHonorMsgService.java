//package com.app.push.library.service;
//
//import android.util.Log;
//
//import com.hihonor.push.sdk.HonorMessageService;
//import com.hihonor.push.sdk.HonorPushDataMsg;
//import com.app.push.library.IPushListener;
//import com.app.push.library.PushPlatform;
//import com.app.push.library.PushService;
//
//public class MyHonorMsgService extends HonorMessageService {
//    //Token发生变化时，会以onNewToken方法返回
//    @Override
//    public void onNewToken(String pushToken) {
//        // TODO: 处理收到的新PushToken。
//        Log.e("MyHonorMsgService","++++++pushToken :"+pushToken);
//        IPushListener iPushListener= PushService.getInstance().getListener();
//        if(iPushListener!=null){
//            iPushListener.onGetToken(new PushPlatform("honor",pushToken));
//        }
//    }
//
//    @Override
//    public void onMessageReceived(HonorPushDataMsg onMessageReceived) {
//        // TODO: 处理收到的透传消息。
//        Log.e("MyHonorMsgService","++++++onMessageReceived :"+onMessageReceived.getData());
//    }
//}
