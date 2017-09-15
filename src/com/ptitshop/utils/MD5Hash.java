package com.ptitshop.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

import javax.xml.bind.DatatypeConverter;

public class MD5Hash {
	/*
	 * 
	 * 
	 * */
	public static String MD5Encrypt(String password) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.reset();
			md.update(password.getBytes());
			byte[] by = md.digest();
			String hashPassword = DatatypeConverter.printHexBinary(by);

			return hashPassword;
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public static String getSalt(){
		Random random = new Random();
		// random a number form 1000 t0 9999
		 return 10000 + random.nextInt(89999) + "";
	}
}
