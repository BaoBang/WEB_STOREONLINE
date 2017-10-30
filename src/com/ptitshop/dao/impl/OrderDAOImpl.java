package com.ptitshop.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.transaction.annotation.Transactional;

import com.ptitshop.dao.OrderDAO;
import com.ptitshop.entities.Order;
import com.ptitshop.utils.Constants;

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

	@SuppressWarnings("unchecked")
	@Override
	public List<Order> findByPagination(int page) {
		Session session = sessionFactory.getCurrentSession();
		Query<Order> query = session.createNamedQuery("Order.findOrderByCreated");
		query.setFirstResult((page - 1) * Constants.NUMBER_ORDER_IN_PAGE);
		query.setMaxResults(Constants.NUMBER_ORDER_IN_PAGE);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public int getTotalPage() {
		Session session = sessionFactory.getCurrentSession();
		Query<Object> query = session.createNamedQuery("Order.getTotalPage");
		query.setMaxResults(1);
		int totalOrder = Integer.parseInt(query.getSingleResult().toString());
		int totalPage = (totalOrder / Constants.NUMBER_ORDER_IN_PAGE) + (totalOrder % Constants.NUMBER_ORDER_IN_PAGE == 0 ? 0 : 1);
		return totalPage;
	}

	@Override
	public Order findById(int id) {
		Session session = sessionFactory.getCurrentSession();
		return session.find(Order.class, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Order> findLatestOrders(int quantity) {
		Session session = sessionFactory.getCurrentSession();
		Query<Order> query = session.createNamedQuery("Order.findOrderByCreated");
		query.setMaxResults(quantity);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public int getToltalOrders() {
		Session session = sessionFactory.getCurrentSession();
		Query<Object> query = session.createNamedQuery("Order.getTotalOrders");
		query.setMaxResults(1);
		int totalOrders = Integer.parseInt(String.valueOf(query.getSingleResult()));
		return totalOrders;
	}

	@Override
	public void update(Order order) {
		Session session = sessionFactory.getCurrentSession();
		session.merge(order);
	}
}
