package com.ptitshop.dao.impl;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.transaction.annotation.Transactional;

import com.ptitshop.dao.OrderDetailDAO;
import com.ptitshop.entities.OrderDetail;

@Transactional
public class OrderDetailDAOImpl implements OrderDetailDAO {
	private SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	public void add(OrderDetail orderDetail) {
		Session session = sessionFactory.getCurrentSession();
		session.persist(orderDetail);
	}
}
