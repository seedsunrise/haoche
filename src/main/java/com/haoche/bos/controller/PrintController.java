package com.haoche.bos.controller;

import com.basedata.remoting.dto.carConfigDTO.CarConfigEntity;
import com.basedata.remoting.exceptions.CarConfigNotExistException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.haoche.bos.service.CarConfigService;
import com.haoche.bos.service.CarSourceService;
import com.haoche.bos.util.JsonUtil;
import com.haoche.bos.util.RestHttpClient;
import com.haoche.remoting.dto.CarInfoDTO;
import com.haoche.remoting.exceptions.CarSourceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.net.URISyntaxException;
import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.Map;

/** 打印
 * Created by allan on 2016/5/20.
 */
@Controller
@RequestMapping("/print")
public class PrintController {

    @Autowired
    private CarSourceService carSourceService;
    @Autowired
    private CarConfigService carConfigService;

    @Value("${platform.report.url}")
    private String identifyReportUrl;

    @Value("${platform.identify.url}")
    private String identifyDetailUrl;
    /**
     * 到二维码打印页面
     * @param carInfoId
     * @return
     */
    @RequestMapping(name = "打印汽车二维码", value = "/printCarQRCode", method = RequestMethod.GET)
    public ModelAndView printCarSourceQRCodeImagePage(@RequestParam(value = "carInfoId") Long carInfoId) throws CarSourceException, RemoteException {
        CarInfoDTO carInfoDTO = this.carSourceService.getCarInfo(carInfoId);
        if(carInfoDTO == null){
            throw new CarSourceException("此车源不存在");
        }
        Map<String,Object> map = new HashMap<>();
        map.put("carInfo",carInfoDTO);
        return new ModelAndView("/print/carqrcode","map",map);
    }

    @RequestMapping(name = "打印车辆配置页面", value = "/carConfigPage", method = RequestMethod.GET)
    public ModelAndView carConfigPage(@RequestParam(value = "id")Long id) throws CarConfigNotExistException, RemoteException, JsonProcessingException {
        CarConfigEntity carConfigEntity = null;
        carConfigEntity = this.carConfigService.getCarConfigByCarModelId(id);
        return new ModelAndView("/print/carConfig","carConfig", JsonUtil.beanToJson(carConfigEntity));
    }

    @RequestMapping(name = "打印保修条例", value = "/printQualityAssurance", method = RequestMethod.GET)
    public ModelAndView printQualityAssurance(){
        return new ModelAndView("/print/printQualityAssurance");
    }

    @RequestMapping(name="打印鉴定报告",value = "/printCarIdentifyDetail",method = RequestMethod.GET)
    public ModelAndView carIdentifyDetail(@RequestParam(value = "carInfoId")Long carInfoId) throws URISyntaxException, JsonProcessingException {
        Map report = RestHttpClient.getForObject(identifyDetailUrl+carInfoId,Map.class);
        return new ModelAndView("/print/carIdentifyReport","report", JsonUtil.beanToJson(report));
    }

    @RequestMapping(name="打印首页价签页面",value = "/carPriceTagPage",method = RequestMethod.GET)
    public ModelAndView carPriceTagPage(@RequestParam(value = "carInfoId")Long carInfoId) throws URISyntaxException, RemoteException {
        CarInfoDTO carInfo = this.carSourceService.getCarInfo(carInfoId);
        Map<String,Object> resultMap = new HashMap<>();
        resultMap.put("carInfo",carInfo);
        Map report = RestHttpClient.getForObject(identifyReportUrl+"?carId="+carInfoId,Map.class);
        resultMap.put("identifyReport",report);
        return new ModelAndView("/print/carPriceTag", "map", resultMap);
    }
}