package com.haoche.bos.service;
import com.haoche.carmaintain.remoting.dto.PageNateDTO;
import com.haoche.carmaintain.remoting.dto.UserServiceProjectDTO;
import com.haoche.carmaintain.remoting.stub.UserServiceProjectInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;
import java.util.List;

/**
 * Created by tiger on 2016/8/2.
 */
@Service("userServiceProjectService")
public class UserServiceProjectService {

    @Autowired
    private UserServiceProjectInterface userServiceProjectInterface;

    /**
     * 保存、修改预约项目
     * @param userServiceProjectDTO 预约项目DTO
     * @throws RemoteException
     * */
    public void save(UserServiceProjectDTO userServiceProjectDTO) throws RemoteException {
        this.userServiceProjectInterface.save(userServiceProjectDTO);
    }

    /**
     * 根据id逻辑删除预约项目
     * @param id
     * @throws RemoteException
     * */
    public void delete(Long id) throws RemoteException {
        this.userServiceProjectInterface.delete(id);
    }

    /**
     * 得到预约项目列表，并完成分页
     * @param pageNo 当前页数
     * @param pageSize 每页大小
     * @throws RemoteException
     * */
    public PageNateDTO getUserServiceProjectList(int pageNo, int pageSize,int type) throws RemoteException {
        return this.userServiceProjectInterface.getUserServiceProjectList(pageNo, pageSize,type);
    }

    /**
     * 根据id得到预约项目
     * @param id
     * @throws RemoteException
     * */
    public UserServiceProjectDTO getById(Long id) throws RemoteException {
        return this.userServiceProjectInterface.getById(id);
    }

    /**
     * 得到所有预约项目
     * @param
     * @throws RemoteException
     * * */
    public List<UserServiceProjectDTO> getAll(int type) throws RemoteException {
        return this.userServiceProjectInterface.getProjectList(type);
    }
}
