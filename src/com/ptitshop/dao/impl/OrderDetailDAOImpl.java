package com.ptitshop.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
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

	@SuppressWarnings("unchecked")
	@Override
	public List<OrderDetail> findByOrderId(int orderId) {
		Session session = sessionFactory.getCurrentSession();
		Query<OrderDetail> query = session.createNamedQuery("OrderDetail.findByOrderId");
		query.setParameter("orderId", orderId);
		return query.getResultList();
	}
}
