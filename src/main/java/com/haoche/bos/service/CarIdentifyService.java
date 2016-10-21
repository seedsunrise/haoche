package com.haoche.bos.service;

import com.haoche.bos.util.CurrentUser;
import com.haoche.bos.util.DictEnum;
import com.haoche.remoting.dto.*;
import com.haoche.remoting.enums.CarStatus;
import com.haoche.remoting.stub.CarIdentifyInterface;
import com.haoche.remoting.stub.CarSourceInterface;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * CarIdentifyService
 *
 * @author Chen fei
 * @date 2016/6/28
 */
@Service("carIdentifyService")
public class CarIdentifyService {

    @Autowired
    private CarIdentifyInterface carIdentifyInterface;

    @Autowired
    private CarSourceInterface carSourceInterface;

    public PageNateDTO getIdentifyCarPage(IdentifyCarListParamDTO identifyCarListParamDTO)throws RemoteException{
        int identifyType = identifyCarListParamDTO.getIdentifyType();
        PageNateDTO carinfoPage = new PageNateDTO();
        if(identifyType== DictEnum.identifyType.IDENTIFY_ONLINE){
            Map mapParameter = new HashMap();
            String sort = "updatedAt";
            String sc = "desc";
            String search = "";
            List statusList = new ArrayList();
            statusList.add(CarStatus.STOCKIN.getValue());
            statusList.add(CarStatus.PRODUCT.getValue());
            statusList.add(CarStatus.SELLING.getValue());
            statusList.add(CarStatus.LOCKED.getValue());
            statusList.add(CarStatus.SOLD.getValue());
            statusList.add(CarStatus.DELIVERED.getValue());
            statusList.add(CarStatus.RECEDED.getValue());
            int pageNo = identifyCarListParamDTO.getPageNo();
            int pageSize = identifyCarListParamDTO.getPageSize();
            try {
                carinfoPage = carSourceInterface.getCarInfoList(mapParameter, sort, sc, search, statusList, pageNo, pageSize);
            }catch (Exception e){
                e.printStackTrace();
            }
            int i = carinfoPage.getList().size();
            List resultList = new ArrayList();
            for(int j=0;j<i;j++){
                CarInfoDTO carInfoDTO = (CarInfoDTO)carinfoPage.getList().get(j);
                int isIdentify = carInfoDTO.getIsIdentify();
                IdentifyCarListResponseDTO identifyCarListResponseDTO = new IdentifyCarListResponseDTO();
                BeanUtils.copyProperties(carInfoDTO, identifyCarListResponseDTO);
                if(isIdentify==DictEnum.CarIdentify.IDENTIFY_COMPLETE){
                    IdentifyUserCarDTO identifyUserCarDTO = carIdentifyInterface.getIdentifyUserCarByCarId(carInfoDTO.getId());
                    identifyCarListResponseDTO.setIdentifyTime(identifyUserCarDTO.getUpdatedAt());
                    Long userId = identifyUserCarDTO.getUserId();
                    GemmologistDTO gemmologistDTO = carIdentifyInterface.getGemmologistById(userId);
                    identifyCarListResponseDTO.setIdentifyUserName(gemmologistDTO.getName());
                }
                resultList.add(identifyCarListResponseDTO);
            }
            carinfoPage.setList(resultList);
        }else if(identifyType==DictEnum.identifyType.IDENTIFY_OFFLINE){
            //获取所有离线鉴定的车辆
            int pageNo = identifyCarListParamDTO.getPageNo();
            int pageSize = identifyCarListParamDTO.getPageSize();
            List<IdentifyUserCarDTO> identifyUserCarList = carIdentifyInterface.getAllOffLineCars(pageNo, pageSize);
            int count = carIdentifyInterface.getAllOffLineCarCount();
            int i = identifyUserCarList.size();
            List resultList = new ArrayList();
            for (int j=0;j<i;j++){
                IdentifyCarListResponseDTO identifyCarListResponseDTO = new IdentifyCarListResponseDTO();
                Long userId = identifyUserCarList.get(j).getUserId();
                identifyCarListResponseDTO.setCarVin(identifyUserCarList.get(j).getCarVin());
                identifyCarListResponseDTO.setIdentifyUserName(carIdentifyInterface.getGemmologistById(userId).getName());
                resultList.add(identifyCarListResponseDTO);
            }
            carinfoPage.setList(resultList);
            carinfoPage.setCount(count);

        }
        return carinfoPage;

    }

    public List<IdentifyGroupDTO> getAllGroups(Long userId)throws RemoteException{
        List<IdentifyGroupDTO> groupDTOList = new ArrayList<>();
        groupDTOList = carIdentifyInterface.getIdentifyGroupByUserId(userId);
        return groupDTOList;
    }

    public List<IdentifyCheckDTO> findCheckByGroupId(Long groupId, int identifyType)throws RemoteException{
        long userId = CurrentUser.get().getId();
        List<IdentifyCheckDTO> checkDTOList = carIdentifyInterface.findCheckByGroupId(groupId,userId,identifyType);
        return checkDTOList;
    }

    public Map findCheckResultByCheckId(int identifyType, Long carId, String carVin, Long checkId)throws RemoteException{
        return carIdentifyInterface.findCheckResultByCheckId(identifyType,carId,carVin,checkId);
    }

    public List<IdentifyPointDTO> getAllIdenPoints(int identifyType, Long carId, String carVin)throws RemoteException{
        return carIdentifyInterface.getAllIdenPoints(identifyType,carId,carVin);
    }
}
