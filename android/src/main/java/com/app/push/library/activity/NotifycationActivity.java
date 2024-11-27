package com.app.push.library.activity;

import android.app.Activity;
import android.os.Bundle;
import android.os.CountDownTimer;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.app.push.library.IPushListener;
import com.app.push.library.PushService;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class NotifycationActivity extends Activity {

    private static final String TAG = "PushAgent";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Bundle extras=getIntent().getExtras();
        //根据业务逻辑解析通知
        Map<String,Object> map=new HashMap<>();
        Set<String> keySet = extras.keySet();
        for(String key : keySet) {
            Object value = extras.get(key);
            Log.e("PushAgent-extra","获取值:"+key+":"+value);
            map.put(key,value);
        }
        IPushListener pushListener= PushService.getInstance().getListener();
        if(pushListener!=null){
            pushListener.onOpenNotification(map);
        }
        finish();
    }
}
