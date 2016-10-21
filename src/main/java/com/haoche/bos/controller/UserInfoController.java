package com.haoche.bos.controller;

import com.haoche.bos.datamapper.Template;
import com.haoche.bos.service.CarBrandService;
import com.haoche.bos.service.UserInfoService;
import com.haoche.remoting.dto.CarBrandDTO;
import com.haoche.userauth.remoting.dto.PageNateDTO;
import com.haoche.userauth.remoting.dto.UserInfoDTO;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.rmi.RemoteException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 车主
 * Created by allan on 2016/7/29.
 */
@Controller
@RequestMapping("/user/userInfo")
public class UserInfoController {
    @Value("${platform.image.url}")
    private String imageUrl;
    @Autowired
    UserInfoService userInfoService;
    @Autowired
    CarBrandService carBrandService;

    @RequestMapping(name = "保存车主信息页面",value = "/editPage",method = RequestMethod.GET)
    public ModelAndView savePage(Long id) throws RemoteException {
        List<CarBrandDTO> carBrandList = this.carBrandService.getCarBrandList(0,1000).getList();
        Map<String,Object> map = new HashMap<>();
        map.put("carBrandList",carBrandList);
        if(id != null && id != 0l){
            UserInfoDTO userInfo = this.userInfoService.getUserInfo(id);
            map.put("userInfo",userInfo);
        }
        map.put("imageUrl",imageUrl);
        return new ModelAndView("/user/userInfo/edit","map",map);
    }

    @ResponseBody
    @RequestMapping(name = "保存车主信息动作",value = "/edit",method = RequestMethod.POST)
    public Template save(@ModelAttribute UserInfoDTO userInfoParameter,
                         String takeTime,
                         String licenseTime,
                         @RequestParam(value = "runKmParameter",defaultValue = "0.0") Double runKmParameter) throws RemoteException, ParseException {
        Template template = new Template();
        UserInfoDTO userInfo;
        if(userInfoParameter.getId() == null || userInfoParameter.getId() == 0l){
            userInfo = userInfoParameter;
            userInfo.setIsManual(1);
            userInfo.setRunKm((int) (runKmParameter*10000));
            userInfo.setCarOwner(true);
        }else{
            userInfo = this.userInfoService.getUserInfo(userInfoParameter.getId());
            userInfo.setRealName(userInfoParameter.getRealName());
            userInfo.setMobile(userInfoParameter.getMobile());
            userInfo.setAddress(userInfoParameter.getAddress());
            userInfo.setIdentityCardNum(userInfoParameter.getIdentityCardNum());
            userInfo.setCarBrandId(userInfoParameter.getCarBrandId());
            userInfo.setCarBrandName(userInfoParameter.getCarBrandName());
            userInfo.setCarSubBrandId(userInfoParameter.getCarSubBrandId());
            userInfo.setCarSubBrandName(userInfoParameter.getCarSubBrandName());
            userInfo.setCarLineId(userInfoParameter.getCarLineId());
            userInfo.setCarLineName(userInfoParameter.getCarLineName());
            userInfo.setCarModelId(userInfoParameter.getCarModelId());
            userInfo.setCarModelName(userInfoParameter.getCarModelName());
            userInfo.setCarMainPhoto(userInfoParameter.getCarMainPhoto());
            userInfo.setLicenseNum(userInfoParameter.getLicenseNum());
            userInfo.setCarColor(userInfoParameter.getCarColor());
            userInfo.setCarVin(userInfoParameter.getCarVin());
            userInfo.setRunKm((int) (runKmParameter*10000));
            userInfo.setSalePriceReal(userInfoParameter.getSalePriceReal());
            userInfo.setServicePrice(userInfoParameter.getServicePrice());
            userInfo.setInsurace(userInfoParameter.getInsurace());
            userInfo.setOtherFees(userInfoParameter.getOtherFees());
            userInfo.setDrivingLicensePhoto(userInfoParameter.getDrivingLicensePhoto());
        }

        if(StringUtils.isNotBlank(takeTime)){
            userInfo.setTakeCarTime(DateUtils.parseDate(takeTime,"yyyy年MM月dd日"));
        }
        if(StringUtils.isNotBlank(licenseTime)){
            userInfo.setFirstLicenseDate(DateUtils.parseDate(licenseTime,"yyyy年MM月dd日"));
        }

        UserInfoDTO userInfoDTO = this.userInfoService.save(userInfo);

        Map<String,Object> map = new HashMap<>();
        map.put("userInfoDTO",userInfoDTO);
        map.put("url", "/user/userInfo/list");
        template.setData(map);
        return template;
    }

    @ResponseBody
    @RequestMapping(name = "车主概览列表页面",value = "/list",method = RequestMethod.GET)
    public ModelAndView list(String takeCarTimeStart,
                             String takeCarTimeEnd,
                             String searchNameOrMobile,
                             String sort,
                             String direction,
                             @RequestParam(value = "pageNo",defaultValue = "0")int pageNo,
                             @RequestParam(value = "pageSize",defaultValue = "10")int pageSize) throws ParseException, RemoteException {
        Map<String,Object> parameter = new HashMap<>();
        Map<String,Object> resultMap = new HashMap<>();
        StringBuilder param = new StringBuilder("pageSize="+pageSize);
        if(StringUtils.isNotBlank(takeCarTimeStart)){
            parameter.put("takeCarTimeStart", DateUtils.parseDate(takeCarTimeStart,"yyyy年MM月dd日"));
            resultMap.put("takeCarTimeStart", takeCarTimeStart);
            param.append("&takeCarTimeStart="+takeCarTimeStart);
        }
        if(StringUtils.isNotBlank(takeCarTimeEnd)){
            parameter.put("takeCarTimeEnd", DateUtils.parseDate(takeCarTimeEnd,"yyyy年MM月dd日"));
            resultMap.put("takeCarTimeEnd", takeCarTimeEnd);
            param.append("&takeCarTimeEnd="+takeCarTimeEnd);
        }
        if(StringUtils.isNotBlank(searchNameOrMobile)){
            parameter.put("searchNameOrMobile", searchNameOrMobile);
            resultMap.put("searchNameOrMobile", searchNameOrMobile);
            param.append("&searchNameOrMobile="+searchNameOrMobile);
        }
        Map<String,String> sortMap = new HashMap<>();
        if(StringUtils.isNotBlank(sort)){
            sortMap.put(sort,direction);
            resultMap.put("sort", sort);
            resultMap.put("direction", direction);
            param.append("&sort="+sort+"&direction="+direction);
        }

        PageNateDTO page = this.userInfoService.getUserInfoList(parameter,sortMap,pageNo,pageSize);

        resultMap.put("page",page);
        resultMap.put("param",param.toString());
        resultMap.put("imageUrl",imageUrl);
        return new ModelAndView("/user/userInfo/list","map",resultMap);
    }

    @ResponseBody
    @RequestMapping(name = "删除车主",value = "/delete",method = RequestMethod.POST)
    public Template delete(@RequestParam(value = "userInfoId")Long userInfoId) throws RemoteException {
        Template template = new Template();
        UserInfoDTO userInfoDTO = this.userInfoService.delete(userInfoId);
        Map<String,Object> map = new HashMap<>();
        map.put("userInfo",userInfoDTO);
        map.put("url","/user/userInfo/list");
        template.setData(map);
        return template;
    }
}
