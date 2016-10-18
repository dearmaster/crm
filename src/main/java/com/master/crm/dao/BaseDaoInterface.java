package com.master.crm.dao;

import java.util.Set;

public interface BaseDaoInterface<T> {

    void save(T t);

    void del(T t);

    void upd(T t);

    Set<T> loadAll();

}
