package com.haoche.bos.controller;

import com.haoche.bos.datamapper.Template;
import com.haoche.bos.service.CityService;
import com.haoche.remoting.dto.CityDTO;
import com.haoche.remoting.dto.PageNateDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.Map;

/**
 * 系统设置-城市设置，控制层
 * Created by allan on 2016/5/5.
 */
@Controller
@RequestMapping("/system/city")
public class CityController {

    @Autowired
    private CityService cityService;

    /**
     * 系统设置-城市设置，主页
     * @param pageNo
     * @param pageSize
     * @return
     * @throws RemoteException
     */
    @RequestMapping(name = "城市列表",value = "/list", method = RequestMethod.GET)
    public ModelAndView main(String cityName,
                             @RequestParam(value = "pageNo",defaultValue = "0")Integer pageNo,
                             @RequestParam(value = "pageSize",defaultValue = "10")Integer pageSize) throws RemoteException {
        Map<String,Object> map = new HashMap<>();
        PageNateDTO pageNateDTO = null;
        if(!StringUtils.isEmpty(cityName)){
            pageNateDTO = this.cityService.getCityListByName(cityName,pageNo,pageSize);
            map.put("cityName",cityName);
        }else{
            pageNateDTO = this.cityService.getCityList(pageNo,pageSize);
        }
        map.put("page",pageNateDTO);
        return new ModelAndView("/system/city/list","map",map);
    }

    /**
     * 获取城市列表分页
     * @param pageNo
     * @param pageSize
     * @return json
     * @throws RemoteException
     */
    @RequestMapping(name = "城市列表分页",value = "/cityPage", method = RequestMethod.GET)
    public @ResponseBody Map<String,Object> cityPage (@RequestParam(value = "pageNo",defaultValue = "0")Integer pageNo,
                                   @RequestParam(value = "pageSize",defaultValue = "10")Integer pageSize) throws RemoteException {
        Map<String,Object> resultMap = new HashMap<>();
        PageNateDTO pageNateDTO = this.cityService.getCityList(pageNo,pageSize);
        resultMap.put("stauts",true);
        resultMap.put("pageNateDTO",pageNateDTO);
        return resultMap;
    }

    /**
     * 修改/新增 城市页面
     * @param cityId 城市id
     * @return
     * @throws RemoteException
     */
    @RequestMapping(name = "修改城市页面",value = "/edit", method = RequestMethod.GET)
    public ModelAndView update(@RequestParam(value = "cityId", defaultValue = "0")Long cityId) throws RemoteException {
        CityDTO cityDTO;
        if (cityId != 0) {
            cityDTO = this.cityService.getCityById(cityId);
            return new ModelAndView("/system/city/edit", "city", cityDTO);
        } else {
            return new ModelAndView("/system/city/edit");
        }
    }

    /**
     * 保存城市
     * @param cityId 城市id
     * @param cityName 城市名称
     * @param cityChar 城市字符
     * @param baiduCityCode 百度城市Code
     * @param saleOpened 开通二手业务
     * @return json
     * @throws RemoteException
     */
    @ResponseBody
    @RequestMapping(name = "保存城市",value = "/update", method = RequestMethod.POST)
    public Object save(Long cityId,
                            @RequestParam(value = "cityName")String cityName,
                            @RequestParam(value = "cityChar")Character cityChar,
                            @RequestParam(value = "baiduCityCode")Integer baiduCityCode,
                            @RequestParam(value = "saleOpened")Boolean saleOpened) throws RemoteException {
        CityDTO cityDTO = new CityDTO();

        if(cityId == null){
            cityDTO.setCityName(cityName);
            cityDTO.setCityChar(cityChar);
            cityDTO.setSaleOpened(saleOpened);
            cityDTO.setBaiduCityCode(baiduCityCode);
        }else{
            cityDTO = this.cityService.getCityById(cityId);
            cityDTO.setCityName(cityName);
            cityDTO.setCityChar(cityChar);
            cityDTO.setSaleOpened(saleOpened);
            cityDTO.setBaiduCityCode(baiduCityCode);
        }

        this.cityService.save(cityDTO);

        Template template = new Template();
        Map map = new HashMap();
        map.put("url","/system/city/list");
        if(cityId == null){
            template.setCode("200");
            template.setMsg("添加城市成功");
        }else {
            template.setCode("200");
            template.setMsg("更新城市成功");
        }
        template.setData(map);
        return template;
    }

    @RequestMapping(name="删除城市", value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Object delete(@RequestParam (value = "id")Long id) throws RemoteException {
        this.cityService.delete(id);
        Template template = new Template();
        Map map = new HashMap();
        map.put("url","/system/city/list");
        template.setData(map);
        return template;
    }
}