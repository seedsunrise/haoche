package com.haoche.bos.service;

import com.basedata.remoting.dto.CarSubBrandDTO;
import com.basedata.remoting.dto.PageNateDTO;
import com.basedata.remoting.exceptions.CarSubBrandExistException;
import com.basedata.remoting.exceptions.CarSubBrandNotExistException;
import com.basedata.remoting.stub.CarSubBrandInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;
import java.util.List;

/**
 * Created by tiger on 2016/5/9.
 */
@Service("carSubBrandService")
public class CarSubBrandService {

    @Autowired
    private CarSubBrandInterface carSubBrandInterface;

    /**
     * 保存生产厂商
     * @param carSubBrandDTO
     * @throws RemoteException
     * @throws CarSubBrandExistException
     * */
    public void save(CarSubBrandDTO carSubBrandDTO) throws RemoteException,CarSubBrandExistException {
        carSubBrandInterface.save(carSubBrandDTO);
    }

    /**
     * 获取生产厂商
     * @param carSubBrandId
     * @throws RemoteException
     * @throws CarSubBrandNotExistException
     * */
    public CarSubBrandDTO getCarSubBrandById(long carSubBrandId) throws RemoteException,CarSubBrandNotExistException {
        return carSubBrandInterface.getCarSubBrandById(carSubBrandId);
    }

    /**
     * 获取生产厂商列表
     * @param pageNo
     * @param pageSize
     * @throws RemoteException
     * */
    public PageNateDTO getCarSubBrandList(int pageNo, int pageSize) throws RemoteException{
        return carSubBrandInterface.getCarSubBrandList(pageNo,pageSize);
    }

    /**
     * 获取生产厂商列表
     * @param subBrandName 生产厂商名称
     * @throws RemoteException
     * */
    public List<CarSubBrandDTO> getCarBrandListByName(String subBrandName) throws RemoteException{
        return carSubBrandInterface.getCarSubBrandByName(subBrandName);
    }

    /**
     * 获取生产厂商列表
     * @param subBrandName 生产厂商名称
     * @param pageNo
     * @param pageSize
     * @throws RemoteException
     * */
    public PageNateDTO getCarSubBrandListByBrandName(String subBrandName, int pageNo, int pageSize) throws RemoteException{
        return carSubBrandInterface.getCarSubBrandByName(subBrandName, pageNo, pageSize);
    }

    // 根据车辆品牌id获取厂商列表
    public List<CarSubBrandDTO> getCarSubBrandByCarBrandId(Long carBrandId) throws RemoteException{
        return carSubBrandInterface.getCarSubBrandByCarBrandId(carBrandId);
    }

    public void delete(Long id) throws RemoteException {
        carSubBrandInterface.delete(id);
    }
}
