package com.nono.dq.model.response;

import java.util.List;

/**
 * 
 * @param <T>
 */
public class ResultList<T> extends ResponseResult {

    private List<T> itemList;

    public ResultList() {
        super();
    }
    
    public ResultList(List<T> itemList) {
        super();
        this.itemList = itemList;
    }

    public ResultList(Integer status, String message, List<T> itemList) {
        super(status, message);
        this.itemList = itemList;
    }

    public List<T> getItemList() {
        return itemList;
    }

    public void setItemList(List<T> itemList) {
        this.itemList = itemList;
    }
}



