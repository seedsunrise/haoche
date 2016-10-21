package com.haoche.bos.service;

import com.basedata.remoting.dto.CarModelDTO;
import com.basedata.remoting.dto.PageNateDTO;
import com.basedata.remoting.stub.CarModelInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;
import java.util.List;
import java.util.Map;

/**
 * 系统设置-车型设置
 * Created by tiger on 2016/5/10.
 */
@Service("carModelService")
public class CarModelService {

    @Autowired
    private CarModelInterface carModelInterface;

    /**
     * 保存车型（添加、修改）
     * @param carModelDTO
     * @throws RemoteException
     * */
    public void save(CarModelDTO carModelDTO) throws RemoteException {
        carModelInterface.save(carModelDTO);
    }

    /**
     * 获取车型
     * @param carModelId
     * @throws RemoteException
     * */
    public CarModelDTO getCarModelById(Long carModelId) throws RemoteException {
        return carModelInterface.getCarModelById(carModelId);
    }

    /**
     * 获取车型列表
     * @param pageNo
     * @param pageSize
     * @throws RemoteException
     * */
    public PageNateDTO getCarModelList(int pageNo, int pageSize) throws RemoteException {
        return carModelInterface.getCarModelList(pageNo,pageSize);
    }

    /**
     * 获取车型列表
     * @param modelName
     * @throws RemoteException
     * */
    public List<CarModelDTO> getCarModelListByName(String modelName) throws RemoteException {
        return carModelInterface.getCarModelListByName(modelName);
    }

    /**
     * 获取车型列表
     * @param brandName
     * @param pageNo
     * @param pageSize
     * @throws RemoteException
     * */
    public PageNateDTO getCarModelListByName(String brandName, int pageNo, int pageSize) throws RemoteException {
        return carModelInterface.getCarModelListByName(brandName, pageNo, pageSize);
    }

    public List<CarModelDTO> getCarModelListByCarLineId(Long carLineId) throws RemoteException{
        return carModelInterface.getCarModelByCarLineId1(carLineId);
    }

    public void delete(Long id) throws RemoteException {
        carModelInterface.delete(id);
    }

    public List<Map> getCarModelByYear(Long id)throws RemoteException{
        return carModelInterface.getCarModelByYear(id);
    }
}
