package com.master.crm.dao.impl;

import com.master.crm.dao.AbstractBaseDaoSupport;
import com.master.crm.dao.CredentialDao;
import com.master.crm.model.Credential;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.IncorrectResultSetColumnCountException;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository("credentialDao")
public class CredentialDaoImpl extends AbstractBaseDaoSupport<Credential> implements CredentialDao {

    private static final String HQL_CREDENTIAL_FIND_BY_USERNAME = "from Credential where username = :username";

    @Override
    public Set<Credential> loadAll() {
        return super.loadAll(Credential.class);
    }

    @Override
    public Credential findByUsername(String username) {
        Session session = this.getSession();
        List<Credential> list = session.createQuery(HQL_CREDENTIAL_FIND_BY_USERNAME).setParameter("username", username).list();
        if(list != null && list.size() > 0) {
            if(list.size() == 1)
                return list.get(0);
            else
                throw new IncorrectResultSetColumnCountException(1, list.size());
        }
        return null;
    }
}
