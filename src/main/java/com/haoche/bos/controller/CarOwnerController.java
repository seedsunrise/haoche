package com.haoche.bos.controller;

import com.haoche.bos.datamapper.Template;
import com.haoche.bos.service.CarBrandService;
import com.haoche.bos.service.CarOwnerService;
import com.haoche.carowner.remoting.dto.CarInfoDTO;
import com.haoche.carowner.remoting.dto.CarOwnerDTO;
import com.haoche.carowner.remoting.dto.query.CarOwnerQuery;
import com.haoche.carowner.remoting.exceptions.CarVinExitException;
import com.haoche.carowner.remoting.exceptions.OwnerExistException;
import com.haoche.carowner.remoting.stub.CarInfoInterface;
import com.haoche.carowner.remoting.stub.CarOwnerInterface;
import com.haoche.remoting.dto.CarBrandDTO;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.rmi.RemoteException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 车主
 * Created by allan on 2016/7/29.
 */
@Controller
@RequestMapping("/user/carOwner")
public class CarOwnerController {
    @Value("${platform.image.url}")
    private String imageUrl;
    @Autowired
    CarOwnerService carOwnerService;
    @Autowired
    CarBrandService carBrandService;
    @Autowired
    CarInfoInterface carInfoInterface;

    @RequestMapping(name = "保存车主信息页面", value = "/editPage", method = RequestMethod.GET)
    public ModelAndView savePage(Long id) throws RemoteException {
        List<CarBrandDTO> carBrandList = this.carBrandService.getCarBrandList(0, 1000).getList();
        Map<String, Object> map = new HashMap<>();
        map.put("carBrandList", carBrandList);
        if (id != null && id != 0l) {
            CarOwnerDTO owner = carOwnerService.getCarOwner(id);
            if(owner.getSex()!=null && owner.getSex()==true){
               map.put("sex",1);
            }else if(owner.getSex()!=null && owner.getSex()==false){
                map.put("sex", 2);
            }else{
                map.put("sex", 0);
            }
            map.put("owner", owner);
        }else{
            map.put("sex", 0);
        }
        map.put("imageUrl", imageUrl);
        return new ModelAndView("/user/carOwner/edit", "map", map);
    }

    @ResponseBody
    @RequestMapping(name = "保存车主信息动作", value = "/edit", method = RequestMethod.POST)
    public Template save(CarInfoDTO carInfo,
                         String takeTime,
                         String licenseTime,
                         String sex,
                         @RequestParam(value = "runKmParameter", defaultValue = "0.0") Double runKmParameter) throws RemoteException, ParseException, OwnerExistException,CarVinExitException {
        Template template = new Template();

        if (StringUtils.isNotBlank(takeTime)) {
            carInfo.setTakeCarTime(DateUtils.parseDate(takeTime, "yyyy年MM月dd日"));
        }
        if (StringUtils.isNotBlank(licenseTime)) {
            carInfo.setFirstLicenseDate(DateUtils.parseDate(licenseTime, "yyyy年MM月dd日"));
        }
        CarOwnerDTO owner=carInfo.getCarOwner();
        owner.setCarOwner(true);
        if(Integer.valueOf(sex)==1){
            owner.setSex(true);
        }else if(Integer.valueOf(sex)==2){
            owner.setSex(false);
        }
        if(carInfo.getId()==null || carInfo.getId() == 0l){
            carInfo.setMainCarTitle(carInfo.getCarModelName());
        }
        if (owner.getId() == null || owner.getId() == 0l) {
            carInfo.setMainCarTitle(carInfo.getCarModelName());
            carInfo.setRunKm((int) (runKmParameter * 10000));
            owner = carOwnerService.save(owner, carInfo);
        } else {
            carInfo.setRunKm((int)(runKmParameter*10000));
            owner= carOwnerService.update(owner,carInfo);
        }
        Map<String, Object> map = new HashMap<>();
        map.put("owner", owner);
        map.put("url", "/user/carOwner/list");
        template.setData(map);
        return template;
    }

    @ResponseBody
    @RequestMapping(name = "车主概览列表页面", value = "/list", method = RequestMethod.GET)
    public ModelAndView list(String takeCarTimeStart,
                             String takeCarTimeEnd,
                             String searchNameOrMobile,
                             String sort,
                             String direction,
                             @RequestParam(value = "pageNo", defaultValue = "0") int pageNo,
                             @RequestParam(value = "pageSize", defaultValue = "10") int pageSize) throws ParseException, RemoteException {
        Map<String, Object> resultMap = new HashMap<>();
        CarOwnerQuery query=new CarOwnerQuery();
        query.setPageNo(pageNo);
        query.setPageSize(pageSize);
        StringBuilder param = new StringBuilder("pageSize="+pageSize);
        if (StringUtils.isNotBlank(takeCarTimeStart)) {
            query.setStartTakeCarTime(DateUtils.parseDate(takeCarTimeStart,"yyyy年MM月dd日"));
            resultMap.put("takeCarTimeStart", takeCarTimeStart);
            param.append("&takeCarTimeStart=" + takeCarTimeStart);
        }
        if (StringUtils.isNotBlank(takeCarTimeEnd)) {
            query.setEndTakeCarTime(DateUtils.parseDate(takeCarTimeEnd,"yyyy年MM月dd日"));
            resultMap.put("takeCarTimeEnd", takeCarTimeEnd);
            param.append("&takeCarTimeEnd=" + takeCarTimeEnd);
        }
        if (StringUtils.isNotBlank(searchNameOrMobile)) {
            query.setSearch(searchNameOrMobile);
            resultMap.put("searchNameOrMobile", searchNameOrMobile);
            param.append("&searchNameOrMobile="+searchNameOrMobile);
        }
        if (StringUtils.isNotBlank(sort)) {
            query.setSort(sort);
            query.setSc(direction);
            resultMap.put("sort", sort);
            resultMap.put("direction", direction);
            param.append("&sort="+sort+"&direction="+direction);
        }
        resultMap.put("page",carOwnerService.getCarOwnerList(query));
        resultMap.put("param", param.toString());
        resultMap.put("imageUrl", imageUrl);
        return new ModelAndView("/user/carOwner/list", "map", resultMap);
    }

    @ResponseBody
    @RequestMapping(name = "删除车主", value = "/delete", method = RequestMethod.POST)
    public Template delete(@RequestParam(value = "userInfoId") Long userInfoId) throws RemoteException {
        Template template = new Template();
        Integer resault=carOwnerService.delete(userInfoId);
        Map<String, Object> map = new HashMap<>();
        map.put("resault", resault);
        map.put("url", "/user/carOwner/list");
        template.setData(map);
        return template;
    }

    @RequestMapping(name = "车架号唯一验证",value = "/carVinValidate",method = RequestMethod.POST)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public Template carVinValidate(@RequestParam("carVin")String carVin) throws RemoteException {
        Template template = new Template();
        CarInfoDTO carInfoDTO = carInfoInterface.findByCarVin(carVin);
        if(carInfoDTO==null){
            template.setData(0);
        }else{
            template.setData(1);
        }
        return template;
    }
}
