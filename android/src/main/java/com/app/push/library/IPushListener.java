package com.app.push.library;


import java.util.Map;

public interface IPushListener {
    void onGetToken(PushPlatform platform);
    void onOpenNotification(Map<String,Object> extra);

}
