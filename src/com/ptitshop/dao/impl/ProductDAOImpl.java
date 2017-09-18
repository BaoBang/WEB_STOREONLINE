package com.ptitshop.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.transaction.annotation.Transactional;
import com.ptitshop.dao.ProductDAO;
import com.ptitshop.entities.Product;
import com.ptitshop.utils.Constants;

@Transactional
public class ProductDAOImpl implements ProductDAO {
	private SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	public Product findById(int productId) {
		Session session = sessionFactory.getCurrentSession();
		return session.find(Product.class, productId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Product> findByCategoryId(int categoryId, int page) {
		Session session = sessionFactory.getCurrentSession();
		Query<Product> query = session.createNamedQuery("Product.findByCategoryId");
		query.setParameter("categoryId", categoryId);
		query.setParameter("status", Product.STATUS_PUBLISH);
		query.setFirstResult((page - 1) * Constants.NUMBER_PRODUCTS_IN_PAGE);
		query.setMaxResults(Constants.NUMBER_PRODUCTS_IN_PAGE);

		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public int getTotalPageByCategoryId(int categoryId) {
		Session session = sessionFactory.getCurrentSession();

		Query<Object> query = session.createNamedQuery("Product.getTotalProductByCategoryId");
		query.setParameter("categoryId", categoryId);
		query.setParameter("status", Product.STATUS_PUBLISH);
		query.setMaxResults(1);
		
		int totalProduct = Integer.parseInt(query.getSingleResult().toString());
		int totalPage = (totalProduct / Constants.NUMBER_PRODUCTS_IN_PAGE) + (totalProduct % Constants.NUMBER_PRODUCTS_IN_PAGE == 0 ? 0 : 1);
		
		return totalPage;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Product> findByCategoryId(int status, int categoryId, int brandId, String orderBy, int page) {
		Session session = sessionFactory.getCurrentSession();
		
		String hql = "SELECT p FROM Product p WHERE p.status=" + status;
		hql = hql + " AND p.category.id=" + categoryId;
		if (brandId > 0) hql += " AND p.brand.id=" + brandId;
		hql = hql + " ORDER BY p.salePrice " + orderBy;
		
		System.out.println("## " + hql);
		
		Query<Product> query = session.createQuery(hql);
		query.setFirstResult((page - 1) * Constants.NUMBER_PRODUCTS_IN_PAGE);
		query.setMaxResults(Constants.NUMBER_PRODUCTS_IN_PAGE);
		
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public int getTotalPageByCategoryId(int status, int categoryId, int brandId) {
		Session session = sessionFactory.getCurrentSession();
		
		String hql = "SELECT COUNT(p) FROM Product p WHERE p.status=" + status;
		hql = hql + " AND p.category.id=" + categoryId;
		if (brandId > 0) hql += " AND p.brand.id=" + brandId;
		
		System.out.println("## " + hql);
		
		Query<Object> query = session.createQuery(hql);
		query.setMaxResults(1);
		
		int totalProduct = Integer.parseInt(query.getSingleResult().toString());
		int totalPage = (totalProduct / Constants.NUMBER_PRODUCTS_IN_PAGE) + (totalProduct % Constants.NUMBER_PRODUCTS_IN_PAGE == 0 ? 0 : 1);
		
		return totalPage;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Product> getTopProductByCategoryId(int categotyId, int status) {
		Session session = sessionFactory.getCurrentSession();
		String queryString = "SELECT p FROM Product p WHERE p.category.id=:categoryId and p.status=:status ORDER BY p.createdAt DESC";
		Query<Product> query = session.createQuery(queryString);
		query.setParameter("status", status);
		query.setParameter("categoryId", categotyId);
		return query.setMaxResults(Constants.TOP_PRODUCT).getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Product> findAllByPagination(int page) {
		Session session = sessionFactory.getCurrentSession();
		Query<Product> query = session.createNamedQuery("Product.findAll");
		query.setFirstResult((page - 1) * Constants.NUMBER_POST_IN_PAGE);
		query.setMaxResults(Constants.NUMBER_POST_IN_PAGE);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public int getTotalPage() {
		Session session = sessionFactory.getCurrentSession();
		Query<Object> query = session.createQuery("select count(product) from Product product");
		query.setMaxResults(1);
		
		int totalBrand = Integer.parseInt(query.getSingleResult().toString());
		int totalPage = totalBrand / Constants.NUMBER_POST_IN_PAGE + (totalBrand % Constants.NUMBER_POST_IN_PAGE == 0 ? 0 : 1);
		
		return totalPage;
	}

	@Override
	public boolean insert(Product product) {
		try {
			Session sesion = sessionFactory.openSession();
			sesion.beginTransaction();
			sesion.save(product);
			sesion.getTransaction().commit();
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	@Override
	public boolean update(Product product) {
		try {
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			session.update(product);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	@Override
	public boolean remove(Product product) {
		try {
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			session.delete(product);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	@Override
	public void merge(Product product) {
		Session session = sessionFactory.getCurrentSession();
		//session.saveOrUpdate(product);
		session.merge(product);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Product> searchByName(String name) {
		Session session = sessionFactory.getCurrentSession();
		Query<Product> query = session.createQuery("select p from Product p where p.name like :name");
		query.setParameter("name", "%" + name +  "%");
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Product> findAll() {
		Session session = sessionFactory.getCurrentSession();
		Query<Product> query = session.createQuery("select p from Product p");
		return query.getResultList();
	}


}
