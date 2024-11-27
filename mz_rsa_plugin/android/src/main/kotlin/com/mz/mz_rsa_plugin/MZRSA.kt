package com.mz.mz_rsa_plugin

import android.annotation.TargetApi
import android.os.Build
import android.util.Base64
import java.io.ByteArrayOutputStream
import java.security.KeyFactory
import java.security.PrivateKey
import java.security.PublicKey
import java.security.spec.PKCS8EncodedKeySpec
import java.security.spec.X509EncodedKeySpec
import javax.crypto.Cipher

object MZRSA {
    private const val transformation = "RSA/ECB/PKCS1PADDING" //此处如果写成"RSA"加密出来的信息JAVA服务器无法解析
    private const val MAX_ENCRYPT_BLOCK = 117; //RSA最大加密明文大小
    private const val MAX_DECRYPT_BLOCK = 256; //RSA最大解密密文大小

    @TargetApi(Build.VERSION_CODES.FROYO)
    fun encryptStringByPublicKey(string: String, publicKey: String): String {
        //创建cipher对象
        var cipher = Cipher.getInstance(transformation);
        //初始化cipher
        cipher.init(Cipher.ENCRYPT_MODE, getPublicKey(publicKey));

        var data = string.toByteArray();
        var out = ByteArrayOutputStream();
        var offset = 0;
        var cache = ByteArray(0);

        //对数据分段加密
        while (data.size - offset > 0) {
            if (data.size - offset >= MAX_ENCRYPT_BLOCK) {
                cache = cipher.doFinal(data, offset, MAX_ENCRYPT_BLOCK);
                offset += MAX_ENCRYPT_BLOCK;
            } else {
                cache = cipher.doFinal(data, offset, data.size - offset);
                offset = data.size;
            }
            out.write(cache);
        }
        var encryptedData = out.toByteArray();
        out.close();
        return Base64.encodeToString(encryptedData, Base64.DEFAULT);
    }

    @TargetApi(Build.VERSION_CODES.FROYO)
    fun decryptStringByPublicKey(string: String, publicKey: String): String {
        //创建cipher对象
        var cipher = Cipher.getInstance(transformation);
        //初始化cipher
        cipher.init(Cipher.DECRYPT_MODE, getPublicKey(publicKey));

        var encryptedData = Base64.decode(string, Base64.DEFAULT);
        var out = ByteArrayOutputStream();
        var offset = 0;
        var cache = ByteArray(0);

        //对数据分段解密
        while (encryptedData.size - offset > 0) {
            if (encryptedData.size - offset >= MAX_DECRYPT_BLOCK) {
                cache = cipher.doFinal(encryptedData, offset, MAX_DECRYPT_BLOCK);
                offset += MAX_DECRYPT_BLOCK;
            } else {
                cache = cipher.doFinal(encryptedData, offset, encryptedData.size - offset);
                offset = encryptedData.size;
            }
            out.write(cache);
        }
        var data = out.toByteArray();
        out.close();
        return String(data);
    }

    @TargetApi(Build.VERSION_CODES.FROYO)
    fun encryptStringByPrivateKey(string: String, privateKey: String): String {
        //创建cipher对象
        var cipher = Cipher.getInstance(transformation);
        //初始化cipher
        cipher.init(Cipher.ENCRYPT_MODE, getPrivateKey(privateKey));

        var data = string.toByteArray();
        var out = ByteArrayOutputStream();
        var offset = 0;
        var cache = ByteArray(0);

        //对数据分段加密
        while (data.size - offset > 0) {
            if (data.size - offset >= MAX_ENCRYPT_BLOCK) {
                cache = cipher.doFinal(data, offset, MAX_ENCRYPT_BLOCK);
                offset += MAX_ENCRYPT_BLOCK;
            } else {
                cache = cipher.doFinal(data, offset, data.size - offset);
                offset = data.size;
            }
            out.write(cache);
        }
        var encryptedData = out.toByteArray();
        out.close();
        return Base64.encodeToString(encryptedData, Base64.DEFAULT);
    }

    @TargetApi(Build.VERSION_CODES.FROYO)
    fun decryptStringByPrivateKey(string: String, privateKey: String): String {
        //创建cipher对象
        var cipher = Cipher.getInstance(transformation);
        //初始化cipher
        cipher.init(Cipher.DECRYPT_MODE, getPrivateKey(privateKey));

        var encryptedData = Base64.decode(string, Base64.DEFAULT);
        var out = ByteArrayOutputStream();
        var offset = 0;
        var cache = ByteArray(0);

        //对数据分段解密
        while (encryptedData.size - offset > 0) {
            if (encryptedData.size - offset >= MAX_DECRYPT_BLOCK) {
                cache = cipher.doFinal(encryptedData, offset, MAX_DECRYPT_BLOCK);
                offset += MAX_DECRYPT_BLOCK;
            } else {
                cache = cipher.doFinal(encryptedData, offset, encryptedData.size - offset);
                offset = encryptedData.size;
            }
            out.write(cache);
        }
        var data = out.toByteArray();
        out.close();
        return String(data);
    }

    @TargetApi(Build.VERSION_CODES.FROYO)
    fun getPublicKey(publicKey: String) : PublicKey {
        var decodeKey = Base64.decode(publicKey, Base64.DEFAULT);
        var x509 = X509EncodedKeySpec(decodeKey);
        var keyFactory = KeyFactory.getInstance("RSA");
        return keyFactory.generatePublic(x509);
    }

    @TargetApi(Build.VERSION_CODES.FROYO)
    fun getPrivateKey(privateKey: String) : PrivateKey {
        var decodeKey = Base64.decode(privateKey, Base64.DEFAULT);
        var x509 = PKCS8EncodedKeySpec(decodeKey);
        var keyFactory = KeyFactory.getInstance("RSA");
        return keyFactory.generatePrivate(x509);
    }

}