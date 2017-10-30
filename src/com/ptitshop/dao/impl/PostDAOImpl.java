package com.ptitshop.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.transaction.annotation.Transactional;

import com.ptitshop.dao.PostDAO;
import com.ptitshop.entities.Post;
import com.ptitshop.utils.Constants;

@Transactional
public class PostDAOImpl implements PostDAO {
	private SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Post> findAll() {
		Session session = sessionFactory.getCurrentSession();
		Query<Post> query = session.createNamedQuery("Post.findAll");
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Post> findAllByPagination(int page) {
		Session session = sessionFactory.getCurrentSession();
		Query<Post> query = session.createNamedQuery("Post.findAll");
		query.setFirstResult((page - 1) * Constants.NUMBER_POST_IN_PAGE);
		query.setMaxResults(Constants.NUMBER_POST_IN_PAGE);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public int getTotalPage() {
		Session session = sessionFactory.getCurrentSession();
		Query<Object> query = session.createNamedQuery("Post.getTotalPage");
		query.setMaxResults(1);
		
		int totalPost = Integer.parseInt(query.getSingleResult().toString());
		int totalPage = totalPost / Constants.NUMBER_POST_IN_PAGE + (totalPost % Constants.NUMBER_POST_IN_PAGE == 0 ? 0 : 1);
		
		return totalPage;
	}

	@Override
	public Post findById(int postId) {
		Session session = sessionFactory.getCurrentSession();
		return session.find(Post.class, postId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public Post findBySlug(String slug) {
		Session session = sessionFactory.getCurrentSession();
		Query<Post> query = session.createNamedQuery("Post.findBySlug");
		query.setParameter("slug", slug);
		query.setMaxResults(1);
		return query.getSingleResult();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Post> findByStatus(int status, int page) {
		Session session = sessionFactory.getCurrentSession();
		Query<Post> query = session.createNamedQuery("Post.findByStatus");
		query.setParameter("status", status);
		query.setFirstResult((page - 1) * Constants.NUMBER_POST_IN_PAGE);
		query.setMaxResults(Constants.NUMBER_POST_IN_PAGE);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public int getTotalPageByStatus(int status) {
		Session session = sessionFactory.getCurrentSession();
		
		Query<Object> query = session.createNamedQuery("Post.getTotalPageByStatus");
		query.setParameter("status", status);
		query.setMaxResults(1);
		
		int totalPost = Integer.parseInt(query.getSingleResult().toString());
		int totalPage = totalPost / Constants.NUMBER_POST_IN_PAGE + (totalPost % Constants.NUMBER_POST_IN_PAGE == 0 ? 0 : 1);
		
		return totalPage;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Post> getTopByStatus(int status) {
		Session session = sessionFactory.getCurrentSession();
		Query<Post> query = session.createQuery("select p from Post p where p.status=:status order by p.publishDate desc");
		query.setParameter("status", status);
		return query.setMaxResults(Constants.TOP_POST).getResultList();
	}

	@Override
	public void add(Post post) {
		Session session = sessionFactory.getCurrentSession();
		session.persist(post);
	}

	@Override
	public void update(Post post) {
		Session session = sessionFactory.getCurrentSession();
		session.merge(post);
	}

	@Override
	public void delete(Post post) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(post);
	}

	@Override
	public void updateNumberView(Post post) {
		Session session = sessionFactory.getCurrentSession();
		post.setViews(post.getViews() + 1);
		session.merge(post);
	
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Post> findRecentlyAddedPosts(int quantity) {
		Session session = sessionFactory.getCurrentSession();
		Query<Post> query = session.createNamedQuery("Post.findRecentlyAddedPosts");
		query.setMaxResults(quantity);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public int getTotalPosts() {
		Session session = sessionFactory.getCurrentSession();
		Query<Object> query = session.createNamedQuery("Post.getTotalPosts");
		query.setMaxResults(1);
		int totalPosts = Integer.parseInt(String.valueOf(query.getSingleResult()));
		return totalPosts;
	}


}
