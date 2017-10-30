package com.ptitshop.dao;

import com.ptitshop.entities.AccountProfile;

public interface AccountProfileDAO {
	public AccountProfile findById(int accountProfileId);
	public boolean insert(AccountProfile accountProfile);
	public boolean update(AccountProfile accountProfile);
	public void add(AccountProfile accountProfile);
	public void delete(AccountProfile accountProfile);
	public void updateAccountProfile(AccountProfile accountProfile);
}
