package com.master.crm.util.impl;

import com.master.crm.dao.CredentialDao;
import com.master.crm.enums.ResourceBookType;
import com.master.crm.model.Credential;
import com.master.crm.util.ResourceBook;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.concurrent.locks.ReentrantReadWriteLock;

@Transactional
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

                //remove the resources for the certain type booked previously
                Iterator<Map.Entry<String, String>> it = resource.entrySet().iterator();
                while (it.hasNext()) {
                    Map.Entry<String, String> entry = it.next();
                    if(this.getSession().getId().equals(entry.getValue())) {
                        resource.remove(entry.getKey());
                    }
                }

                //book the resource and put the mapping relation to the bookedResources
                resource.put(value, this.getSession().getId());
                return true;
            } finally {
                lock.writeLock().unlock();
            }
        }

        return false;

    }

    @Override
    public boolean hasBooked(ResourceBookType type, String value) {
        String currentSesionId = getSession().getId();
        return currentSesionId.equals(loockupContext(type, value));
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

    public boolean available(ResourceBookType type, String value) {
        return this.availableInDb(type, value) && this.availableInContext(type, value);
    }

    private boolean availableInContext(ResourceBookType type, String value) {
        String bookedSessionIdIn = loockupContext(type, value);
        String currentSessionId = this.getSession().getId();
        boolean ret = (bookedSessionIdIn==null || bookedSessionIdIn.equals(currentSessionId));
        return ret;
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
