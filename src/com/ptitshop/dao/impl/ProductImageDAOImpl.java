package com.ptitshop.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.transaction.annotation.Transactional;

import com.ptitshop.dao.ProductImageDAO;
import com.ptitshop.entities.ProductImage;

@Transactional
public class ProductImageDAOImpl implements ProductImageDAO {
	private SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ProductImage> findByProducDetailtId(int productDetailId) {
		Session session = sessionFactory.getCurrentSession();
		
		Query<ProductImage> query = session.createQuery("select p from ProductImage p where p.productDetail.id=:productDetailId");
		query.setParameter("productDetailId", productDetailId);
		return query.getResultList();
	}

	@Override
	public boolean insert(ProductImage image) {
		try {
			Session sesion = sessionFactory.openSession();
			sesion.beginTransaction();
			sesion.saveOrUpdate(image);
			sesion.getTransaction().commit();
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	@Override
	public boolean update(ProductImage image) {
		try {
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			session.saveOrUpdate(image);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	@Override
	public boolean remove(ProductImage image) {
		try {
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			session.delete(image);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			return false;
		}
	}
}
