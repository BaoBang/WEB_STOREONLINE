package com.ptitshop.utils;

public class Constants {

	// IMAGE
	// location to store file uploaded
	public static final String UPLOAD_DIRECTORY = "uploads";

	public static final int NUMBER_PRODUCTS_IN_PAGE = 12;

	public static final int NUMBER_POST_IN_PAGE = 12;

	public static final int NUMBER_ACCOUNT_IN_PAGE = 12;

	public static final String PRODCUT_CART = "PRODUCT_CART";
	// define paging results, use for default value of @RequestParam, so type of
	// data is String
	public static final String DEFAULT_PAGE_SIZE = "25";
	public static final String DEFAULT_PAGE_NUMBER = "0";

	public static final String SORT_BY_PRODUCT_BRAND_NONE = "0";
	public static final String SORT_BY_PRODUCT_PRICE_DESC = "DESC";
	public static final String SORT_BY_PRODUCT_PRICE_ASC = "ASC";

	//
	public static final int PHONE_CATEGORY_ID = 1;
	public static final int TABLET_CATEGORY_ID = 2;
	public static final int LAPTOP_CATEGORY_ID = 3;
	public static final int TOP_PRODUCT = 10;
	public static final int NONE_PARENT = 0;
	public static final int TOP_POST = 3;

	//
	public static final int DEUFAULT_ID = 0;
	public static final String DEFAULT_ROLE = "ROLE_USER";
	public static final String DEFAULT_AVATAR = "/PTiTShop/themes/images/avatar-75.png";
	public static final boolean DEFAULT_GENDER = true;
	public static final int DEFAULT_STATUS = 1;
	public static final int ZERO_NUMBER = 0;
	/*
	 * This regex can be used to restrict passwords to a length of 6 to 20
	 * aplhanumeric characters and select special characters. The password also
	 * can not start with a digit, underscore or special character and must
	 * contain at least one digit.
	 */
	public static final String PASSWORD_REGULAR = "^(?=[^\\d_].*?\\d)\\w(\\w|[!@#$%]){6,20}";
	/**/
	public static final String USER_NAME_REGULAR = "^[a-zA-Z0-9_-]{5,}$";

	public static final String NAME_REGULAR = "^[a-zA-Z]{1,}$";

	public static final String DEFAULT_POST_IMAGE = "/themes/images/default_post_image.png";
	public static final String DEFAULT_POST_STATUS = "1";
}
