package com.app.push.library;

public class PushPlatform {
    private String platform;
    private String token;

    public PushPlatform(String platform, String token) {
        this.platform = platform;
        this.token = token;
    }

    public String getPlatform() {
        return platform;
    }

    public void setPlatform(String platform) {
        this.platform = platform;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    @Override
    public String toString() {
        return "PushPlatform{" +
                "platform='" + platform + '\'' +
                ", token='" + token + '\'' +
                '}';
    }
}
