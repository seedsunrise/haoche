package com.haoche.bos.controller;

import com.haoche.bos.datamapper.Template;
import com.haoche.bos.service.CarBusinessService;
import com.haoche.bos.service.CityService;
import com.haoche.remoting.dto.CarBusinessDTO;
import com.haoche.userauth.remoting.dto.BusinessUserDTO;
import com.haoche.userauth.remoting.dto.PageNateDTO;
import com.haoche.userauth.remoting.stub.BusinessUserInertface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/system/business")
public class CarBusinessController {

    @Autowired
    private CarBusinessService carBusinessService;

    @Autowired
    private CityService cityService;

    @Autowired
    private BusinessUserInertface businessUserInertface;

    @Value("${platform.image.url}")
    private String imageUrl;

    @RequestMapping(name = "车商列表",value = "/list",method = RequestMethod.GET)
    public Object list(@RequestParam(value = "pageNo",defaultValue = "0")int pageNo,
                       @RequestParam(value = "pageSize",defaultValue = "10")int pageSize,
                       @RequestParam(value = "cityName",defaultValue = "")String cityName) throws RemoteException {
        Map map = new HashMap();
        map.put("imageUrl",imageUrl);
        map.put("page",carBusinessService.list(pageNo,pageSize,cityName));
        return new ModelAndView("/system/business/list","map",map);
    }

    @RequestMapping(name = "新建/更改车商页面",value = "/edit",method = RequestMethod.GET)
    public ModelAndView edit(@RequestParam(value = "id",defaultValue = "0") Long id) throws RemoteException {
        CarBusinessDTO carBusinessDTO = new CarBusinessDTO();
        if (id != 0) {
            carBusinessDTO = carBusinessService.findOne(id);
        }
        Map map = new HashMap();
        map.put("imageUrl",imageUrl);
        map.put("business",carBusinessDTO);
        map.put("cityList",cityService.getCityList(0,500).getList());
        return new ModelAndView("/system/business/edit","map",map);
    }

    @ResponseBody
    @RequestMapping(name = "新建/更新车商动作",value = "/update",method = RequestMethod.POST)
    public Template update(@ModelAttribute CarBusinessDTO carBusinessDTO) throws RemoteException {
        carBusinessService.update(carBusinessDTO);
        Template template = new Template();
        Map map = new HashMap();
        map.put("url","/system/business/list");
        template.setData(map);
        return template;
    }

    @ResponseBody
    @RequestMapping(name = "更改车商营业状态",value = "/changeOpenStatus",method = RequestMethod.POST)
    public Template changeOpenStatus(@RequestParam (value = "id",defaultValue = "0")Long id,
                                     @RequestParam(value = "isOpened",defaultValue = "0")int isOpened) throws RemoteException {
        if (id!=0) {
            carBusinessService.changeStatus(id,isOpened);
        }
        Template template = new Template();
        Map map = new HashMap();
        map.put("url","/system/business/list");
        template.setData(map);
        return template;
    }

    @ResponseBody
    @RequestMapping(name = "删除车商",value = "/delete",method = RequestMethod.POST)
    public Template delete(@RequestParam (value = "id",defaultValue = "0")Long id) throws RemoteException {
        if (id!=0) {
            carBusinessService.delete(id);
        }
        Template template = new Template();
        Map map = new HashMap();
        map.put("url","/system/business/list");
        template.setData(map);
        return template;
    }

    @RequestMapping(name = "车商帐号列表",value = "/accountList",method = RequestMethod.GET)
    public Object delete(@RequestParam(value = "pageNo",defaultValue = "0")int pageNo,
                           @RequestParam(value = "pageSize",defaultValue = "10")int pageSize,
                           @RequestParam(value = "search",defaultValue = "")String search) throws RemoteException {
        PageNateDTO pageNateDTO = businessUserInertface.accountList(pageNo,pageSize,search);
        Map map = new HashMap();
        map.put("page",pageNateDTO);
        map.put("search",search);
        return new ModelAndView("/system/business/accountList","map",map);
    }

    @RequestMapping(name = "新建/更改车商帐号页面",value = "/accountEdit",method = RequestMethod.GET)
    public ModelAndView accountEdit(@RequestParam(value = "id",defaultValue = "0") Long id) throws RemoteException {
        BusinessUserDTO businessUserDTO = new BusinessUserDTO();
        if (id != 0) {
            businessUserDTO = businessUserInertface.getBusinessUser(id);
        }
        Map map = new HashMap();
        map.put("imageUrl",imageUrl);
        map.put("business",businessUserDTO);
        map.put("businessList",carBusinessService.list(0,500,"").getList());
        return new ModelAndView("/system/business/accountEdit","map",map);
    }

    @ResponseBody
    @RequestMapping(name = "新建/更改车商帐号页面",value = "/accountUpdate",method = RequestMethod.POST)
    public Template accountEdit(BusinessUserDTO businessUserDTO) throws RemoteException {
        Template template = new Template();
        businessUserInertface.updateAccountUser(businessUserDTO);
        Map map = new HashMap();
        map.put("url","/system/business/accountList");
        template.setData(map);
        return new Template();
    }

    @ResponseBody
    @RequestMapping(name = "删除车商帐号",value = "/accountDelete",method = RequestMethod.POST)
    public Template accountDelete(@RequestParam (value = "id",defaultValue = "0")Long id) throws RemoteException {
        Template template = new Template();
        businessUserInertface.delete(id);
        return template;
    }

}
