package com.haoche.bos.service;

import com.basedata.remoting.dto.carConfigDTO.CarConfigEntity;
import com.basedata.remoting.exceptions.CarConfigNotExistException;
import com.basedata.remoting.stub.CarConfigInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;

/**
 * 车辆服务
 * Created by allan on 2016/5/20.
 */
@Service("carConfigService")
public class CarConfigService {
    @Autowired
    private CarConfigInterface carConfigInterface;

    public CarConfigEntity getCarConfigByCarModelId(Long carModelId) throws CarConfigNotExistException, RemoteException {
        return this.carConfigInterface.getCarConfigByCarModelId(carModelId);
    }

    public CarConfigEntity getCarConfigByChe168Id(Long che168Id) throws CarConfigNotExistException, RemoteException {
        return this.carConfigInterface.getCarConfigByChe168Id(che168Id);
    }
}
