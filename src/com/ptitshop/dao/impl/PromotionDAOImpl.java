package com.ptitshop.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.transaction.annotation.Transactional;

import com.ptitshop.dao.PromotionDAO;
import com.ptitshop.entities.Promotion;
@Transactional
public class PromotionDAOImpl implements PromotionDAO {
	private SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Promotion> findByStatus(int status) {
		Session session = sessionFactory.getCurrentSession();
		Query<Promotion> query = session.createQuery("select p from Promotion p where p.status=:status");
		query.setParameter("status", status);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public Promotion findById(int id) {
		Session session = sessionFactory.getCurrentSession();
		Query<Promotion> query = session.createQuery("select p from Promotion p where p.id=:id");
		query.setParameter("id", id);
		return query.getResultList().size() > 0 ? query.getResultList().get(0) : null;
	}

	@Override
	public boolean insert(Promotion promotion) {
		try {
			Session sesion = sessionFactory.openSession();
			sesion.beginTransaction();
			sesion.saveOrUpdate(promotion);
			sesion.getTransaction().commit();
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	@Override
	public boolean update(Promotion promotion) {
		try {
			Session sesion = sessionFactory.openSession();
			sesion.beginTransaction();
			sesion.saveOrUpdate(promotion);
			sesion.getTransaction().commit();
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	@Override
	public boolean remove(Promotion promotion) {
		try {
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			session.delete(promotion);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			return false;
		}
	}
}
