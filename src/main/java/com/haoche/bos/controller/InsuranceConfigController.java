package com.haoche.bos.controller;

import com.haoche.bos.util.Helper;
import com.haoche.remoting.dto.InsuranceCompanyDTO;
import com.haoche.remoting.dto.InsuranceQuoterDTO;
import com.haoche.remoting.dto.PageNateDTO;
import com.haoche.remoting.stub.InsuranceConfigInterface;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.Map;

/**
 * 保险配置相关控制类
 * Created by Ken on 2016/7/4.
 */
@Controller
@RequestMapping("/insurance")
public class InsuranceConfigController {

    @Resource
    private InsuranceConfigInterface insuranceConfigInterface;

    @Value("${platform.image.url}")
    private String imageUrl;

    @RequestMapping(name = "保险公司列表页面", value = "/company/list", method = RequestMethod.GET)
    public ModelAndView getCompanyList(@RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                       @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) throws RemoteException {
        PageNateDTO pageNateDTO = insuranceConfigInterface.getCompanyList(pageNo, pageSize);
        Map<String, Object> map = new HashMap<>();
        map.put("imageUrl", imageUrl);
        map.put("page", pageNateDTO);
        return new ModelAndView("/system/insurance/companyList", "map", map);
    }

    @RequestMapping(name = "编辑/新增保险公司页面", value = "/company/edit", method = RequestMethod.GET)
    public ModelAndView toEditCompany(@RequestParam(value = "id", defaultValue = "0") Long id) throws RemoteException {
        Map<String, Object> map = new HashMap<>();
        map.put("imageUrl", imageUrl);
        InsuranceCompanyDTO insuranceCompanyDTO = new InsuranceCompanyDTO();
        if (id != 0) {
            insuranceCompanyDTO = insuranceConfigInterface.getCompanyById(id);
        }
        map.put("company", insuranceCompanyDTO);
        return new ModelAndView("/system/insurance/companyEdit", "map", map);
    }

    @RequestMapping(name = "更新/新增保险公司动作", value = "/company/update", method = RequestMethod.POST)
    @ResponseBody
    public Object editCompany(@ModelAttribute InsuranceCompanyDTO insuranceCompanyDTO) throws RemoteException {
        insuranceConfigInterface.saveCompany(insuranceCompanyDTO);
        return Helper.GetTemplateWithMap("url", "/insurance/company/list");
    }

    @RequestMapping(name = "删除保险公司", value = "/company/delete", method = RequestMethod.POST)
    @ResponseBody
    public Object deleteCompany(@RequestParam(value = "id") Long id) throws RemoteException {
        insuranceConfigInterface.removeCompany(id);
        return Helper.getSuccessTemplate("删除成功!");
    }

    @RequestMapping(name = "获取保险公司下拉框", value = "/company/selectList", method = RequestMethod.POST)
    @ResponseBody
    public Object getAllCompanyList() throws RemoteException {
        return insuranceConfigInterface.getAllCompanyList();
    }

    @RequestMapping(name = "报价员列表页面", value = "/quoter/list", method = RequestMethod.GET)
    public ModelAndView getQuoterList(@RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) throws RemoteException {
        PageNateDTO pageNateDTO = insuranceConfigInterface.getQuoterList(pageNo, pageSize);
        Map<String,Object> map = new HashMap<>();
        map.put("page",pageNateDTO);
        return new ModelAndView("/system/insurance/quoterList", "map", map);
    }

    @RequestMapping(name = "编辑/新增报价员页面", value = "/quoter/edit", method = RequestMethod.GET)
    public Object toEditQuoter(@RequestParam(value = "id", defaultValue = "0") Long id) throws RemoteException {
        Map<String,Object> map = new HashMap<>();
        InsuranceQuoterDTO insuranceQuoterDTO = new InsuranceQuoterDTO();
        if (id != 0) {
            insuranceQuoterDTO = insuranceConfigInterface.getQuoterById(id);
        }
        map.put("companyList",insuranceConfigInterface.getAllCompanyList());
        map.put("quoter",insuranceQuoterDTO);
        return new ModelAndView("/system/insurance/quoterEdit", "map", map);
    }

    @RequestMapping(name = "更新/新增报价员动作", value = "/quoter/update", method = RequestMethod.POST)
    @ResponseBody
    public Object editQuoter(@ModelAttribute InsuranceQuoterDTO insuranceQuoterDTO) throws RemoteException {
        insuranceConfigInterface.saveQuoter(insuranceQuoterDTO);
        return Helper.getSuccessTemplate("编辑成功!");
    }

    @RequestMapping(name = "删除报价员", value = "/quoter/delete", method = RequestMethod.POST)
    @ResponseBody
    public Object deleteQuoter(@RequestParam(value = "id") Long id) throws RemoteException {
        insuranceConfigInterface.removeQuoter(id);
        return Helper.getSuccessTemplate("编辑成功!");
    }

    @RequestMapping(name = "获取报价员下拉框", value = "/quoter/selectList", method = RequestMethod.GET)
    @ResponseBody
    public ModelAndView getAllQuoterList(@RequestParam(value = "companyId") Long companyId) throws RemoteException {
        return new ModelAndView("/system/insurance/quoterListTpl", "quoterList", insuranceConfigInterface.getAllQuoterList(companyId));
    }
}
