package com.ptitshop.dao.impl;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.transaction.annotation.Transactional;

import com.ptitshop.dao.OrderDAO;
import com.ptitshop.entities.Order;

@Transactional
public class OrderDAOImpl implements OrderDAO {
	private SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	public void add(Order order) {
		Session session = sessionFactory.getCurrentSession();
		session.persist(order);
	}
}
