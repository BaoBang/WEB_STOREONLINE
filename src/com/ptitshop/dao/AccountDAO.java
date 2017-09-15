package com.ptitshop.dao;

import java.util.List;

import com.ptitshop.entities.Account;

public interface AccountDAO {
	public List<Account> findAll();
	public List<Account> findAllByPagination(int page);
	public Account findById(int idAccount);
	public Account findByUserName(String userName);
	/*public Account login(String userName, String password);*/
	public boolean insert(Account account);
	public boolean update(Account account);
	public boolean checkUserName(String userName);
	public void updateRole(Account account, String role);
}
