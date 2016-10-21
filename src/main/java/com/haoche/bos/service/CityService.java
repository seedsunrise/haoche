package com.haoche.bos.service;

import com.haoche.remoting.dto.CityDTO;
import com.haoche.remoting.dto.PageNateDTO;
import com.haoche.remoting.stub.CityInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;
import java.util.List;

/**
 * 系统设置-城市设置服务
 * Created by allan on 2016/5/5.
 */
@Service("cityService")
public class CityService {
    @Autowired
    private CityInterface cityInterface;

    /**
     * 保存城市（添加、修改）
     * @param cityDTO 城市DTO
     * @throws RemoteException
     */
    public void save(CityDTO cityDTO) throws RemoteException {
        this.cityInterface.save(cityDTO);
    }

    /**
     * 获取城市
     * @param cityId 城市id
     * @return
     * @throws RemoteException
     */
    public CityDTO getCityById(Long cityId) throws RemoteException{
        return this.cityInterface.getCityById(cityId);
    }

    /**
     * 获取城市列表
     * @param pageNo 当前页数
     * @param pageSize 每页数量
     * @return
     * @throws RemoteException
     */
    public PageNateDTO getCityList(int pageNo, int pageSize) throws RemoteException {
        return this.cityInterface.getCityList(pageNo,pageSize);
    }

    /**
     * 获取城市列表
     * @param cityName 城市名称
     * @return
     * @throws RemoteException
     */
    public List<CityDTO> getCityListByName(String cityName) throws RemoteException {
        return this.cityInterface.getCityListByName(cityName);
    }

    /**
     * 获取城市列表
     * @param cityName 城市名称
     * @param pageNo 当前页数
     * @param pageSize 每页数量
     * @return
     * @throws RemoteException
     */
    public PageNateDTO getCityListByName(String cityName, int pageNo, int pageSize) throws RemoteException {
        return this.cityInterface.getCityListByName(cityName,pageNo,pageSize);
    }

    /**
     * 删除城市
     * @param id
     * */
    public void delete(Long id) throws RemoteException {
        this.cityInterface.delete(id);
    }
}
