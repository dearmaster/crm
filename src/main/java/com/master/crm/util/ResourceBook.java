package com.master.crm.util;

import com.master.crm.enums.ResourceBookType;

public interface ResourceBook {

    boolean available(ResourceBookType type, String value);

    boolean book(ResourceBookType type, String value);

}
