package com.ptitshop.utils;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class BCryptEncoder extends BCryptPasswordEncoder {

	public String BCEncrypt(String password) {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		return encoder.encode(password);
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		return super.matches(rawPassword, encodedPassword);
	}

	public static void main(String[] args) {
		String m = "123";
		BCryptEncoder encoder = new BCryptEncoder();
		System.out.println(encoder.BCEncrypt(m));
	}
}
