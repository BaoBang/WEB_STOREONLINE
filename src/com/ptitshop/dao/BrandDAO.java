package com.ptitshop.dao;

import java.util.List;

import com.ptitshop.entities.Brand;

public interface BrandDAO {
	public Brand findById(int brandId);
	public List<Brand> findByStatus(int status);
	public boolean insert(Brand brand);
	public boolean update(Brand brand);
	public boolean remove(Brand brand);
	public List<Brand> findAllByPagination(int page);
	public int getTotalPage();
	public Brand findByBrandName(String brandName);
}
