package com.haoche.bos.service;

import com.haoche.remoting.dto.CarOperationLogDTO;
import com.haoche.remoting.stub.CarOperationLogInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;
import java.util.List;

/**
 * Created by allan on 2016/5/17.
 */
@Service("carOperationLogService")
public class CarOperationLogService {
    @Autowired
    private CarOperationLogInterface carOperationLogInterface;

    /**
     * 获取车源操作日志列表
     * @param carInfoId 车辆信息id
     * @return
     */
    public List<CarOperationLogDTO> getCarOperationLogDTOList(Long carInfoId) throws RemoteException {
        List<CarOperationLogDTO> list = this.carOperationLogInterface.getCarOperationLogDTOList(carInfoId);
        return list;
    }

    /**
     * 保存操作日志
     * @param carOperationLogDTO 车源操作日志DTO
     * @return
     */
    public CarOperationLogDTO save(CarOperationLogDTO carOperationLogDTO) throws RemoteException {
        return this.carOperationLogInterface.save(carOperationLogDTO);
    }
}
