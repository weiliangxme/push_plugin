//package com.mixpush.meizu;
//
//import android.content.Context;
//import android.os.Build;
//import android.util.Log;
//
//import com.meizu.cloud.pushsdk.PushManager;
//import com.meizu.cloud.pushsdk.util.MzSystemUtils;
//import com.mixpush.core.BaseMixPushProvider;
//import com.mixpush.core.RegisterType;
//
//public class MeizuPushProvider extends BaseMixPushProvider {
//    public static final String MEIZU = "meizu";
//    private String appId;
//    private String appKey;
//
//    @Override
//    public void register(Context context, RegisterType type) {
//        Log.e("bee_push Meizu ","Meizu register");
//        appId = getMetaData(context, "MEIZU_APP_ID");
//        appKey = getMetaData(context, "MEIZU_APP_KEY");
//        Log.e("bee_push Meizu ","Meizu register appId : "+appId);
//        Log.e("bee_push Meizu ","Meizu register appKey : "+appKey);
//        PushManager.register(context, appId, appKey);
//    }
//
//    @Override
//    public void unRegister(Context context) {
//        PushManager.unRegister(context, appId, appKey);
//    }
//
//    @Override
//    public String getRegisterId(Context context) {
//        return PushManager.getPushId(context);
//    }
//
//
//    @Override
//    public boolean isSupport(Context context) {
//        String manufacturer = Build.MANUFACTURER.toLowerCase();
//        if (manufacturer.equals("meizu")) {
//            return MzSystemUtils.isBrandMeizu(context);
//        }
//        return false;
//    }
//
//    @Override
//    public String getPlatformName() {
//        return MeizuPushProvider.MEIZU;
//    }
//}