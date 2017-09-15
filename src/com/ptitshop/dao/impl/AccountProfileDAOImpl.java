package com.ptitshop.dao.impl;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.transaction.annotation.Transactional;

import com.ptitshop.dao.AccountProfileDAO;
import com.ptitshop.entities.AccountProfile;

@Transactional
public class AccountProfileDAOImpl implements AccountProfileDAO {
	private SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@SuppressWarnings("unchecked")
	@Override
	public AccountProfile findById(int accountProfileId) {
		Session session = sessionFactory.getCurrentSession();

		Query<AccountProfile> query = session
				.createQuery("select ap from AccountProfile ap where ap.id =:accountProfileId");
		query.setParameter("accountProfileId", accountProfileId);
		query.setMaxResults(1);
		return query.getSingleResult();
	}
	@Override
	public boolean insert(AccountProfile accountProfile) {
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		session.save(accountProfile);
		session.getTransaction().commit();
		
		return true;
	}

	@Override
	public boolean update(AccountProfile accountProfile) {
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		session.saveOrUpdate(accountProfile);

		session.getTransaction().commit();
		return true;
	}
}
