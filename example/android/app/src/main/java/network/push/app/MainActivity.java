package network.push.app;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        Log.e("PushAgent","初始化插件");
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.e("PushAgent","onCreate");
        handleOpenClick(getIntent());
    }
    /**
     * 处理点击事件，当前启动配置的Activity都是使用
     * Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK
     * 方式启动，只需要在onCreat中调用此方法进行处理
     */
    private void handleOpenClick(Intent intent) {
        Bundle extras=intent.getExtras();
        if(extras==null)
            return;
        //根据业务逻辑解析通知
        Intent intentx=new Intent("com.test.notifycation.message");
        intentx.putExtras(extras);
        startActivity(intentx);
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        Log.e("PushAgent","onNewIntent");
        handleOpenClick(intent);
    }

}
