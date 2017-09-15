package com.ptitshop.dao;

import com.ptitshop.entities.ProductDetail;

public interface ProductDetailDAO {
	public ProductDetail findById(int id);
	public boolean insert(ProductDetail detail);
	public boolean update(ProductDetail detail);
	public boolean remove(ProductDetail detail);
}
