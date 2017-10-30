package com.ptitshop.dao;

import java.util.List;

import com.ptitshop.entities.OrderDetail;

public interface OrderDetailDAO {
	public void add(OrderDetail orderDetail);
	public List<OrderDetail> findByOrderId(int orderId);
}
