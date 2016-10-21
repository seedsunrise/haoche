package com.haoche.bos.controller;

import com.haoche.bos.service.CarIdentifyService;
import com.haoche.bos.util.CurrentUser;
import com.haoche.bos.util.DictEnum;
import com.haoche.bos.util.Helper;
import com.haoche.remoting.dto.*;
import com.haoche.remoting.exceptions.CarSourceException;
import com.haoche.remoting.stub.CarSourceInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * fench:bos鉴定管理与权限无关，所有人都可以查看 2016.07.06
 */

@Controller
@RequestMapping("/identifyManagement")
public class IdentifyManagementController {

    @Autowired
    private CarIdentifyService carIdentifyService;

    @Autowired
    private CarSourceInterface carSourceInterface;

    @RequestMapping(name = "鉴定管理列表",value = "/list", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public ModelAndView getIdentifyCarList(@RequestParam(value = "identifyType", defaultValue = "1") int identifyType,
                                           @RequestParam(value = "pageNo",defaultValue = "0")int pageNo,
                                           @RequestParam(value = "pageSize",defaultValue = "10")int pageSize)throws RemoteException{

        IdentifyCarListParamDTO identifyCarListParamDTO = new IdentifyCarListParamDTO();
        identifyCarListParamDTO.setPageNo(pageNo);
        identifyCarListParamDTO.setPageSize(pageSize);
        identifyCarListParamDTO.setIdentifyType(identifyType);


        PageNateDTO pageNateDTO = this.carIdentifyService.getIdentifyCarPage(identifyCarListParamDTO);
        Map resultMap = new HashMap();
        String param = Helper.createUrl(identifyCarListParamDTO);
        pageNateDTO.setPageSize(pageSize);
        resultMap.put("page",pageNateDTO);
//        resultMap.put("imageUrl",imageUrl);
        resultMap.put("param",param);
        resultMap.put("identifyType",identifyType);
//        resultMap.put("paramDTO",orderListParamDTO);

        return new ModelAndView("/identifyManagement/list","map",resultMap);
    }

    @ResponseBody
    @RequestMapping(name = "获取分组下的检查项",value = "/findCheckByGroupId",method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public ModelAndView findCheckByGroupId(@RequestParam(value = "groupId")Long groupId,
                                           @RequestParam(value = "identifyType",defaultValue = "1")int identifyType) throws RemoteException{
        return new ModelAndView("/identifyManagement/checkTpl", "checkDTOList", this.carIdentifyService.findCheckByGroupId(groupId,identifyType));
    }

    @ResponseBody
    @RequestMapping(name = "获取检查项检查结果",value = "/findCheckResultByCheckId",method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public ModelAndView findCheckResultByCheckId(@RequestParam(value = "identifyType",defaultValue = "1")int identifyType,
                                        @RequestParam(value = "carId")Long carId,
                                        @RequestParam(value = "carVin")String carVin,
                                        @RequestParam(value = "checkId")Long checkId)throws RemoteException{
        Map resultMap = this.carIdentifyService.findCheckResultByCheckId(identifyType,carId,carVin,checkId);
        List<IdentifyPointDTO> points = this.carIdentifyService.getAllIdenPoints(identifyType, carId, carVin);
        int i = points.size();
        for(int j=0;j<i;j++){
            System.out.println("checkId===="+checkId.toString());
            System.out.println("checkId+++++"+points.get(j).getCheckId().toString());
            if(checkId.toString().equals(points.get(j).getCheckId().toString())){
                resultMap.put("identifyPoints",points.get(j).getIndenPointDoubles());
            }
        }
        return new ModelAndView("/identifyManagement/checkResultTpl", "resultMap",resultMap);
    }


    //初始化获取漆面检测所有点的值.(漆面检测下面的checkId必须按顺序添加)
    @RequestMapping(name = "获取所有漆面检测点的值",value = "/getAllIdenPoints",method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public Map getAllIdenPoints(@RequestParam(value = "identifyType",defaultValue = "1")int identifyType,
                                @RequestParam(value = "carId")Long carId,
                                @RequestParam(value = "carVin")String carVin)throws RemoteException{
        List<IdentifyPointDTO> points = this.carIdentifyService.getAllIdenPoints(identifyType, carId, carVin);
        Map resultMap = new HashMap();
        resultMap.put("pointList",points);
        return resultMap;
    }

    @RequestMapping(name="鉴定详情",value = "/detail",method = RequestMethod.GET)
    public ModelAndView  detail(@RequestParam(value = "carInfoId")Long carInfoId,
                                @RequestParam(value = "carVin") String carVin,
                                @RequestParam(value = "identifyType",defaultValue = "1") int identifyType
                                ) throws RemoteException, CarSourceException {
        // 获取车辆基本信息
        Map<String,Object> resultMap = new HashMap<>();
        if(carInfoId!=null){
            resultMap = CarSourceController.GetCarInfoByCarSourceInterfaceAndCarId(this.carSourceInterface, carInfoId);
        }
        //获取用户下的所有分组，如果是离线鉴定，默认获取用户jiancunxuan的分组
        Long userId = CurrentUser.get().getId();
        if(identifyType== DictEnum.identifyType.IDENTIFY_OFFLINE){
            userId = Long.parseLong(DictEnum.DefaultID.JIANCUNXUAN_USERID);
        }
        List<IdentifyGroupDTO> groupDTOList = this.carIdentifyService.getAllGroups(userId);
        resultMap.put("groupList", groupDTOList);
        resultMap.put("identifyType", identifyType);
        resultMap.put("carVin", carVin);
        return new ModelAndView("/identifyManagement/detail","map",resultMap);
    }

    @ResponseBody
    @RequestMapping(name = "根据车辆id获取车辆基本信息", value = "/getCarInfoTplById", method = RequestMethod.GET)
    public  ModelAndView getCarLineListByCarSubBrandId(@RequestParam(value = "id")Long id) throws CarSourceException, RemoteException {
        return new ModelAndView("/identifyManagement/carInfoTpl", "map", CarSourceController.GetCarInfoByCarSourceInterfaceAndCarId(this.carSourceInterface, id));
    }
}
