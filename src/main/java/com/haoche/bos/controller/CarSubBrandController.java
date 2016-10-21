package com.haoche.bos.controller;

import com.basedata.remoting.dto.CarBrandDTO;
import com.basedata.remoting.dto.CarSubBrandDTO;
import com.basedata.remoting.dto.PageNateDTO;
import com.basedata.remoting.exceptions.CarSubBrandExistException;
import com.basedata.remoting.exceptions.CarSubBrandNotExistException;
import com.haoche.bos.datamapper.Template;
import com.haoche.bos.service.CarBrandService;
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

@Controller
@RequestMapping("/system/carsubbrand")
public class CarSubBrandController {

    @Autowired
    private CarSubBrandService carSubBrandService;
    @Autowired
    private CarBrandService carBrandService;

    @RequestMapping(name = "生产厂商列表页面", value = "/list", method = RequestMethod.GET)
    public ModelAndView list(@RequestParam(value = "subBrandName",defaultValue = "") String subBrandName,
                             @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                             @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) throws RemoteException {
        PageNateDTO pageNateDTO;
        Map map = new HashMap();
        if (!StringUtils.isEmpty(subBrandName)) {
            pageNateDTO = this.carSubBrandService.getCarSubBrandListByBrandName(subBrandName, pageNo, pageSize);
            map.put("subBrandName", subBrandName);
        } else {
            pageNateDTO = this.carSubBrandService.getCarSubBrandList(pageNo, pageSize);
        }
        map.put("page",pageNateDTO);
        return new ModelAndView("/system/carsubbrand/list", "map", map);
    }

    @RequestMapping(name = "新增编辑/生产厂商页面",value = "/edit", method = RequestMethod.GET)
    public ModelAndView updatePage(@RequestParam(value="id",defaultValue = "0")Long id) throws RemoteException, CarSubBrandNotExistException {
        ModelAndView mv = new ModelAndView("/system/carsubbrand/edit");
        CarSubBrandDTO carSubBrandDTO = new CarSubBrandDTO();
        if (id != 0) {
            carSubBrandDTO = this.carSubBrandService.getCarSubBrandById(id);
        }
        List<CarBrandDTO> carBrandDTOList = this.carBrandService.getCarBrandListByName("%%");
        mv.addObject("carSubBrandDTO",carSubBrandDTO);
        mv.addObject("carBrandDTOList",carBrandDTOList);
        return mv;
    }

    @ResponseBody
    @RequestMapping(name="新增/更新生产厂商", value = "/update", method = RequestMethod.POST)
    public Object update(@ModelAttribute CarSubBrandDTO carSubBrandDTO) throws RemoteException, CarSubBrandExistException {
        carSubBrandService.save(carSubBrandDTO);
        Template template = new Template();
        Map map = new HashMap();
        map.put("url","/system/carsubbrand/list");
        template.setData(map);
        return template;
    }

    @ResponseBody
    @RequestMapping(name = "根据车辆品牌id获取厂商列表", value = "/getCarSubBrandByCarBrandId", method = RequestMethod.GET)
    public  ModelAndView getCarSubBrandByCarBrandId(@RequestParam(value = "id")Long id) throws RemoteException {
        return new ModelAndView("/system/carsubbrand/subBrandListTpl", "subBrandList", carSubBrandService.getCarSubBrandByCarBrandId(id));
    }

    @RequestMapping(name="删除生产厂商", value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Object delete(@RequestParam(value = "id")Long id) throws RemoteException{
        carSubBrandService.delete(id);
        Map map = new HashMap();
        Template template = new Template();
        map.put("url","/system/carsubbrand/list");
        template.setData(map);
        return template;
    }
}
