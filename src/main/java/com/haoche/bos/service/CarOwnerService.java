package com.haoche.bos.service;

import com.haoche.carowner.remoting.dto.CarInfoDTO;
import com.haoche.carowner.remoting.dto.CarOwnerDTO;
import com.haoche.carowner.remoting.dto.PageNateDTO;
import com.haoche.carowner.remoting.dto.query.CarOwnerQuery;
import com.haoche.carowner.remoting.exceptions.CarVinExitException;
import com.haoche.carowner.remoting.exceptions.OwnerExistException;
import com.haoche.carowner.remoting.stub.CarInfoInterface;
import com.haoche.carowner.remoting.stub.CarOwnerInterface;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;

/**
 * Created by sirius on 2016/9/19.
 */
@Service("carOwnerService")
public class CarOwnerService {
    @Autowired
    CarOwnerInterface carOwnerInterface;
    @Autowired
    CarInfoInterface carInfoInterface;

    /**
     * 手动保存车主
     *
     * @param carOwner
     * @param carInfo
     * @return
     */
    public CarOwnerDTO save(CarOwnerDTO carOwner, CarInfoDTO carInfo) throws RemoteException, OwnerExistException, CarVinExitException {
        carOwner = carOwnerInterface.save(carOwner);
        try {
            carInfo.setCarOwnerId(carOwner.getId());
            carInfoInterface.save(carInfo);
        } catch (CarVinExitException e) {
            if (carOwner != null) {
                carOwnerInterface.delete(carOwner.getId());
            }
            throw e;
        }
        return carOwnerInterface.get(carOwner.getId());
    }


    /**
     * 手动保存车主
     *
     * @param carOwner
     * @param carInfo
     * @return
     */
    public CarOwnerDTO update(CarOwnerDTO carOwner, CarInfoDTO carInfo) throws RemoteException, OwnerExistException, CarVinExitException {
        carOwnerInterface.updateSelective(carOwner);
        try {
            if (carInfo.getId() == null) {
                carInfo.setCarOwnerId(carOwner.getId());
                carInfoInterface.save(carInfo);
            } else {
                carInfoInterface.updateSelective(carInfo);
            }
        } catch (CarVinExitException e) {
            throw new CarVinExitException(e.getMessage());
        }
        return carOwnerInterface.get(carOwner.getId());
    }

    /**
     * 获取车主列表
     *
     * @param query 筛选条件封装对象
     * @return
     */
    public PageNateDTO getCarOwnerList(CarOwnerQuery query) throws RemoteException {
        return carOwnerInterface.getPageList(query);
    }


    public CarOwnerDTO getCarOwner(Long id) throws RemoteException {
        return carOwnerInterface.get(id);
    }

    public int delete(Long id) throws RemoteException {
        CarOwnerDTO carOwnerDTO = this.getCarOwner(id);
        if (carOwnerDTO.getCarInfos() != null && carOwnerDTO.getCarInfos().get(0) != null) {
            carInfoInterface.logicalDelete(carOwnerDTO.getCarInfos().get(0).getId());
        }
        return carOwnerInterface.logicalDelete(id);
    }
}
