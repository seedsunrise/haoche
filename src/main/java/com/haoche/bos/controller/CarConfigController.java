package com.haoche.bos.controller;

import com.basedata.remoting.dto.carConfigDTO.CarConfigEntity;
import com.basedata.remoting.exceptions.CarConfigNotExistException;
import com.basedata.remoting.stub.CarConfigInterface;
import com.haoche.bos.datamapper.Template;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/carConfig")
public class CarConfigController {

    @Autowired
    public CarConfigInterface carConfigInterface;

    @ResponseBody
    @RequestMapping(name = "获取车辆配置",value = "/getConfig",method = RequestMethod.GET)
    public Template getCarConfig(@RequestParam(value = "carModleId",defaultValue = "0")Long carModleId) throws RemoteException, CarConfigNotExistException {
        return this.getCarConfigTemplate(carModleId);
    }

    @ResponseBody
    @RequestMapping(name = "更新车型配置信息",value = "updateCarConfig",method = RequestMethod.POST)
    public Template updateCarConfig(@RequestParam(value = "carModleId",defaultValue = "0") Long carModleId,
                                    @RequestParam(value = "autohomeId",defaultValue = "0")int autohomeId) throws RemoteException {
        carConfigInterface.updateCarConfig(carModleId, autohomeId);
        return getCarConfigTemplate(carModleId);
    }

    private Template getCarConfigTemplate(long carModleId) {
        Template template = new Template();
        Map map = new HashMap();
        if (carModleId != 0) {
            try {
                CarConfigEntity carConfigEntity = carConfigInterface.getCarConfigByCarModelId(carModleId);
                map.put("config", carConfigEntity);
                template.setData(map);
            } catch (Exception e) {
                template.setCode("500");
                template.setMsg("该车型无配置");
            }
        }
        return template;
    }
}
