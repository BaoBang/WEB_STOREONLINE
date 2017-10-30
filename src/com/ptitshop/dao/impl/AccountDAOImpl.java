package com.ptitshop.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.transaction.annotation.Transactional;

import com.ptitshop.dao.AccountDAO;
import com.ptitshop.entities.Account;
import com.ptitshop.utils.Constants;

@Transactional
public class AccountDAOImpl implements AccountDAO {
	private SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	public Account findById(int idAccount) {
		Session session = sessionFactory.getCurrentSession();
		Account account = session.find(Account.class, idAccount);
		return account;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean checkUserName(String userName) {
		Session session = sessionFactory.getCurrentSession();
		Query<Object> query = session.createQuery("select count(a) from Account a where a.userName=:userName");
		query.setParameter("userName", userName);
		int numberRow = Integer.parseInt(String.valueOf(query.getSingleResult()));
		return numberRow > 0 ? true : false;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Account findByUserName(String userName) {
		Session session = sessionFactory.getCurrentSession();
		Query<Account> query = session.createQuery("select account from Account account where account.userName=:userName");
		query.setParameter("userName", userName);
		query.setMaxResults(1);
		return query.getSingleResult();
	}

	@Override
	public boolean insert(Account account) {
		try {
			Session sesion = sessionFactory.openSession();
			sesion.beginTransaction();
			sesion.save(account);
			sesion.getTransaction().commit();
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	@Override
	public boolean update(Account account) {
		try {
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			session.saveOrUpdate(account);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	@Override
	public void updateRole(Account account, String role) {
		Session session = sessionFactory.getCurrentSession();
		account.setRole(role);
		session.merge(account);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Account> findAll() {
		Session session = sessionFactory.getCurrentSession();
		Query<Account> query = session.getNamedQuery("Account.findAll");
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Account> findAllByPagination(int page) {
		Session session = sessionFactory.getCurrentSession();
		Query<Account> query = session.createNamedQuery("Account.findAll");
		query.setFirstResult((page - 1) * Constants.NUMBER_ACCOUNT_IN_PAGE);
		query.setMaxResults(Constants.NUMBER_ACCOUNT_IN_PAGE);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public String getRoles(String userName) {
		Session session = sessionFactory.getCurrentSession();
		Query<Account> query = session.createQuery("select a from Account a where a.userName=:userName");
		query.setParameter("userName", userName);
		Account account = query.getResultList().size() > 0 ? query.getResultList().get(0) : null;
		
		return account == null ? "" : account.getRole();
	}

	@Override
	public void add(Account account) {
		Session session = sessionFactory.getCurrentSession();
		session.persist(account);
	}

	@Override
	public void delete(Account account) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(account);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Account> findNews(int quantity) {
		Session session = sessionFactory.getCurrentSession();
		Query<Account> query = session.createNamedQuery("Account.findNews");
		query.setMaxResults(quantity);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public int getTotalAccounts() {
		Session session = sessionFactory.getCurrentSession();
		Query<Object> query = session.createNamedQuery("Account.getTotalAccounts");
		query.setMaxResults(1);
		int totalAccounts = Integer.parseInt(String.valueOf(query.getSingleResult()));
		return totalAccounts;
	}

	@Override
	public void updateAccount(Account account) {
		Session session = sessionFactory.getCurrentSession();
		session.merge(account);
	}

}
