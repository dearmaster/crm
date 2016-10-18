package com.master.crm.dao.impl;

import com.master.crm.dao.AbstractBaseDaoSupport;
import com.master.crm.dao.UserDao;
import com.master.crm.model.User;
import org.springframework.stereotype.Repository;

import java.util.Set;

@Repository("userDao")
public class UserDaoImpl extends AbstractBaseDaoSupport<User> implements UserDao {

    public Set<User> loadAll() {
        return super.loadAll(User.class);
    }
}