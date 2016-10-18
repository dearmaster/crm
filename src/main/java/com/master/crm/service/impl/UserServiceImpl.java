package com.master.crm.service.impl;

import com.master.crm.dao.CredentialDao;
import com.master.crm.dao.UserDao;
import com.master.crm.enums.ResourceBookType;
import com.master.crm.enums.UserStatusType;
import com.master.crm.model.Credential;
import com.master.crm.model.User;
import com.master.crm.service.UserService;
import com.master.crm.util.ResourceBook;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.Date;
import java.util.Set;

@Service("userService")
@Transactional
public class UserServiceImpl implements UserService {

    private static final Logger logger = Logger.getLogger(UserServiceImpl.class);

    @Autowired
    private UserDao userDao;
    @Autowired
    private CredentialDao credentialDao;
    @Autowired
    private ResourceBook resourceBook;

    @Override
    public void register(User user, Credential credential) {
        Assert.notNull(user, "user is null");
        Assert.notNull(credential, "credential is null");

        //set default properties for credential
        credential.setRegisterDate(new Date());
        credential.setStatus(UserStatusType.FROZEN);

        resourceBook.book(ResourceBookType.USERNAME, credential.getUsername());
        userDao.save(user);
        credentialDao.save(credential);
    }

    @Override
    public void del(User user) {
        userDao.del(user);
    }

    @Override
    public void upd(User user) {
        userDao.upd(user);
    }

    @Override
    public User find(String username) {
        return null;
    }

    @Override
    public Set<User> loadAll() {
        return userDao.loadAll();
    }

}
