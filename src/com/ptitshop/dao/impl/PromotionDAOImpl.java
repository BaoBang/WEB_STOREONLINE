package com.ptitshop.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.transaction.annotation.Transactional;
import com.ptitshop.dao.PromotionDAO;
import com.ptitshop.entities.Promotion;
import com.ptitshop.utils.Constants;
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
			sesion.save(promotion);
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
			sesion.update(promotion);
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

	@Override
	public void merge(Promotion promotion) {
		Session session = sessionFactory.getCurrentSession();
		session.merge(promotion);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Promotion> findAllByPagination(int page) {
		Session session = sessionFactory.getCurrentSession();
		Query<Promotion> query = session.createNamedQuery("Promotion.findAll");
		query.setFirstResult((page - 1) * Constants.NUMBER_POST_IN_PAGE);
		query.setMaxResults(Constants.NUMBER_POST_IN_PAGE);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public int getTotalPage() {
		Session session = sessionFactory.getCurrentSession();
		Query<Object> query = session.createQuery("select count(promotion) from Promotion promotion");
		query.setMaxResults(1);
		
		int totalPromotion = Integer.parseInt(query.getSingleResult().toString());
		int totalPage = totalPromotion / Constants.NUMBER_POST_IN_PAGE + (totalPromotion % Constants.NUMBER_POST_IN_PAGE == 0 ? 0 : 1);
		
		return totalPage;
	}
}
