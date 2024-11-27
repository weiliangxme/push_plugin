package com.bee.plugin.flutter_plugin;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import androidx.annotation.NonNull;

import com.app.push.library.IPushListener;
import com.app.push.library.PushPlatform;
import com.app.push.library.PushService;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;


/** FlutterPlugin */
public class PushPlugin implements FlutterPlugin, MethodCallHandler, IPushListener {
  private static MethodChannel channel;
//  private static  PushAgent pushAgent;
  private static PushService pushService;
  private String TAG="PushAgent";
  private Context context;

  @Override
  public void onAttachedToEngine(FlutterPluginBinding flutterPluginBinding) {
    this.context=flutterPluginBinding.getApplicationContext();
    pushService=PushService.getInstance();
    pushService.setListener(this);

    Log.e(TAG,"新版初始化:推送插件");
    channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutter_plugin_push");
    channel.setMethodCallHandler(this);
  }

  @Deprecated
//  public static void registerWith(PluginRegistry.Registrar registrar) {
//    pushService=PushService.getInstance();
//    pushService.init(registrar.context(),this);
////    pushAgent=new PushAgent(registrar.context());
//    Log.e(PushAgent.TAG,"旧版初始化:推送插件");
//    channel = new MethodChannel(registrar.messenger(), "flutter_plugin_push");
//    channel.setMethodCallHandler(new FlutterPluginPush());
//  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

    switch (call.method){
      case "init":
        pushService.init(context);
        break;
      case "openNotificationIfNeed":
        pushService.OpenNotificationIfNeed(context);
        break;
      default:
        result.notImplemented();
    }
  }


  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }


  public  void onReceiveNotification(final String extras){
    new Handler(Looper.getMainLooper()).post(new Runnable() {
      @Override
      public void run() {
        channel.invokeMethod("onReceiveNotification", extras);
      }
    });

  }

  public  void onReceiveMessage(final String extras) {

    new Handler(Looper.getMainLooper()).post(new Runnable() {
      @Override
      public void run() {
        channel.invokeMethod("onReceiveMessage", extras);
      }
    });
  }

  public  void onOpenNotification( final String extras) {
    Log.e(TAG,"插件收到->onOpenNotification:"+extras);
    new Handler(Looper.getMainLooper()).post(new Runnable() {
      @Override
      public void run() {
        Log.e(TAG,"插件执行->onOpenNotification:"+extras);
        channel.invokeMethod("onOpenNotification", extras);
      }
    });
  }

  public void onReceivedToken(final String platform, final String token) {
    Log.e(TAG,"onReceivedToken:"+token);
    new Handler(Looper.getMainLooper()).post(new Runnable() {
      @Override
      public void run() {
        Map<String, Object> map= new HashMap<>();
        map.put("platform", platform);
        map.put("token", token);
        channel.invokeMethod("onReceivedToken", map.toString());
      }
    });
  }

  @Override
  public void onGetToken(PushPlatform pushPlatform) {
    onReceivedToken(pushPlatform.getPlatform(),pushPlatform.getToken());
  }

  @Override
  public void onOpenNotification(Map<String, Object> map) {
    onOpenNotification(map.toString());
  }
}
