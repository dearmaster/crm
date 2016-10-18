package com.master.crm.util.impl;

import com.master.crm.dao.CredentialDao;
import com.master.crm.enums.ResourceBookType;
import com.master.crm.model.Credential;
import com.master.crm.util.ResourceBook;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.locks.ReentrantReadWriteLock;

@Component("resourceBook")
public class ResourceBookImpl implements ResourceBook {

    private ReentrantReadWriteLock lock = new ReentrantReadWriteLock();
    private Map<ResourceBookType, Map<String, String>> bookedResources = new HashMap<>();

    @Autowired
    private CredentialDao credentialDao;

    @Override
    public boolean book(ResourceBookType type, String value) {

        if(type == null || value == null) {
            throw new IllegalArgumentException();
        }

        if(available(type, value)) {
            try {
                lock.writeLock().lock();
                Map<String, String> resource = bookedResources.get(type);
                if (resource == null) {
                    resource = new HashMap<String, String>();
                    bookedResources.put(type, resource);
                }
                resource.put(value, this.getSession().getId());
                return true;
            } finally {
                lock.writeLock().unlock();
            }
        }

        return false;

    }

    //look up the bundled session id
    private String loockupContext(ResourceBookType type, String value) {
        HttpSession session = this.getSession();
        try {
            lock.readLock().lock();

            Map<String, String> resource = bookedResources.get(type);
            if(null != resource) {
                return resource.get(value);
            }
        } finally {
            lock.readLock().unlock();
        }
        return null;
    }

    @Override
    public boolean available(ResourceBookType type, String value) {
        return this.availableInDb(type, value) && this.availableInContext(type, value);
    }

    private boolean availableInContext(ResourceBookType type, String value) {
        String sessionId = loockupContext(type, value);
        return (sessionId==null || sessionId.equals(this.getSession().getId()));
    }

    private boolean availableInDb(ResourceBookType type, String value) {
        boolean ret = false;
        switch (type) {
            case USERNAME:
                Credential credential = credentialDao.findByUsername(value);
                ret = (credential == null);
                break;
        }
        return ret;
    }

    public HttpSession getSession() {
        HttpServletRequest request = ServletActionContext.getRequest();
        return request.getSession();
    }

}
