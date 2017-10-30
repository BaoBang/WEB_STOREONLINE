package com.ptitshop.dao;

import java.util.List;
import com.ptitshop.entities.Promotion;

public interface PromotionDAO {
	public List<Promotion> findByStatus(int status);
	public Promotion findById(int id);
	public List<Promotion> findByStatusandOrderByCreatedAt(int status, int limit);
	
	public boolean insert(Promotion promotion);
	public boolean update(Promotion promotion);
	public boolean remove(Promotion promotion);
	
	public void merge(Promotion promotion);
	public List<Promotion> findAllByPagination(int page);
	public int getTotalPage();
}
