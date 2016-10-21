package com.haoche.bos.controller;

import com.haoche.bos.datamapper.Template;
import com.haoche.remoting.dto.InsuranceDTO;
import com.haoche.remoting.dto.InsuranceQuoteDTO;
import com.haoche.remoting.stub.InsuranceQuoteInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.rmi.RemoteException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/carInsurance")
public class CarInsuranceController {

    @Autowired
    private InsuranceQuoteInterface insuranceQuoteInterface;

    @Value("${platform.image.url}")
    private String imageUrl;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(int.class, "0",new CustomNumberEditor(Integer.class, false));
        binder.registerCustomEditor(long.class, "0",new CustomNumberEditor(Long.class, false));
    }

    // 通知保险报价
    @ResponseBody
    @RequestMapping(name = "通知保险报价",value = "/noticeQuote",method = RequestMethod.POST)
    public Template noticeQuote(@RequestParam(value = "quoteId",defaultValue = "0") Long quoteId,
                            @RequestParam(value = "carInfoId",defaultValue = "0")Long carInfoId) throws RemoteException {
        if (quoteId != 0 || carInfoId != 0) {
            insuranceQuoteInterface.noticeQuote(carInfoId,quoteId);
        }
        return new Template();
    }

    @RequestMapping(name = "车险报价页面",value = "/edit",method = RequestMethod.GET)
    public ModelAndView edit(@RequestParam(value = "carInfoId",defaultValue = "0")Long carInfoId) throws RemoteException {
        Map map = new HashMap();
        map.put("imageUrl",imageUrl);
        map.put("insuranceQuote",insuranceQuoteInterface.getInsuranceQuote(carInfoId));
        return new ModelAndView("/goods/insuranceQuote","map",map);
    }

    @ResponseBody
    @RequestMapping(name = "车险报价",value = "/update",method = RequestMethod.POST)
    public Template edit(@ModelAttribute InsuranceQuoteDTO insuranceDTO) throws RemoteException {
        insuranceQuoteInterface.insuranceQuote(insuranceDTO);
        return new Template();
    }


    @ResponseBody
    @RequestMapping(name = "获取车辆报价信息JSON", value = "/getInsuranceQuote", method = RequestMethod.POST)
    public Template getInsuranceQuote(@RequestParam(value = "carInfoId")Long carInfoId) throws RemoteException {
        Template template = new Template();
        template.setData(insuranceQuoteInterface.getInsuranceQuote(carInfoId));
        return template;
    }
}