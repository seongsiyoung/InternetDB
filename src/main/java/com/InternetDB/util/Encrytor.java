package com.InternetDB.util;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

public class Encrytor {

    public static String salt() {

        String salt=null;

        try {
            SecureRandom random = SecureRandom.getInstance("SHA1PRNG");
            byte[] bytes = new byte[16];
            random.nextBytes(bytes);
            salt = new String(Base64.getEncoder().encode(bytes));//바이트 배열을 Base64로 인코딩해 문자열로 변환


        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        return salt;
    }

    public static String encryptPassword(String password, String salt) {
        String saltedPassword = salt + password;
        String result = null;
        try {
            //SHA-512알고리즘으로 솔트 + 비밀번호 해시화
            MessageDigest msg = MessageDigest.getInstance("SHA-512");
            msg.update(saltedPassword.getBytes());

            //해시화한 값을 문자열로 변환
            result = String.format("%128x", new BigInteger(1, msg.digest()));

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return result;
    }
}
