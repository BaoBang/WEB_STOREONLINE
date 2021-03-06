package com.ptitshop.models;

import com.ptitshop.entities.Product;

public class Cart {
	private int quantity;
	private Product product;

	public Cart() {
		super();
	}

	public Cart(int quantity, Product product) {
		super();
		this.quantity = quantity;
		this.product = product;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

}
