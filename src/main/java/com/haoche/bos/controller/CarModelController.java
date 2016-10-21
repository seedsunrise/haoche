package com.haoche.bos.controller;

import com.basedata.remoting.dto.*;
import com.haoche.bos.datamapper.Template;
import com.haoche.bos.service.CarBrandService;
import com.haoche.bos.service.CarLineService;
import com.haoche.bos.service.CarModelService;
import com.haoche.bos.service.CarSubBrandService;
import com.haoche.bos.util.DictEnum;
import com.haoche.bos.util.Helper;
import org.springframework.beans.factory.annotation.Autowired;
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
@RequestMapping("/system/carmodel")
public class CarModelController {
    @Autowired
    private CarModelService carModelService;
    @Autowired
    private CarLineService carLineService;
    @Autowired
    private CarSubBrandService carSubBrandService;
    @Autowired
    private CarBrandService carBrandService;

    @RequestMapping(name = "车型列表页面", value = "/list", method = RequestMethod.GET)
    public ModelAndView list(@RequestParam(value = "modelName",defaultValue = "") String modelName,
                             @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                             @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) throws RemoteException {
        PageNateDTO pageNateDTO = null;
        Map map = new HashMap();
        if (!StringUtils.isEmpty(modelName)) {
            pageNateDTO = this.carModelService.getCarModelListByName(modelName, pageNo, pageSize);
            map.put("modelName", modelName);
        } else {
            pageNateDTO = this.carModelService.getCarModelList(pageNo, pageSize);
        }
        map.put("page",pageNateDTO);
        return new ModelAndView("/system/carmodel/list", "map", map);
    }

    @RequestMapping(name = "新增编辑/车型页面",value = "/edit", method = RequestMethod.GET)
    public ModelAndView updatePage(@RequestParam(value="id",defaultValue = "0")Long id) throws RemoteException {
        ModelAndView mv = new ModelAndView("/system/carmodel/edit");
        CarModelDTO carModelDTO = new CarModelDTO();
        if (id != 0) {
            carModelDTO = this.carModelService.getCarModelById(id);
        }
        List<CarLineDTO> carLineDTOList = this.carLineService.getCarLineListByName("%%");
        List<CarSubBrandDTO> carSubBrandDTOList = this.carSubBrandService.getCarBrandListByName("%%");
        List<CarBrandDTO> carBrandDTOList = this.carBrandService.getCarBrandListByName("%%");
        mv.addObject("carModelDTO",carModelDTO);
        mv.addObject("carLineDTOList",carLineDTOList);
        mv.addObject("carSubBrandDTOList",carSubBrandDTOList);
        mv.addObject("carBrandDTOList",carBrandDTOList);
        return mv;
    }

    @RequestMapping(name="新增/更新车型", value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Object update(@ModelAttribute CarModelDTO carModelDTO) throws RemoteException {
    if(carModelDTO.getModelYear() != null){
        String year = carModelDTO.getModelYear();
        String[] years = year.split(",");
        carModelDTO.setModelYear(years[1]);
    }
        carModelService.save(carModelDTO);
        return Helper.GetTemplateWithMap("url", "/system/carmodel/list");
    }

    @ResponseBody
    @RequestMapping(name = "根据车系id获取车型", value = "/getCarModelListByCarLineId", method = RequestMethod.GET)
    public  ModelAndView getCarModelListByCarLineId(@RequestParam(value = "id")Long id) throws RemoteException {
        return new ModelAndView("/system/carmodel/carModelListTpl", "carModelList", carModelService.getCarModelListByCarLineId(id));
    }

    @ResponseBody
    @RequestMapping(name = "删除车型", value = "/delete", method = RequestMethod.POST)
    public Object delete(@RequestParam(value = "id")Long id) throws RemoteException{
        carModelService.delete(id);
        return Helper.GetTemplateWithMap("url", "/system/carmodel/list");
    }

    @ResponseBody
    @RequestMapping(name = "根据车系id获取各个年份车数据", value = "/getModelListByLineId", method = RequestMethod.POST)
    public  Template getModelListByLineId(@RequestParam(value = "id")Long id) throws RemoteException {
        Template template = new Template();
        List<Map> resList = carModelService.getCarModelByYear(id);
        template.setData(resList);
        template.setCode(DictEnum.success_code);
        return template;
    }
}