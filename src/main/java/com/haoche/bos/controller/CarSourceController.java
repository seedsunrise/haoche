package com.haoche.bos.controller;

import com.basedata.remoting.dto.CarBrandDTO;
import com.basedata.remoting.dto.CarLineDTO;
import com.basedata.remoting.stub.CarLineInterface;
import com.haoche.bos.config.security.EmpInfo;
import com.haoche.bos.controller.command.CarInfoDto;
import com.haoche.bos.datamapper.Template;
import com.haoche.bos.service.*;
import com.haoche.remoting.dto.*;
import com.haoche.remoting.enums.CarStatus;
import com.haoche.remoting.exceptions.CarSourceException;
import com.haoche.remoting.stub.CarInfoApplyInterface;
import com.haoche.remoting.stub.CarSourceInterface;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.rmi.RemoteException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/carSource")
public class CarSourceController {

    @Value("${platform.image.url}")
    private String imageUrl;

    @Value("${platform.mobileSite.url}")
    private String mobileSiteUrl;

    @Autowired
    private CarSourceInterface carSourceInterface;

    @Autowired
    private CityService cityService;

    @Autowired
    private CarBusinessService carBusinessService;
    @Autowired
    private CarBrandService carBrandService;
    @Autowired
    private CarLineService carLineService;
    @Autowired
    private CarLineInterface carLineInterface;
    @Autowired
    private CarOperationLogService carOperationLogService;

    @Autowired
    private CarInfoApplyInterface carInfoApplyInterface;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(
                dateFormat, true));
        binder.registerCustomEditor(int.class, "0",new CustomNumberEditor(Integer.class, false));
        binder.registerCustomEditor(long.class, "0",new CustomNumberEditor(Long.class, false));
    }

    /**
     * 车辆信息列表
     * @Param carBusinessId 寄售商id
     * @param carBrandId 品牌id
     * @param carLineId 车系id
     * @param runKm 行驶公里
     * @param carColor 颜色
     * @param firstLicenseDateStart
     * @param firstLicenseDateEnd
     * @param takeCarTimeStart
     * @param takeCarTimeEnd
     * @param sort
     * @param sc
     * @param search
     * @param status 状态：1库存车源，2已售出车源，3已退车源
     * @param pageNo
     * @param pageSize
     * @return
     * @throws RemoteException
     * @throws ParseException
     */
    @RequestMapping(name="车源列表", value = "/list", method = RequestMethod.GET)
    public ModelAndView mian(Long carBusinessId,
                             Long carBrandId,
                             Long carLineId,
                             Integer runKm,
                             String carColor,
                             String firstLicenseDateStart,
                             String firstLicenseDateEnd,
                             String takeCarTimeStart,
                             String takeCarTimeEnd,
                             String sort,
                             String sc,
                             String search,
                             @RequestParam(value = "status",defaultValue = "0")Integer status,
                             @RequestParam(value = "pageNo",defaultValue = "0")Integer pageNo,
                             @RequestParam(value = "pageSize",defaultValue = "10")Integer pageSize) throws RemoteException, ParseException {
        Map<String,Object> mapParameter = new HashMap<>();
        Map<String,Object> resultMap = new HashMap<>();
        StringBuilder param = new StringBuilder("status="+status);
        DateFormat format = new SimpleDateFormat("yyyy年MM月dd");

        if(carBusinessId != null){
            mapParameter.put("carBusinessId",carBusinessId);
            resultMap.put("carBusinessId",carBusinessId);
            param.append("&carBusinessId="+carBusinessId);
        }
        if(carBrandId != null){
            mapParameter.put("carBrandId",carBrandId);
            resultMap.put("carBrandId",carBrandId);
            param.append("&carBrandId="+carBrandId);
        }
        if(carLineId != null){
            mapParameter.put("carLineId",carLineId);
            resultMap.put("carLineId",carLineId);
            param.append("&carLineId="+carLineId);
        }
        if(runKm != null){
            mapParameter.put("runKm",runKm);
            resultMap.put("runKm",runKm);
            param.append("&runKm="+runKm);
        }
        if(StringUtils.isNotBlank(carColor)){
            mapParameter.put("carColor",carColor);
            resultMap.put("carColor",carColor);
            param.append("&carColor="+carColor);
        }
        if(StringUtils.isNotBlank(firstLicenseDateStart) && !StringUtils.equals(firstLicenseDateStart.trim(),"首次上牌时间")){
            String start = firstLicenseDateStart.replace("年","").replace("月","").replace("日","");
            mapParameter.put("firstLicenseDateStart",start);
            resultMap.put("firstLicenseDateStart",firstLicenseDateStart);
            param.append("&firstLicenseDateStart="+firstLicenseDateStart);
        }
        if(StringUtils.isNotBlank(firstLicenseDateEnd) && !StringUtils.equals(firstLicenseDateEnd.trim(),"首次上牌时间")){
            String end = firstLicenseDateEnd.replace("年","").replace("月","").replace("日","");
            mapParameter.put("firstLicenseDateEnd",end);
            resultMap.put("firstLicenseDateEnd",firstLicenseDateEnd);
            param.append("&firstLicenseDateEnd="+firstLicenseDateEnd);
        }
        if(StringUtils.isNotBlank(takeCarTimeStart) && !StringUtils.equals(takeCarTimeStart.trim(),"接车时间")){
            mapParameter.put("takeCarTimeStart",format.parse(takeCarTimeStart));
            resultMap.put("takeCarTimeStart",takeCarTimeStart);
            param.append("&takeCarTimeStart="+takeCarTimeStart);
        }
        if(StringUtils.isNotBlank(takeCarTimeEnd) && !StringUtils.equals(takeCarTimeEnd.trim(),"接车时间")){
            mapParameter.put("takeCarTimeEnd",format.parse(takeCarTimeEnd));
            resultMap.put("takeCarTimeEnd",takeCarTimeEnd);
            param.append("&takeCarTimeEnd="+takeCarTimeEnd);
        }

        List statusList = new ArrayList<>();
        if(status == 1){
            statusList.add(CarStatus.STOCKIN.getValue());
            statusList.add(CarStatus.PRODUCT.getValue());
            statusList.add(CarStatus.SELLING.getValue());
            statusList.add(CarStatus.LOCKED.getValue());
        }else if(status == 2){
            statusList.add(CarStatus.SOLD.getValue());
            statusList.add(CarStatus.DELIVERED.getValue());
        }else if(status == 3){
            statusList.add(CarStatus.RECEDED.getValue());
        }

        //品牌
        List<CarBrandDTO> carBrandList = this.carBrandService.getCarBrandList(0,10000).getList();
        //车系
        // 寄售方
        List<CarBusinessDTO> carBusinessList = this.carBusinessService.list(0,10000,null).getList();

        if(StringUtils.isNotBlank(sort)){
            resultMap.put("sort",sort);
            param.append("&sort="+sort);
        }
        if(StringUtils.isNotBlank(sc)){
            resultMap.put("sc",sc);
            param.append("&sc="+sc);
        }
        if(StringUtils.isNotBlank(search)){
            resultMap.put("search",search);
            param.append("&search="+search);
        }

        PageNateDTO pageNateDTO = this.carSourceInterface.getCarInfoList(mapParameter,sort,sc,search,statusList,pageNo,pageSize);
        resultMap.put("page",pageNateDTO);
        resultMap.put("status",status);
        resultMap.put("carBrandList",carBrandList);
        resultMap.put("carBusinessList",carBusinessList);
        resultMap.put("params",param.toString());

        return new ModelAndView("/carsource/list","map",resultMap);
    }

    @ResponseBody
    @RequestMapping(name = "获取车系",value = "/queryLine",method = RequestMethod.GET)
    public ModelAndView queryLineList(@RequestParam(value="carBrandId")Long carBrandId) throws RemoteException {
        List<CarLineDTO>  list = this.carLineInterface.getCarLineListByBrandId(carBrandId);
        return new ModelAndView("/carsource/carLineListTpl","carLineList",list);
    }

    @RequestMapping(name = "修改/录入车源页面",value = "/edit",method = RequestMethod.GET)
    public ModelAndView edit(@RequestParam(value = "id",defaultValue = "0")Long id,@RequestParam(defaultValue = "0")Long carInfoApplyId) throws RemoteException {
        CarInfoDTO carInfoDTO = new CarInfoDTO();
        CarToolsDTO carToolsDTO = new CarToolsDTO();
        CarDocumentDTO carDocumentDTO = new CarDocumentDTO();
        if (carInfoApplyId != 0) {
            CarInfoApplyDTO carInfoApplyDTO = carInfoApplyInterface.getCarInfoApply(carInfoApplyId);
            if (carInfoApplyDTO.getCarModelId() == null) {
                carInfoApplyDTO.setCarModelId(0L);
            }
            BeanUtils.copyProperties(carInfoApplyDTO,carInfoDTO);
            carInfoDTO.setCarBusinessId(carInfoApplyDTO.getCarBusinessId());
            carInfoDTO.setCarBusinessName(carInfoApplyDTO.getCarBusinessName());
            carInfoDTO.setId(0L);
            BeanUtils.copyProperties(carInfoApplyDTO,carDocumentDTO);
            carDocumentDTO.setId(0L);
            // 设置产权证
            if (!StringUtils.isEmpty(carInfoApplyDTO.getPropertyCertificatePhoto())) {
                carDocumentDTO.setPropertyCertificate(1);
            }
            // 设置行驶证
            if (!StringUtils.isEmpty(carInfoApplyDTO.getDrivingLicensePhoto())) {
                carDocumentDTO.setIsDrivingLicense(1);
            }
            BeanUtils.copyProperties(carInfoApplyDTO,carToolsDTO);
            carToolsDTO.setId(0L);
        } else if (id != 0) {
            carInfoDTO = carSourceInterface.getCarInfo(id);
            carToolsDTO = carSourceInterface.getCarToolsByCarInfoId(id);
            carDocumentDTO = carSourceInterface.getCarDocumentByCarInfoId(id);
        }

        Map map = new HashMap();
        map.put("carInfoApplyId",carInfoApplyId);
        map.put("imageUrl",imageUrl);
        map.put("mobileSiteUrl",mobileSiteUrl);
        map.put("carInfoDTO",carInfoDTO);
        map.put("carTools",carToolsDTO);
        map.put("carDocument",carDocumentDTO);
        map.put("cityList",cityService.getCityList(0,500).getList());
        map.put("businessList",carBusinessService.list(0,500,"").getList());
        map.put("carBrandList",carBrandService.getCarBrandList(0,500).getList());
        return new ModelAndView("/carsource/edit","map",map);
    }

    @ResponseBody
    @RequestMapping(name = "修改/录入车源动作",value = "/update",method = RequestMethod.POST)
    public Template update(@ModelAttribute CarInfoDto carInfoDto) throws RemoteException {
        CarInfoDTO carInfoDTO = new CarInfoDTO();
        CarToolsDTO carToolsDTO = new CarToolsDTO();
        CarDocumentDTO carDocumentDTO = new CarDocumentDTO();
        if (carInfoDto.getCarInfoApplyId() != 0) {
            CarInfoApplyDTO carInfoApplyDTO = carInfoApplyInterface.getCarInfoApply(carInfoDto.getCarInfoApplyId());
            // 设置主图
            if (!StringUtils.isEmpty(carInfoApplyDTO.getCarPhoto())) {
                carInfoDTO.setCarMainPhoto(carInfoApplyDTO.getCarPhoto().split("\\|")[0]);
            } else {
                carInfoDTO.setCarMainPhoto("");
            }
            carInfoDTO.setSalePrice(carInfoApplyDTO.getSalePrice());
            carInfoApplyInterface.changeCarInfoStatus(carInfoDto.getCarInfoApplyId(),1);
        }
        BeanUtils.copyProperties(carInfoDto, carInfoDTO);
        BeanUtils.copyProperties(carInfoDto, carToolsDTO);
        BeanUtils.copyProperties(carInfoDto, carDocumentDTO);

        EmpListDTO emp = new EmpListDTO();
        BeanUtils.copyProperties((EmpInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal(),emp);
        carSourceInterface.updateCarSource(carInfoDTO, carDocumentDTO, carToolsDTO, emp);
        Map map = new HashMap();
        map.put("url", "/carSource/list?status=1");
        Template template = new Template();
        template.setData(map);
        return template;
    }

    /**
     * 车源详情页面
     * @param carInfoId 车辆信息id
     * @param status 查询状态：1库存车源，2已售出车源，3已退车源
     * @return
     */
    @RequestMapping(name="车源详情",value = "/detail",method = RequestMethod.GET)
    public ModelAndView  detail(@RequestParam(value = "carInfoId")Long carInfoId,
                                @RequestParam(value = "status")Integer status) throws RemoteException, CarSourceException {
        Map<String,Object> resultMap = this.GetCarInfoByCarSourceInterfaceAndCarId(this.carSourceInterface, carInfoId);
        resultMap.put("status",status);
        resultMap.put("imageUrl",imageUrl);
        return new ModelAndView("/carsource/detail","map",resultMap);
    }

    /**
     * 退车
     * @param carInfoId 车辆信息id
     * @return json
     * @throws RemoteException
     */
    @ResponseBody
    @RequestMapping(name="退车",value ="/recedeCarSource",method = RequestMethod.POST)
    public Object recedeCarSource(@RequestParam("carInfoId") Long carInfoId) throws RemoteException, CarSourceException {
        this.carSourceInterface.recedeCarSource(carInfoId);
        Template template = new Template();
        template.setCode("200");
        template.setMsg("退车成功");
        return template;
    }

    /**
     * 修改价格
     * @param carInfoId 车辆信息id
     * @param salePrice 车主售价
     * @param servicePrice 服务费
     * @return
     * @throws RemoteException
     */
    @ResponseBody
    @RequestMapping(name="车辆定价调价",value ="/updatePrice",method = RequestMethod.POST)
    public Object updatePrice(@RequestParam("carInfoId") Long carInfoId,
                              @RequestParam("salePrice") Integer salePrice,
                              @RequestParam("servicePrice") Integer servicePrice) throws RemoteException {
        Template template = new Template();
        if(salePrice < 0){
            template.setCode("500");
            template.setMsg("车主售价不能小于0");
            return template;
        }
        if(servicePrice < 0) {
            template.setCode("500");
            template.setMsg("服务费不能小于0");
            return template;
        }

        EmpListDTO emp = new EmpListDTO();
        BeanUtils.copyProperties((EmpInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal(),emp);
        this.carSourceInterface.updatePrice(carInfoId,salePrice,servicePrice,emp);
        template.setCode("200");
        template.setMsg("修改价格成功");
        return template;
    }

    /**
     * 删除车源
     * @param carInfoId 车辆信息id
     * @return
     * @throws RemoteException
     */
    @ResponseBody
    @RequestMapping(name="删除车源",value = "/delete",method = RequestMethod.POST)
    public Object delete(@RequestParam("carInfoId")Long carInfoId) throws RemoteException {
        this.carSourceInterface.deleteCarSource(carInfoId);
        Template template = new Template();
        Map map = new HashMap();
        map.put("url","/carSource/list");
        template.setData(map);
        return template;
    }

    @ResponseBody
    @RequestMapping(name="移至库存车源",value = "/changeCarStatusToInventory",method = RequestMethod.POST)
    public Object changeCarStatusToInventory(@RequestParam("carInfoId")Long carInfoId,
                                             @RequestParam("status")Integer status) throws RemoteException {
        this.carSourceInterface.changeCarStatusToInventory(carInfoId,status);
        Template template = new Template();
        Map map = new HashMap();
        map.put("url","/carSource/list?status=1");
        template.setData(map);
        return template;
    }

    @ResponseBody
    @RequestMapping(name="获取车源操作日志",value = "/getCarOperationLog",method = RequestMethod.POST)
    public ModelAndView getCarOperationLog(@RequestParam("carInfoId")Long carInfoId) throws RemoteException {
        return new ModelAndView("/carsource/logTpl", "logList", this.carOperationLogService.getCarOperationLogDTOList(carInfoId));
    }

    public static Map<String,Object> GetCarInfoByCarSourceInterfaceAndCarId(CarSourceInterface carSourceInterface, Long carInfoId) throws RemoteException, CarSourceException {
        CarInfoDTO carInfoDTO = carSourceInterface.getCarInfo(carInfoId);
        if(carInfoDTO == null){
            throw new CarSourceException("此车源不存在");
        }

        CarDocumentDTO carDocumentDTO = carSourceInterface.getCarDocumentByCarInfoId(carInfoId);
        CarToolsDTO carToolsDTO = carSourceInterface.getCarToolsByCarInfoId(carInfoId);

        Map<String,Object> resultMap = new HashMap<>();
        resultMap.put("carInfo",carInfoDTO);
        resultMap.put("carDocument",carDocumentDTO);
        resultMap.put("carTools",carToolsDTO);
        return resultMap;
    }


    @RequestMapping(name = "车架号唯一验证",value = "/carVinValidate",method = RequestMethod.POST)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public Template carVinValidate(@RequestParam("carVin")String carVin) throws RemoteException {
        Template template = new Template();
        CarInfoDTO carInfoDTO = carSourceInterface.findByCarVin(carVin);
        if(carInfoDTO==null){
            template.setData(0);
        }else{
            template.setData(1);
        }
        return template;
    }
}