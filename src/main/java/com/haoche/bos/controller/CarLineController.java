package com.haoche.bos.controller;

import com.basedata.remoting.dto.CarBrandDTO;
import com.basedata.remoting.dto.CarLineDTO;
import com.basedata.remoting.dto.CarSubBrandDTO;
import com.basedata.remoting.dto.PageNateDTO;
import com.basedata.remoting.exceptions.CarLineExistException;
import com.basedata.remoting.exceptions.CarLineNotExistException;
import com.haoche.bos.datamapper.Template;
import com.haoche.bos.service.CarBrandService;
import com.haoche.bos.service.CarLineService;
import com.haoche.bos.service.CarSubBrandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by tiger on 2016/5/12.
 */
@Controller
@RequestMapping("/system/carline")
public class CarLineController {
    @Autowired
    private CarLineService carLineService;
    @Autowired
    private CarSubBrandService carSubBrandService;
    @Autowired
    private CarBrandService carBrandService;

    @RequestMapping(name = "车系列表页面", value = "/list", method = RequestMethod.GET)
    public ModelAndView list(@RequestParam(value = "lineName",defaultValue = "") String lineName,
                             @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                             @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) throws RemoteException {
        PageNateDTO pageNateDTO = null;
        Map map = new HashMap();
        if (!StringUtils.isEmpty(lineName)) {
            pageNateDTO = this.carLineService.getCarLineListByName(lineName, pageNo, pageSize);
            map.put("lineName", lineName);
        } else {
            pageNateDTO = this.carLineService.getCarLineList(pageNo, pageSize);
        }
        map.put("page",pageNateDTO);
        return new ModelAndView("/system/carline/list", "map", map);
    }

    @RequestMapping(name = "新增编辑/车系页面",value = "/edit", method = RequestMethod.GET)
    public ModelAndView updatePage(@RequestParam(value="id",defaultValue = "0")Long id) throws RemoteException, CarLineNotExistException {
        ModelAndView mv = new ModelAndView("/system/carline/edit");
        CarLineDTO carLineDTO = new CarLineDTO();
        if (id != 0) {
            carLineDTO = this.carLineService.getCarLineById(id);
        }
        List<CarSubBrandDTO> carSubBrandDTOList = this.carSubBrandService.getCarBrandListByName("%%");
        List<CarBrandDTO> carBrandDTOList = this.carBrandService.getCarBrandListByName("%%");
        mv.addObject("carLineDTO",carLineDTO);
        mv.addObject("carSubBrandDTOList",carSubBrandDTOList);
        mv.addObject("carBrandDTOList",carBrandDTOList);
        return mv;
    }

    @RequestMapping(name="新增/更新车系", value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Object update(@ModelAttribute CarLineDTO carLineDTO) throws CarLineExistException, RemoteException {
        carLineService.save(carLineDTO);
        Template template = new Template();
        Map map = new HashMap();
        map.put("url","/system/carline/list");
        template.setData(map);
        return template;
    }

    @ResponseBody
    @RequestMapping(name = "根据生产厂商获取车辆车系列表", value = "/getCarLineListByCarSubBrandId", method = RequestMethod.GET)
    public  ModelAndView getCarLineListByCarSubBrandId(@RequestParam(value = "id")Long id) throws RemoteException {
        return new ModelAndView("/system/carline/carLineListTpl", "carLineList", carLineService.getCarLineListByCarSubBrandId(id));
    }

    @RequestMapping(name = "删除车系", value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Object delete(@RequestParam(value = "id")Long id) throws RemoteException{
        carLineService.delete(id);
        Map map = new HashMap<>();
        Template template = new Template();
        map.put("url","/system/carline/list");
        template.setData(map);
        return template;
    }
}

