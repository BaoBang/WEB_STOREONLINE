package com.ptitshop.models;

import java.util.ArrayList;
import java.util.List;

import com.ptitshop.entities.Category;

public class CategoryChildren extends Category{
	private static final long serialVersionUID = 1L;
	private List<Category>  categoryChirens = new ArrayList<>();

	public CategoryChildren(Category category) {
	}

	public List<Category> getCategoryChirens() {
		return categoryChirens;
	}

	public void setCategoryChirens(List<Category> categoryChirens) {
		this.categoryChirens = categoryChirens;
	}
	
	public void addCategory(Category category){
		categoryChirens.add(category);
	}
}
