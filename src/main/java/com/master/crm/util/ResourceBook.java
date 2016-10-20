package com.master.crm.util;

import com.master.crm.enums.ResourceBookType;

public interface ResourceBook {

    boolean book(ResourceBookType type, String value);

    boolean hasBooked(ResourceBookType type, String value);

}
