package com.haoche.bos.controller;

import com.haoche.bos.datamapper.Template;
import com.haoche.bos.service.ModelFuelConsumptionService;
import com.haoche.remoting.dto.PageNateDTO;
import com.haoche.remoting.dto.capp.ModelFuelConsumptionDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.Map;

/**
 * 车型油耗
 * Created by allan on 2016/7/12.
 */
@Controller
@RequestMapping("/user")
public class ModelFuelConsumptionController {
    @Autowired
    ModelFuelConsumptionService modelFuelConsumptionService;

    @RequestMapping(name="车型油耗列表页面",value = "/list",method = RequestMethod.GET)
    public ModelAndView list(String modelName,
                             @RequestParam(value = "pageNo",defaultValue = "0") int pageNo,
                             @RequestParam(value = "pageSize",defaultValue = "10")int pageSize) throws RemoteException {
        PageNateDTO page = this.modelFuelConsumptionService.getModelFuelConsumptionList(modelName,pageNo,pageSize);

        Map<String,Object> map = new HashMap<>();
        map.put("modelName",modelName);
        map.put("page",page);
        return new ModelAndView("/user/modelFuelConsumption/list","map",map);
    }

    @RequestMapping(name="未设置油耗车型列表页面",value = "/notSetList",method = RequestMethod.GET)
    public ModelAndView notSetList(@RequestParam(value = "pageNo",defaultValue = "0") int pageNo,
                                   @RequestParam(value = "pageSize",defaultValue = "10")int pageSize) throws RemoteException {
        PageNateDTO page = this.modelFuelConsumptionService.queryNoSetModel(pageNo,pageSize);

        return new ModelAndView("/user/modelFuelConsumption/notSetList","page",page);
    }

    @ResponseBody
    @RequestMapping(name="车型油耗保存",value = "/edit",method = RequestMethod.POST)
    public Template edit(Long id,
                         @RequestParam(value="brandId")Long brandId,
                         @RequestParam(value="brandName")String brandName,
                         @RequestParam(value="subBrandId")Long subBrandId,
                         @RequestParam(value="subBrandName")String subBrandName,
                         @RequestParam(value="lineId")Long lineId,
                         @RequestParam(value="lineName")String lineName,
                         @RequestParam(value="modelId")Long modelId,
                         @RequestParam(value="modelName")String modelName,
                         @RequestParam(value="fcphk")double fcphk) throws RemoteException {
        ModelFuelConsumptionDTO modelFuelConsumptionDTO;
        if(id == null){
            modelFuelConsumptionDTO = new ModelFuelConsumptionDTO();
            modelFuelConsumptionDTO.setBrandId(brandId);
            modelFuelConsumptionDTO.setBrandName(brandName);
            modelFuelConsumptionDTO.setSubBrandId(subBrandId);
            modelFuelConsumptionDTO.setSubBrandName(subBrandName);
            modelFuelConsumptionDTO.setLineId(lineId);
            modelFuelConsumptionDTO.setLineName(lineName);
            modelFuelConsumptionDTO.setModelId(modelId);
            modelFuelConsumptionDTO.setModelName(modelName);
            modelFuelConsumptionDTO.setFcphk(fcphk);
        }else {
            modelFuelConsumptionDTO = this.modelFuelConsumptionService.getModelFuelConsumption(id);
            modelFuelConsumptionDTO.setFcphk(fcphk);
        }
        this.modelFuelConsumptionService.save(modelFuelConsumptionDTO);
        Template template = new Template();
        template.setMsg("操作成功");
        return template;
    }

    @ResponseBody
    @RequestMapping(name="车型油耗删除",value = "/delete",method = RequestMethod.POST)
    public Template edit(@RequestParam(value="id")Long id) throws RemoteException {
        this.modelFuelConsumptionService.deleteModelFuelConsumption(id);
        Template template = new Template();
        template.setMsg("操作成功");
        return template;
    }
}
