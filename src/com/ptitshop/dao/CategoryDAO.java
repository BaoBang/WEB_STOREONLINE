package com.ptitshop.dao;

import java.util.List;

import com.ptitshop.entities.Category;

public interface CategoryDAO {
	public List<Category> findAll();
	public Category findById(int categoryId);
	public Category findBySlug(String slug);
	public List<Category> findByStatus(int status);
	public List<Category> findByParentId(int parentId);
	
	public void add(Category category);
	public void update(Category category);
	public void delete(Category category);
 }
