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
            salt = new String(Base64.getEncoder().encode(bytes));

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        return salt;
    }

    public static String encryptPassword(String password, String salt) {
        String saltedPassword = salt + password;
        String result = null;
        try {
            MessageDigest msg = MessageDigest.getInstance("SHA-512");
            msg.update(saltedPassword.getBytes());

            result = String.format("%128x", new BigInteger(1, msg.digest()));

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return result;
    }
}
