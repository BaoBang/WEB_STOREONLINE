package com.ptitshop.dao;

import com.ptitshop.entities.AccountProfile;

public interface AccountProfileDAO {
	public AccountProfile findById(int accountProfileId);
	public boolean insert(AccountProfile accountProfile);
	public boolean update(AccountProfile accountProfile);
}
