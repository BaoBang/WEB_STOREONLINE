package com.ptitshop.dao;

import java.util.List;

import com.ptitshop.entities.Order;

public interface OrderDAO {
	public void add(Order order);
	public List<Order> findByPagination(int page);
	public int getTotalPage();
	public Order findById(int id);
	public List<Order> findLatestOrders(int quantity);
	public int getToltalOrders();
	public void update(Order order);
}
