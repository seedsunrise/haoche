package com.haoche.bos.controller;

import com.haoche.bos.datamapper.Template;
import com.haoche.bos.service.CityService;
import com.haoche.bos.service.ShopService;
import com.haoche.remoting.dto.CityDTO;
import com.haoche.remoting.dto.PageNateDTO;
import com.haoche.remoting.dto.ShopDTO;
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
 * 门店控制器
 * Created by allan on 2016/5/6.
 */
@RequestMapping("/system/shop")
@Controller
public class ShopController {

    @Autowired
    private ShopService shopService;
    @Autowired
    private CityService cityService;

    @RequestMapping(name = "门店列表",value = "/list", method = RequestMethod.GET)
    public ModelAndView main(String cityName,
                             @RequestParam(value = "pageNo",defaultValue = "0")Integer pageNo,
                             @RequestParam(value = "pageSize",defaultValue = "10")Integer pageSize) throws RemoteException {
        PageNateDTO pageNateDTO;
        Map<String,Object> map = new HashMap<>();
        if(!StringUtils.isEmpty(cityName)){
            pageNateDTO = this.shopService.getShopListByCityName(cityName,pageNo,pageSize);
            map.put("cityName",cityName);
        }else{
            pageNateDTO = this.shopService.getShopList(pageNo,pageSize);
        }
        map.put("page",pageNateDTO);
        return new ModelAndView("/system/shop/list","map",map);
    }

    /**
     * 到更新门店页面
     * @param shopId 门店id
     * @return
     * @throws RemoteException
     */
    @RequestMapping(name = "门店编辑/新建页面",value = "/edit", method = RequestMethod.GET)
    public ModelAndView updatePage(@RequestParam(value="shopId",defaultValue = "0")Long shopId) throws RemoteException {
        ModelAndView mv = new ModelAndView("/system/shop/edit");
        ShopDTO shopDTO = new ShopDTO();
        if (shopId != 0) {
            shopDTO = this.shopService.getShopById(shopId);
        }
        List<CityDTO> cityDTOList = this.cityService.getCityListByName("%%");
        mv.addObject("shopDTO",shopDTO);
        mv.addObject("cityDTOList",cityDTOList);
        return mv;
    }

    /**
     * 保存门店（添加、修改）
     * @return json
     * @throws RemoteException
     */
    @ResponseBody
    @RequestMapping(name = "新建/编辑门店更新动作",value = "/update", method = RequestMethod.POST)
    public Object save(@ModelAttribute ShopDTO shopDTO) throws RemoteException {
        this.shopService.save(shopDTO);
        Template template = new Template();
        Map map = new HashMap();
        map.put("url","/system/shop/list");
        template.setData(map);
        return template;
    }

    @RequestMapping(name="删除门店", value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Object delete(@RequestParam (value = "id")Long id) throws RemoteException {
        this.shopService.delete(id);
        Template template = new Template();
        Map map = new HashMap();
        map.put("url","/system/shop/list");
        template.setData(map);
        return template;
    }
}
