package com.haoche.bos.service;

import com.haoche.userauth.remoting.dto.PageNateDTO;
import com.haoche.userauth.remoting.dto.UserInfoDTO;
import com.haoche.userauth.remoting.stub.UserInfoInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;
import java.util.Map;

/**
 * Created by he on 2016/7/28.
 */
@Service("userInfoService")
public class UserInfoService {
    @Autowired
    private UserInfoInterface userInfoInterface;

    /**
     * 手动保存车主
     * @param userInfoDTO
     * @return
     */
    public UserInfoDTO save(UserInfoDTO userInfoDTO) throws RemoteException {
        return this.userInfoInterface.save(userInfoDTO);
    }

    /**
     * 获取车主列表
     * @param parameter 筛选字段（字段对应）
     * @param sort 排序字段。key为字段名，value为排序规则即desc或asc
     * @param pageNo
     * @param pageSize
     * @return
     */
    public PageNateDTO getUserInfoList(Map<String,Object> parameter, Map<String,String> sort, int pageNo, int pageSize) throws RemoteException {
        return this.userInfoInterface.getUserInfoList(parameter,sort,pageNo,pageSize);
    }

    public UserInfoDTO getUserInfo(Long id) throws RemoteException{
        return this.userInfoInterface.getUserInfo(id);
    }

    public UserInfoDTO delete(Long userInfoId) throws RemoteException {
        return this.userInfoInterface.delete(userInfoId);
    }
}
