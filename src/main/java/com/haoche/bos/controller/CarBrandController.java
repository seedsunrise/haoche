package com.haoche.bos.controller;

import com.alibaba.fastjson.JSON;
import com.basedata.remoting.dto.CarBrandDTO;
import com.basedata.remoting.dto.CarLineDTO;
import com.basedata.remoting.dto.CarSubBrandDTO;
import com.basedata.remoting.dto.PageNateDTO;
import com.basedata.remoting.exceptions.CarBrandExistException;
import com.basedata.remoting.exceptions.CarBrandNotExistException;
import com.haoche.bos.datamapper.Template;
import com.haoche.bos.service.CarBrandService;
import com.haoche.bos.service.CarLineService;
import com.haoche.bos.service.CarSubBrandService;
import com.haoche.bos.util.DictEnum;
import com.haoche.bos.util.Helper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/system/carbrand")
public class CarBrandController {

    @Autowired
    private CarBrandService carBrandService;

    @Autowired
    private CarSubBrandService carSubBrandService;

    @Autowired
    private CarLineService carLineService;

    @Value("${platform.image.url}")
    private String imageUrl;

    @RequestMapping(name = "品牌列表页面", value = "/list", method = RequestMethod.GET)
    public ModelAndView list(@RequestParam(value = "brandName",defaultValue = "") String brandName,
                           @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                           @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) throws RemoteException {
        PageNateDTO pageNateDTO;
        Map map = new HashMap();
        if (!StringUtils.isEmpty(brandName)) {
            pageNateDTO = this.carBrandService.getCarBrandListByBrandName(brandName, pageNo, pageSize);
            map.put("brandName", brandName);
        } else {
            pageNateDTO = this.carBrandService.getCarBrandList(pageNo, pageSize);
        }
        map.put("imageUrl",imageUrl);
        map.put("page",pageNateDTO);
        return new ModelAndView("/system/carbrand/list", "map", map);
    }

    @RequestMapping(name = "新增编辑/品牌页面", value = "/edit", method = RequestMethod.GET)
    public ModelAndView edit(@RequestParam (value = "id",defaultValue = "0") Long id) throws RemoteException, CarBrandNotExistException {
        CarBrandDTO carBrandDTO = new CarBrandDTO();
        if (id != 0) {
            carBrandDTO = carBrandService.getCarBrandById(id);
        }
        Map map = new HashMap();
        map.put("imageUrl",imageUrl);
        map.put("carBrand",carBrandDTO);
        return new ModelAndView("/system/carbrand/edit","map",map);
    }

    @RequestMapping(name="新增/更新品牌", value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Object update(@ModelAttribute CarBrandDTO carBrandDTO) throws RemoteException, CarBrandNotExistException, CarBrandExistException {
        carBrandService.save(carBrandDTO);
        return Helper.GetTemplateWithMap("url", "/system/carbrand/list");
    }
    @RequestMapping(name="删除品牌", value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Object delete(@RequestParam (value = "id")Long id) throws RemoteException, CarBrandExistException, CarBrandNotExistException {
        carBrandService.delete(id);
        return Helper.GetTemplateWithMap("url", "/system/carbrand/list");
    }

    @RequestMapping(name = "获取所有品牌",value = "/allBrand",method = RequestMethod.GET)
    @ResponseBody
    public Template getAllBrand() throws RemoteException {
        Template template = new Template();
        template.setData(carBrandService.getCarBrandList(0,500).getList());
        return template;

    }


    @RequestMapping(name = "根据品牌获取车商车系信息",value = "/getSubAndLineInfo",method = RequestMethod.POST)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public Template getAllSubAndLineByBrand(@RequestParam(value = "carBrandId")Long carBrandId)throws RemoteException{
        Template template = new Template();
        List<CarSubBrandDTO> subBrands =  carSubBrandService.getCarSubBrandByCarBrandId(carBrandId);
        int i = subBrands.size();
        CarSubBrandDTO carSubBrandDTO = null;
        List resultList = new ArrayList();
        for (int j = 0;j<i;j++){
            Map map = new HashMap();
            carSubBrandDTO = subBrands.get(j);
            List<CarLineDTO> carLineDTOs = carLineService.getCarLineListByCarSubBrandId(carSubBrandDTO.getId());
            map.put("carSubBrand",carSubBrandDTO);
            map.put("carLineList",carLineDTOs);
            resultList.add(map);
        }
        template.setData(resultList);
        template.setCode(DictEnum.success_code);
        return template;
    }
}