package com.ptitshop.dao.impl;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.transaction.annotation.Transactional;

import com.ptitshop.dao.ProductDetailDAO;
import com.ptitshop.entities.ProductDetail;

@Transactional
public class ProductDetailDAOImpl implements ProductDetailDAO {
	private SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	public ProductDetail findById(int id) {
		Session session = sessionFactory.getCurrentSession();
		return session.find(ProductDetail.class, id);
	}

	@Override
	public boolean insert(ProductDetail detail) {
		try {
			Session sesion = sessionFactory.openSession();
			sesion.beginTransaction();
			sesion.save(detail);
			sesion.getTransaction().commit();
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	@Override
	public boolean update(ProductDetail detail) {
		try {
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			session.delete(detail);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	@Override
	public boolean remove(ProductDetail detail) {
		// TODO Auto-generated method stub
		return false;
	}
}
