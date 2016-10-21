package com.haoche.bos.service;

import com.haoche.remoting.dto.*;
import com.haoche.remoting.exceptions.CarSourceException;
import com.haoche.remoting.stub.CarSourceInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;
import java.util.List;
import java.util.Map;

/**
 * Created by allan on 2016/5/20.
 */
@Service("carSourceService")
public class CarSourceService {
    @Autowired
    private CarSourceInterface carSourceInterface;

    /**
     * 添加车源
     * @param carInfoDTO 车辆信息DTO
     * @param carDocumentDTO 车辆档案DTO
     * @param carToolsDTO 随车工具DTO
     * @throws RemoteException
     */
    public void newCarSource(CarInfoDTO carInfoDTO, CarDocumentDTO carDocumentDTO, CarToolsDTO carToolsDTO) throws RemoteException{
        this.carSourceInterface.newCarSource(carInfoDTO,carDocumentDTO,carToolsDTO);
    }

    /**
     * 修改车源
     * @param carInfoDTO 车辆信息DTO
     * @param carDocumentDTO 车辆档案DTO
     * @param carToolsDTO 随车工具DTO
     * @throws RemoteException
     */
    public void updateCarSource(CarInfoDTO carInfoDTO, CarDocumentDTO carDocumentDTO, CarToolsDTO carToolsDTO, EmpListDTO emp) throws RemoteException{
        this.carSourceInterface.updateCarSource(carInfoDTO,carDocumentDTO,carToolsDTO,emp);
    }

    /**
     * 获取车辆信息
     * @param carInfoId 车辆信息id
     * @return
     */
    public CarInfoDTO getCarInfo(Long carInfoId) throws RemoteException{
        return this.carSourceInterface.getCarInfo(carInfoId);
    }

    /**
     * 获取车辆信息列表
     * @param mapParameter 车辆信息查询条件
     * @param sort 排序字段
     * @param sc 排序方式 "desc"倒序，"asc"升序
     * @param search 搜索条件（车辆标题/车架号）
     * @param statusList 车辆状态列表
     * @param pageNo 当前页码
     * @param pageSize 每页大小
     * @return
     */
    public PageNateDTO getCarInfoList(Map<String,Object> mapParameter, String sort, String sc, String search, List statusList, int pageNo, int pageSize) throws RemoteException{
        return this.carSourceInterface.getCarInfoList(mapParameter,sort,sc,search,statusList,pageNo,pageSize);
    }

    /**
     * 获取车辆档案
     * @param carDocumentId 车辆档案id
     * @return
     * @throws RemoteException
     */
    public CarDocumentDTO getCarDocument(Long carDocumentId) throws RemoteException{
        return this.carSourceInterface.getCarDocument(carDocumentId);
    }

    /**
     * 获取车辆档案
     * @param carInfoId 车辆信息id
     * @return
     * @throws RemoteException
     */
    public CarDocumentDTO getCarDocumentByCarInfoId(Long carInfoId) throws RemoteException{
        return this.carSourceInterface.getCarDocumentByCarInfoId(carInfoId);
    }

    /**
     * 获取随车工具
     * @param carTools 随车工具id
     * @return
     * @throws RemoteException
     */
    public CarToolsDTO getCarTools(Long carTools) throws RemoteException{
        return this.carSourceInterface.getCarTools(carTools);
    }

    /**
     * 获取随车工具
     * @param carInfoId 车辆信息id
     * @return
     * @throws RemoteException
     */
    public CarToolsDTO getCarToolsByCarInfoId(Long carInfoId) throws RemoteException{
        return this.carSourceInterface.getCarToolsByCarInfoId(carInfoId);
    }

    /**
     * 删除车源
     * @param carInfoId 车辆信息id
     * @return
     * @throws RemoteException
     */
    public void deleteCarSource(Long carInfoId) throws RemoteException{
        this.carSourceInterface.deleteCarSource(carInfoId);
    }

    /**
     * 退车
     * @param carInfoId 车辆信息id
     * @throws RemoteException
     */
    public void recedeCarSource(Long carInfoId) throws RemoteException, CarSourceException {
        this.carSourceInterface.recedeCarSource(carInfoId);
    }

    /**
     * 修改价格
     * @param carInfoId 车辆信息id
     * @param salePrice 车主售价
     * @param servicePrice 服务费
     * @throws RemoteException
     */
    public void updatePrice(Long carInfoId, int salePrice, int servicePrice, EmpListDTO emp) throws RemoteException{
        this.carSourceInterface.updatePrice(carInfoId,salePrice,servicePrice,emp);
    }

    /**
     * 将车辆移至库存
     * @param carInfoId 车辆信息id
     * @param status 操作状态：1库存中、2已售、3已退
     * @throws RemoteException
     */
    public void changeCarStatusToInventory(Long carInfoId, int status) throws RemoteException{
        this.carSourceInterface.changeCarStatusToInventory(carInfoId,status);
    }
}
