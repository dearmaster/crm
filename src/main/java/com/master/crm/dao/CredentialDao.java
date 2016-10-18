package com.master.crm.dao;

import com.master.crm.model.Credential;

public interface CredentialDao extends BaseDaoInterface<Credential> {

    Credential findByUsername(String username);

}
