package com.haoche.bos.controller;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.haoche.bos.util.Helper;
import com.haoche.remoting.dto.CarExtraItemDTO;
import com.haoche.remoting.dto.PageNateDTO;
import com.haoche.remoting.enums.ExtraItemEnum;
import com.haoche.remoting.stub.CarExtraItemInterface;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 保养、美容、精品加装项目 控制类
 * Created by Ken on 2016/7/18.
 */
@Controller
@RequestMapping("/extraItem")
public class CarExtraItemController {

    @Resource
    private CarExtraItemInterface carExtraItemInterface;

    @RequestMapping(name = "额外项目列表", value = "/list", method = RequestMethod.GET)
    public ModelAndView getList(@RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                       @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) throws RemoteException {
        PageNateDTO pageNateDTO = carExtraItemInterface.getList(pageNo, pageSize);
        Map<String, Object> map = new HashMap<>();
        map.put("page", pageNateDTO);
        return new ModelAndView("/system/extraItem/extraItemList", "map", map);
    }

    @RequestMapping(name = "编辑/新增额外项目页面", value = "/edit", method = RequestMethod.GET)
    public ModelAndView toEditItem(@RequestParam(value = "id", defaultValue = "0") Long id) throws RemoteException {
        Map<String, Object> map = new HashMap<>();
        CarExtraItemDTO itemDTO = new CarExtraItemDTO();
        if (id != 0) {
            itemDTO = carExtraItemInterface.getItemById(id);
        }
        map.put("item", itemDTO);
        map.put("type", ExtraItemEnum.getAll());
        return new ModelAndView("/system/extraItem/extraItemEdit", "map", map);
    }

    @RequestMapping(name = "更新/新增额外项目", value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Object editItem(@ModelAttribute CarExtraItemDTO carExtraItemDTO) throws RemoteException {
        carExtraItemInterface.saveItem(carExtraItemDTO);
        return Helper.GetTemplateWithMap("url", "/system/extraItem/extraItemList");
    }

    @RequestMapping(name = "删除额外项目", value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Object deleteItem(@RequestParam(value = "id") Long id) throws RemoteException {
        carExtraItemInterface.removeItem(id);
        return Helper.getSuccessTemplate("删除成功!");
    }

    @RequestMapping(name = "类型获取额外项目列表", value = "/typeList", method = RequestMethod.POST)
    @ResponseBody
    public Object getItemListByType(@RequestParam(value = "type") int type) throws RemoteException {
        List<CarExtraItemDTO> resultList = carExtraItemInterface.getItemByType(type);
        return Helper.getTemplateWithData(resultList);
    }
}
