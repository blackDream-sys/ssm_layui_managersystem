package com.bdqn.utils;

import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.crypto.hash.Sha1Hash;

public class PasswordUtil {

    /**
     * 对密码加密 md5
     * @param source  要加密的明文
     * @param salt  盐
     * @param hashIterations  散列次数
     * @return
     */
    public static String md5(String source, Object salt, Integer hashIterations) {
        return new Md5Hash(source, salt, hashIterations).toString();
    }


    /**
     * 对密码加密sha1
     * @param source  要加密的明文
     * @param salt  盐
     * @param hashIterations  散列次数
     * @return
     */
    public static String sha1(String source, Object salt, Integer hashIterations) {
        return new Sha1Hash(source, salt, hashIterations).toString();
    }

    public static void main(String[] args) {
        //密码明文
        String password = "123456";
        //以用户名作为盐值(盐值唯一，可以选择随机数)
        System.out.println("加密后的密码："+ PasswordUtil.md5(password,"admin",5));

    }

}