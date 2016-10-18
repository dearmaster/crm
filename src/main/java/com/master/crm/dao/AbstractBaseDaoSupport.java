package com.master.crm.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

public abstract class AbstractBaseDaoSupport<T> implements BaseDaoInterface<T> {

    @Autowired
    protected SessionFactory sessionFactory;

    @Override
    public void save(T t) {
        Session session = getSession();
        session.save(t);
    }

    @Override
    public void del(T t) {
        Session session = getSession();
        session.delete(t);
    }

    @Override
    public void upd(T t) {
        Session session = getSession();
        session.update(t);
    }

    public Set<T> loadAll(Class<T> c) {
        String hql = "from " + c.getSimpleName();
        Session session = getSession();
        List<T> list = session.createQuery(hql).list();
        return new HashSet<>(list);
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    protected final Session getSession() {
        return sessionFactory.getCurrentSession();
    }

}
