package com.haoche.bos.service;

import com.haoche.remoting.dto.PageNateDTO;
import com.haoche.remoting.stub.FeedBackInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;

/**
 * 消息反馈
 * Created by allan on 2016/8/9.
 */
@Service("feedBackService")
public class FeedBackService {
    @Autowired
    FeedBackInterface feedBackInterface;

    public PageNateDTO getList(int pageNo, int pageSize) throws RemoteException {
        PageNateDTO page = this.feedBackInterface.getFeedBackList(pageNo,pageSize);
        return page;
    }
}
