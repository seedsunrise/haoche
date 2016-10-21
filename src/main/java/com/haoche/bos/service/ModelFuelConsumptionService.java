package com.haoche.bos.service;

import com.haoche.remoting.dto.PageNateDTO;
import com.haoche.remoting.dto.capp.ModelFuelConsumptionDTO;
import com.haoche.remoting.stub.capp.ModelFuelConsumptionInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;

/**
 * 车型油耗服务
 * Created by allan on 2016/7/12.
 */
@Service("modelFuelConsumptionService")
public class ModelFuelConsumptionService {
    @Autowired
    ModelFuelConsumptionInterface modelFuelConsumptionInterface;

    /**
     * 查询已购买车型中未设置油耗的车型
     * @return
     */
    public PageNateDTO queryNoSetModel(int pageNo, int pageSize) throws RemoteException {
        return this.modelFuelConsumptionInterface.queryNoSetModel(pageNo,pageSize);
    }

    /**
     * 获取车型油耗列表
     * @param modelName
     * @param pageNo
     * @param pageSize
     * @return
     */
    public PageNateDTO getModelFuelConsumptionList(String modelName, int pageNo, int pageSize) throws RemoteException {
        return this.modelFuelConsumptionInterface.getModelFuelConsumptionList(modelName,pageNo,pageSize);
    }

    /**
     * 新增或更新
     * @param modelFuelConsumptionDTO
     * @return
     */
    public ModelFuelConsumptionDTO save(ModelFuelConsumptionDTO modelFuelConsumptionDTO) throws RemoteException {
        return this.modelFuelConsumptionInterface.save(modelFuelConsumptionDTO);
    }

    public ModelFuelConsumptionDTO getModelFuelConsumption(Long id) throws RemoteException {
        return this.modelFuelConsumptionInterface.getModelFuelConsumption(id);
    }

    public void deleteModelFuelConsumption(Long id) throws RemoteException {
        this.modelFuelConsumptionInterface.deleteModelFuelConsumption(id);
    }
}
