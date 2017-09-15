package com.ptitshop.dao;

import java.util.List;

import com.ptitshop.entities.ProductImage;

public interface ProductImageDAO {

	public List<ProductImage> findByProducDetailtId(int productDetailId);
	public boolean insert(ProductImage image);
	public boolean update(ProductImage image);
	public boolean remove(ProductImage image);
}
