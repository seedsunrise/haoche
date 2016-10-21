package com.haoche.bos.controller;

import com.haoche.remoting.dto.PageNateDTO;
import com.haoche.remoting.stub.CarInfoApplyInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("carInfoApply")
public class CarInfoApplyController {

    @Autowired
    private CarInfoApplyInterface carInfoApplyInterface;

    @RequestMapping(name = "车源入库申请列表",value = "/list",method = RequestMethod.GET)
    public Object list(@RequestParam(defaultValue = "0") int pageNo,@RequestParam(defaultValue = "10") int pageSize, @RequestParam(defaultValue = "") String search) throws RemoteException {
        PageNateDTO pageNateDTO = carInfoApplyInterface.carInfoApplys(pageNo,pageSize,0L,search);
        Map map = new HashMap();
        map.put("page",pageNateDTO);
        map.put("search",search);
        return new ModelAndView("/carsource/carInfoApplyList","map",map);
    }
}
