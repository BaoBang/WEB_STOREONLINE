package com.ptitshop.dao;

import java.util.List;

import com.ptitshop.entities.Product;

public interface ProductDAO {
	public Product findById(int productId);
	public List<Product> findByCategoryId(int categoryId, int page);
	public int getTotalPageByCategoryId(int categoryId);
	public List<Product> findByCategoryId(int status, int categoryId, int brandId, String orderBy, int page);
	public int getTotalPageByCategoryId(int status, int categoryId, int brandId);
	public List<Product> getTopProductByCategoryId(int categotyId, int status);
	public List<Product> findAllByPagination(int page);
	public int getTotalPage();
	public List<Product> findAll();
	public boolean insert(Product product);
	public boolean update(Product product);
	public boolean remove(Product product);
	public List<Product> searchByName(String name);
	
	public void merge(Product product);
	
	public List<Product> searchByName(String q, int page);
	public int getTotalPageBySearchName(String q);
	
	public List<Product> findRecentlyAddedProducts(int quantity);
	public int getTotalProducts();
	
	public void updateNumberViews(int productId);
	public int getTotalProductByCategoryId(int categoryId);
	
}
