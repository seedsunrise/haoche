package com.haoche.bos.controller;

import com.basedata.remoting.dto.CarBrandDTO;
import com.basedata.remoting.dto.CarLineDTO;
import com.basedata.remoting.stub.CarLineInterface;
import com.haoche.bos.datamapper.Template;
import com.haoche.bos.service.CarBrandService;
import com.haoche.bos.util.JsonUtil;
import com.haoche.remoting.dto.*;
import com.haoche.remoting.stub.CarGoodsInterface;
import com.haoche.remoting.stub.CarSourceInterface;
import com.haoche.remoting.stub.InsuranceQuoteInterface;
import com.haoche.remoting.stub.ShopInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.rmi.RemoteException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/carGoods")
public class CarGoodsController {

    @Autowired
    private CarSourceInterface carSourceInterface;

    @Autowired
    private CarGoodsInterface carGoodsInterface;

    @Autowired
    private ShopInterface shopInterface;

    @Autowired
    private InsuranceQuoteInterface insuranceQuoteInterface;

    @Autowired
    private CarBrandService carBrandService;

    @Autowired
    private CarLineInterface carLineInterface;

    @Value("${platform.image.url}")
    private String imageUrl;

    @Value("${platform.mobileSite.url}")
    private String mobileSiteUrl;

    @RequestMapping(name = "商品列表", value = "/list", method = RequestMethod.GET)
    public ModelAndView list(Long carBrandId,
                             Long carLineId,
                             Integer runKm,
                             String carColor,
                             String firstLicenseDateStart,
                             String firstLicenseDateEnd,
                             String createdAtStart,
                             String createdAtEnd,
                             String sort,
                             String sc,
                             String search,
                             @RequestParam(value = "status",defaultValue = "0")Integer status,
                             @RequestParam(value = "pageNo",defaultValue = "0")Integer pageNo,
                             @RequestParam(value = "pageSize",defaultValue = "10")Integer pageSize) throws RemoteException, ParseException {
        List<Integer> statusList = new ArrayList<>();
        if (status == 20) {
            statusList.add(20);
        } else {
            statusList.add(10);
            statusList.add(20);
            statusList.add(30);
            statusList.add(40);
            statusList.add(50);
        }
        System.out.println(sort+"sort"+sc+"sc"+firstLicenseDateStart+"firstLicenseDateStart" +createdAtStart+"createdAtStart"+"============================================");
        Map<String,Object> mapParameter = new HashMap<>();
        Map map = new HashMap();
        StringBuilder param = new StringBuilder("status="+status);
        DateFormat format = new SimpleDateFormat("yyyy年MM月dd");

        if(carBrandId != null){
            mapParameter.put("carBrandId",carBrandId);
            map.put("carBrandId",carBrandId);
            param.append("&carBrandId="+carBrandId);
        }
        if(carLineId != null){
            mapParameter.put("carLineId",carLineId);
            map.put("carLineId",carLineId);
            param.append("&carLineId="+carLineId);
        }
        if(runKm != null){
            mapParameter.put("runKm",runKm);
            map.put("runKm",runKm);
            param.append("&runKm="+runKm);
        }
        if(org.apache.commons.lang3.StringUtils.isNotBlank(carColor)){
            mapParameter.put("carColor",carColor);
            map.put("carColor",carColor);
            param.append("&carColor="+carColor);
        }
        if(org.apache.commons.lang3.StringUtils.isNotBlank(firstLicenseDateStart) && !org.apache.commons.lang3.StringUtils.equals(firstLicenseDateStart.trim(),"首次上牌时间")){
            String start = firstLicenseDateStart.replace("年","").replace("月","").replace("日","");
            mapParameter.put("firstLicenseDateStart",start);
            map.put("firstLicenseDateStart",firstLicenseDateStart);
            param.append("&firstLicenseDateStart="+firstLicenseDateStart);
        }
        if(org.apache.commons.lang3.StringUtils.isNotBlank(firstLicenseDateEnd) && !org.apache.commons.lang3.StringUtils.equals(firstLicenseDateEnd.trim(),"首次上牌时间")){
            String end = firstLicenseDateEnd.replace("年","").replace("月","").replace("日","");
            mapParameter.put("firstLicenseDateEnd",end);
            map.put("firstLicenseDateEnd",firstLicenseDateEnd);
            param.append("&firstLicenseDateEnd="+firstLicenseDateEnd);
        }
        if(org.apache.commons.lang3.StringUtils.isNotBlank(createdAtStart) && !org.apache.commons.lang3.StringUtils.equals(createdAtStart.trim(),"创建开始时间")){
            mapParameter.put("createdAtStart",format.parse(createdAtStart));
            map.put("createdAtStart",createdAtStart);
            param.append("&createdAtStart="+createdAtStart);
        }
        if(org.apache.commons.lang3.StringUtils.isNotBlank(createdAtEnd) && !org.apache.commons.lang3.StringUtils.equals(createdAtEnd.trim(),"创建结束时间")){
            mapParameter.put("createdAtEnd",format.parse(createdAtEnd));
            map.put("createdAtEnd",createdAtEnd);
            param.append("&createdAtEnd="+createdAtEnd);
        }

        //品牌
        List<CarBrandDTO> carBrandList = this.carBrandService.getCarBrandList(0,10000).getList();

        if(org.apache.commons.lang3.StringUtils.isNotBlank(sort)){
            map.put("sort",sort);
            param.append("&sort="+sort);
        }
        if(org.apache.commons.lang3.StringUtils.isNotBlank(sc)){
            map.put("sc",sc);
            param.append("&sc="+sc);
        }
        if(org.apache.commons.lang3.StringUtils.isNotBlank(search)){
            map.put("search",search);
            param.append("&search="+search);
        }

        PageNateDTO pageNateDTO = this.carSourceInterface.getCarInfoList(mapParameter,sort,sc,search,statusList,pageNo,pageSize);

        map.put("page", pageNateDTO);
        map.put("insuranceList", insuranceQuoteInterface.getAllQuotePerson());
        map.put("imageUrl",imageUrl);
        map.put("carBrandList",carBrandList);
        map.put("status",status);
        map.put("params",param.toString());
        map.put("mobileSiteUrl", mobileSiteUrl);
        if (status == 20) {
            return new ModelAndView("/goods/list", "map", map);
        } else {
            return new ModelAndView("/goods/listAll", "map", map);
        }
    }

    @RequestMapping(name = "新增商品页面", value = "/new", method = RequestMethod.GET)
    public ModelAndView newCarGoods(@RequestParam(value = "id", defaultValue = "0") Long id, @RequestParam(value = "status", defaultValue = "0") Long status) throws RemoteException {
        CarInfoDTO carInfoDTO = null;
        List<Integer> statusList = new ArrayList<>();
        statusList.add(0);
        Map map = new HashMap();
        map.put("status", status);
        map.put("shopList",shopInterface.getShopList(0,100).getList());
        if (id == 0) {
            PageNateDTO pageNateDTO = this.carSourceInterface.getCarInfoList(new HashMap<String, Object>(), "", "", "", statusList, 0, 200);
            map.put("page", pageNateDTO.getList());
            return new ModelAndView("/goods/selectSource", "map", map);
        } else {
            CarDocumentDTO carDocumentDTO = carSourceInterface.getCarDocumentByCarInfoId(id);
            carInfoDTO = carSourceInterface.getCarInfo(id);
            map.put("carInfo", carInfoDTO);
            map.put("carDocument",carDocumentDTO);
            return new ModelAndView("/goods/new", "map", map);
        }
    }

    @RequestMapping(name = "编辑商品页面", value = "/edit", method = RequestMethod.GET)
    public ModelAndView edit(@RequestParam(value = "id", defaultValue = "0") Long id, @RequestParam(value = "status", defaultValue = "0") Long status) throws RemoteException {
        CarInfoDTO carInfoDTO = null;
        List<Integer> statusList = new ArrayList<>();
        statusList.add(0);
        Map map = new HashMap();
        carInfoDTO = carSourceInterface.getCarInfo(id);
        map.put("carInfo", carInfoDTO);
        map.put("carDocument",carSourceInterface.getCarDocumentByCarInfoId(id));
        map.put("status", status);
        map.put("shopList",shopInterface.getShopList(0,100).getList());
        return new ModelAndView("/goods/edit", "map", map);
    }

    @ResponseBody
    @RequestMapping(name = "提交更新商品信息和上架", value = "/update", method = RequestMethod.POST)
    public Template update(@ModelAttribute UpdateCarGoods updateCarGoods) throws RemoteException {
        carGoodsInterface.updateCarGoods(updateCarGoods);
        Map map = new HashMap();
        map.put("url", "/carGoods/list");
        Template template = new Template();
        template.setData(map);
        return template;
    }

    @RequestMapping(name = "确认商品页面", value = "/confirm", method = RequestMethod.GET)
    public ModelAndView confirm(@RequestParam(value = "id", defaultValue = "0") Long id) throws RemoteException {
        CarInfoDTO carInfoDTO = null;
        List<Integer> statusList = new ArrayList<>();
        statusList.add(0);
        Map map = new HashMap();
        CarPhotoDTO carPhotoDTO = carGoodsInterface.getCarPhoto(id);
        carInfoDTO = carSourceInterface.getCarInfo(id);
        map.put("carInfo", carInfoDTO);
        map.put("carPhoto", carPhotoToMap(id));
        map.put("imageUrl",imageUrl);
        return new ModelAndView("/goods/confirm", "map", map);
    }

    @ResponseBody
    @RequestMapping(name = "上架/下架商品", value = "/saleOnOff", method = RequestMethod.POST)
    public Template saleOnOff(@RequestParam(value = "id") Long id, @RequestParam(value = "type", defaultValue = "2") int type,
                              @RequestParam(value = "saleOnOffContent",defaultValue = "")String saleOnOffContent,
                              @RequestParam(value = "saleOnOffType",defaultValue = "0")int saleOnOffType) throws RemoteException {
        Map map = new HashMap();
        map.put("url", "/carGoods/list");
        Template template = new Template();
        template.setData(map);
        if (type == 2) {
            return template;
        } else if (type == 0) {
            carGoodsInterface.sale(0, id);
        } else if (type == 1) {
            carGoodsInterface.saleOff(1, id,saleOnOffType,saleOnOffContent);
        }
        return template;
    }

    @RequestMapping(name = "获取车辆报价信息", value = "/insuranceQuote", method = RequestMethod.GET)
    public ModelAndView insuranceQuote(@RequestParam(value = "carInfoId") Long carInfoId) throws RemoteException {
        return new ModelAndView("/goods/insuranceQuote", "insuranceQuote", insuranceQuoteInterface.getInsuranceQuote(carInfoId));
    }

    @RequestMapping(name = "获取车辆照片信息", value = "/carPhoto", method = RequestMethod.GET)
    public ModelAndView getCarPhoto(@RequestParam(value = "carInfoId") Long carInfoId) throws RemoteException {
        Map map = new HashMap();
        map.put("imageUrl",imageUrl);
        map.put("carPhoto",carGoodsInterface.getCarPhoto(carInfoId));
        return new ModelAndView("/goods/carPhoto", "map",map );
    }

    @ResponseBody
    @RequestMapping(name = "获取车辆照片数量", value = "/totalCarPhotoNum", method = RequestMethod.GET)
    public Template totalCarPhotoNum(@RequestParam(value = "carInfoId") Long carInfoId) throws RemoteException {
        List list = carPhotoToMap(carInfoId);
        int total = 0;
        for (Object map : list) {
            if (!StringUtils.isEmpty(map)) {
                total++;
            }
        }
        Map outMap = new HashMap();
        outMap.put("total", total);
        Template template = new Template();
        template.setData(outMap);
        return template;
    }

    @ResponseBody
    @RequestMapping(name = "更新照片信息", value = "/updateCarPhoto", method = RequestMethod.POST)
    public Template updateCarPhoto(@ModelAttribute CarPhotoDTO carPhotoDTO) throws RemoteException {
        carGoodsInterface.updateCarPhoto(carPhotoDTO);
        return new Template();
    }

    public List carPhotoToMap(Long id) {
        String photoKey[] = {"leftFrontFace", "frontFace", "leftFace", "rearFace", "allInteriorFace",
                "meterFace", "steeringWheelFace", "middleControlCenter", "centralControlLayoutOne",
                "centralControlLayoutTwo", "headlightControl", "windowControl", "frontSeatFace",
                "skylight", "rearSeatSideFace", "rearSeatFace", "rearAirPort", "engineCabin",
                "stall", "mainButtonOne", "mainButtonTwo", "detectingAppearance", "computerFailures",
                "detectingChassis"};
        Map map = new HashMap();
        try {
            map = (Map) JsonUtil.jsonToBean(JsonUtil.beanToJson(carGoodsInterface.getCarPhoto(id)), Map.class);
        } catch (Exception e) {
        }
        List<Object> list = new ArrayList<>();
        for (String key : photoKey) {
            list.add(map.get(key));
        }
        return list;
    }

    @ResponseBody
    @RequestMapping(name = "获取车系",value = "/queryLine",method = RequestMethod.GET)
    public ModelAndView queryLineList(@RequestParam(value="carBrandId")Long carBrandId) throws RemoteException {
        List<CarLineDTO>  list = this.carLineInterface.getCarLineListByBrandId(carBrandId);
        return new ModelAndView("/carsource/carLineListTpl","carLineList",list);
    }
}
