package com.ptitshop.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.transaction.annotation.Transactional;
import com.ptitshop.dao.BrandDAO;
import com.ptitshop.entities.Brand;
import com.ptitshop.utils.Constants;

@Transactional
public class BrandDAOImpl implements BrandDAO {
	private SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	public Brand findById(int brandId) {
		Session session = sessionFactory.getCurrentSession();
		return session.find(Brand.class, brandId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Brand> findByStatus(int status) {
		Session session = sessionFactory.getCurrentSession();
		Query<Brand> query = session.createNamedQuery("Brand.findByStatus");
		query.setParameter("status", status);
		return query.getResultList();
	}

	@Override
	public boolean insert(Brand brand) {

		try {
			Session sesion = sessionFactory.openSession();
			sesion.beginTransaction();
			sesion.save(brand);
			sesion.getTransaction().commit();
			return true;
		} catch (Exception e) {
			return false;
		}

	}

	@Override
	public boolean update(Brand brand) {
		try {
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			session.update(brand);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Brand> findAllByPagination(int page) {
		Session session = sessionFactory.getCurrentSession();
		Query<Brand> query = session.createNamedQuery("Brand.findAll");
		query.setFirstResult((page - 1) * Constants.NUMBER_POST_IN_PAGE);
		query.setMaxResults(Constants.NUMBER_POST_IN_PAGE);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public int getTotalPage() {
		Session session = sessionFactory.getCurrentSession();
		Query<Object> query = session.createQuery("select count(brand) from Brand brand");
		query.setMaxResults(1);
		
		int totalBrand = Integer.parseInt(query.getSingleResult().toString());
		int totalPage = totalBrand / Constants.NUMBER_POST_IN_PAGE + (totalBrand % Constants.NUMBER_POST_IN_PAGE == 0 ? 0 : 1);
		
		return totalPage;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Brand findByBrandName(String brandName) {
		brandName.toUpperCase();
		Session session = sessionFactory.getCurrentSession();
		Query<Brand>query = session.createQuery("select b from Brand b where b.name=:brandName");
		query.setParameter("brandName", brandName);
		query.setMaxResults(1);
		return query.getResultList().size() > 0 ? query.getSingleResult() : null;
	}

	@Override
	public boolean remove(Brand brand) {
		try {
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			session.delete(brand);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			return false;
		}
	}
}
