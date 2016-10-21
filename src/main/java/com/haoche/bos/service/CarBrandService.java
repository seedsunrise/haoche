package com.haoche.bos.service;

import com.basedata.remoting.dto.CarBrandDTO;
import com.basedata.remoting.dto.PageNateDTO;
import com.basedata.remoting.exceptions.CarBrandExistException;
import com.basedata.remoting.exceptions.CarBrandNotExistException;
import com.basedata.remoting.stub.CarBrandInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;
import java.util.List;

/**
 * Created by tiger on 2016/5/9.
 */
@Service("carBrandService")
public class CarBrandService {

    @Autowired
    private CarBrandInterface carBrandInterface;

    /**
     * 保存品牌
     * @param carBrandDTO
     * @throws RemoteException
     * @throws CarBrandExistException
     * */
    public void save(CarBrandDTO carBrandDTO) throws RemoteException, CarBrandExistException {
        carBrandInterface.save(carBrandDTO);
    }

    /**
     * 获取品牌
     * @param carBrandId
     * @throws RemoteException
     * @throws CarBrandNotExistException
     * */
    public CarBrandDTO getCarBrandById(Long carBrandId) throws RemoteException, CarBrandNotExistException {
        return carBrandInterface.getCarBrandById(carBrandId);
    }

    /**
     * 获取品牌
     * @param pageNo
     * @param pageSize
     * @throws RemoteException
     * */
    public PageNateDTO getCarBrandList(int pageNo, int pageSize) throws RemoteException{
        return carBrandInterface.getCarBrandList(pageNo,pageSize);
    }

    /**
     * 获取品牌列表
     * @param brandName 品牌名称
     * @throws RemoteException
     * */
    public List<CarBrandDTO> getCarBrandListByName(String brandName) throws RemoteException{
        return carBrandInterface.getCarBrandListByName(brandName);
    }

    /**
     * 获取品牌列表
     * @param brandName
     * @param pageNo
     * @param pageSize
     * @throws RemoteException
     * */
    public PageNateDTO getCarBrandListByBrandName(String brandName, int pageNo, int pageSize) throws RemoteException{
        return carBrandInterface.getCarBrandListByBrandName(brandName, pageNo, pageSize);
    }

    /**
     * 获取品牌列表
     * @param brandChar
     * @param pageNo
     * @param pageSize
     * @throws RemoteException
     * */
    public PageNateDTO getCarBrandListByBrandChar(String brandChar, int pageNo, int pageSize) throws RemoteException{
        return carBrandInterface.getCarBrandListByBrandChar(brandChar, pageNo, pageSize);
    }

    public void delete(Long id) throws RemoteException, CarBrandNotExistException, CarBrandExistException {
        carBrandInterface.delete(id);
    }
}
