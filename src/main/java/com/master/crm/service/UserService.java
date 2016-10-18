package com.master.crm.service;

import com.master.crm.model.Credential;
import com.master.crm.model.User;

import java.util.Set;

public interface UserService {

    void register(User user, Credential credential);

    void del(User user);

    void upd(User user);

    User find(String username);

    Set<User> loadAll();

}
