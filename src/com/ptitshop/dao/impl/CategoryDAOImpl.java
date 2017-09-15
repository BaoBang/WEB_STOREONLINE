package com.ptitshop.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.transaction.annotation.Transactional;

import com.ptitshop.dao.CategoryDAO;
import com.ptitshop.entities.Category;

@Transactional
public class CategoryDAOImpl implements CategoryDAO {

	private SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	public Category findById(int categoryId) {
		Session session = sessionFactory.getCurrentSession();
		return session.find(Category.class, categoryId);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Category findBySlug(String slug) {
		Session session = sessionFactory.getCurrentSession();

		Query<Category> query = session.createNamedQuery("Category.findBySlug");
		query.setParameter("slug", slug);
		query.setMaxResults(1);

		return (query.getResultList().size() > 0) ? query.getSingleResult() : null;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Category> findByStatus(int status) {
		Session session = sessionFactory.getCurrentSession();
		
		Query<Category> query = session.createNamedQuery("Category.findByStatus");
		query.setParameter("status", status);
		
		return query.getResultList();
	}

	
	@SuppressWarnings("unchecked")
	@Override
	public List<Category> findByParentId(int parentId) {
		Session session = sessionFactory.getCurrentSession();
		Query<Category> query = session.createQuery("select c from Category c where c.parentId=:parentId order by c.position asc");	
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Category> findAll() {
		Session session = sessionFactory.getCurrentSession();
		Query<Category> query = session.createNamedQuery("Category.findAll");
		return query.getResultList();
	}


	@Override
	public void add(Category category) {
		Session session = sessionFactory.getCurrentSession();
		session.persist(category);
	}

	@Override
	public void update(Category category) {
		Session session = sessionFactory.getCurrentSession();
		session.merge(category);
	}

	@Override
	public void delete(Category category) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(category);
	}
	

	
}
