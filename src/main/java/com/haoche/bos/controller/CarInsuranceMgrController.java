package com.haoche.bos.controller;

import com.haoche.bos.service.CarBrandService;
import com.haoche.bos.util.Helper;
import com.haoche.remoting.dto.*;
import com.haoche.remoting.stub.CarInsuranceInterface;
import com.haoche.remoting.stub.InsuranceConfigInterface;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.rmi.RemoteException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 车险管理
 * Created by Ken on 2016/7/4.
 */
@Controller
@RequestMapping("/carInsurance")
public class CarInsuranceMgrController {

    @Resource
    private CarInsuranceInterface carInsuranceInterface;

    @Value("${platform.image.url}")
    private String imageUrl;

    @Value("${platform.mobileSite.url}")
    private String mobileSiteUrl;

    @Resource
    private InsuranceConfigInterface insuranceConfigInterface;

    @Autowired
    private CarBrandService carBrandService;

    @RequestMapping(name = "商品/车险列表", value = "/list", method = RequestMethod.GET)
    public ModelAndView list(String sort,
                             String sc,
                             String search,
                             @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                             @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) throws RemoteException, ParseException {
        Map<String, Object> map = new HashMap<>();
        StringBuilder param = new StringBuilder();
        if (StringUtils.isNotBlank(sort)) {
            map.put("sort", sort);
            param.append("&sort=").append(sort);
        }
        if (StringUtils.isNotBlank(sc)) {
            map.put("sc", sc);
            param.append("&sc=").append(sc);
        }
        if (StringUtils.isNotBlank(search)) {
            map.put("search", search);
            param.append("&search=").append(search);
        }
        PageNateDTO pageNateDTO = carInsuranceInterface.getInsuranceList(sort, sc, search, pageNo, pageSize);
        map.put("page", pageNateDTO);
        map.put("params", param.toString());
        map.put("imageUrl", imageUrl);
        map.put("mobileSiteUrl", mobileSiteUrl);
        map.put("companyList", insuranceConfigInterface.getAllCompanyList());
        return new ModelAndView("/goods/carInsuranceList", "map", map);
    }

    @RequestMapping(name = "提交报价", value = "/submitQuote", method = RequestMethod.POST)
    @ResponseBody
    public Object submitQuoter(@RequestParam(value = "carId") Long carId,
                               @RequestParam(value = "quoterId") Long quoterId) throws RemoteException {
        carInsuranceInterface.saveQuote(carId, quoterId);
        return Helper.getSuccessTemplate("提交成功!");
    }

    @RequestMapping(name = "报价详情", value = "/quoteDetail", method = RequestMethod.GET)
    public ModelAndView toQuoteDetail(@RequestParam(value = "id") Long id) throws RemoteException {
        InsuranceInfoDTO insuranceInfoDTO = new InsuranceInfoDTO();
        if (id != 0) {
            insuranceInfoDTO = carInsuranceInterface.getInsuranceInfoDto(id, true);
        }
        Map<String, Object> map = new HashMap<>();
        map.put("insuranceInfoDTO", insuranceInfoDTO);
        map.put("imageUrl", this.imageUrl);
        return new ModelAndView("/goods/quoteDetail", "map", map);
    }

    @RequestMapping(name = "车险报价查看和修改模板", value = "/getInsuranceQuoteTpl", method = RequestMethod.GET)
    public ModelAndView getInsuranceQuoteTpl(@RequestParam(value = "id") Long id) throws RemoteException {
        InsuranceInfoDTO insuranceInfoDTO = new InsuranceInfoDTO();
        if (id != 0) {
            insuranceInfoDTO = carInsuranceInterface.getInsuranceInfoDto(id, false);
        }
        return new ModelAndView("/goods/insuranceQuoteTpl", "insuranceInfoDTO", insuranceInfoDTO);
    }

    @RequestMapping(name = "修改报价详情", value = "/editQuote", method = RequestMethod.POST)
    @ResponseBody
    public Object editQuote(@RequestBody List<InsuranceDetailDTO> details) throws RemoteException {
        for (InsuranceDetailDTO insuranceDetailDTO : details) {
            System.out.println(insuranceDetailDTO);
        }
        carInsuranceInterface.updateInsuranceDetails(details, InsuranceInfoDTO.QUOTESTATUS_FINISH);
        return Helper.getSuccessTemplate("修改成功!");
    }

    @RequestMapping(name = "确认报价详情", value = "/confirmQuote", method = RequestMethod.POST)
    @ResponseBody
    public Object confirmQuote(@RequestBody List<InsuranceDetailDTO> details) throws RemoteException {
        carInsuranceInterface.updateInsuranceDetails(details, InsuranceInfoDTO.QUOTESTATUS_COMFIRM);
        return Helper.getSuccessTemplate("修改成功!");
    }

    @RequestMapping(name = "选择报价", value = "/chooseQuote", method = RequestMethod.POST)
    @ResponseBody
    public Object chooseQuote(@RequestParam(value = "id") Long id) throws RemoteException {
        carInsuranceInterface.chooseQuote(id, InsuranceInfoDTO.TYPE_NORMAL);
        return Helper.getSuccessTemplate("选择成功!");
    }

    @RequestMapping(name = "查看车辆全部报价", value = "/getQuoteInfos", method = RequestMethod.GET)
    @ResponseBody
    public ModelAndView getQuoteInfos(@RequestParam(value = "carId") Long carId) throws RemoteException {
        return new ModelAndView("/deal/infoListTpl", "infoList", carInsuranceInterface.getQuoteInfos(carId, false));
    }

    @RequestMapping(name = "修改车险订单状态", value = "/editOrderStatus", method = RequestMethod.POST)
    @ResponseBody
    public Object editOrderStatus(@RequestParam(value = "id") Long id,
                                  @RequestParam(value = "orderStatus") int orderStatus) throws RemoteException {
        carInsuranceInterface.changeOrderStatus(id, orderStatus);
        return Helper.getSuccessTemplate("修改成功!");
    }

    /**
     * 车险支付列表页
     *
     * @throws RemoteException
     */
    @RequestMapping(name = "交付列表", value = "/payList", method = RequestMethod.GET)
    public ModelAndView payList(@RequestParam(value = "carBrandId", defaultValue = "0") Long carBrandId,
                                @RequestParam(value = "carLineId", defaultValue = "0") Long carLineId,
                                @RequestParam(value = "pageNo", defaultValue = "0") int pageNo,
                                @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                                @RequestParam(value = "sort", defaultValue = "updatedAt") String sort,
                                @RequestParam(value = "order", defaultValue = "desc") String order,
                                @RequestParam(value = "startTime", required = false) String startTime,
                                @RequestParam(value = "endTime", required = false) String endTime,
                                @RequestParam(value = "search", required = false) String search) throws RemoteException {
        OrderListParamDTO orderListParamDTO = new OrderListParamDTO();
        orderListParamDTO.setPageNo(pageNo);
        orderListParamDTO.setPageSize(pageSize);
        orderListParamDTO.setCarBrandId(carBrandId);
        orderListParamDTO.setCarLineId(carLineId);
        orderListParamDTO.setSort(sort);
        orderListParamDTO.setOrder(order);
        orderListParamDTO.setStartTime(startTime);
        orderListParamDTO.setEndTime(endTime);
        orderListParamDTO.setSearch(search);
        PageNateDTO pageNateDTO = carInsuranceInterface.getInsurancePayList(orderListParamDTO);
        Map<String, Object> resultMap = new HashMap<>();
        String param = Helper.createUrl(orderListParamDTO);
        //品牌
        List<CarBrandDTO> carBrandList = this.carBrandService.getCarBrandList(0, 10000).getList();
        resultMap.put("carBrandList", carBrandList);
        resultMap.put("page", pageNateDTO);
        resultMap.put("imageUrl", imageUrl);
        resultMap.put("param", param);
        resultMap.put("paramDTO", orderListParamDTO);
        resultMap.put("search", search);
        return new ModelAndView("/deal/insuranceDealList", "map", resultMap);
    }

    @RequestMapping(name = "跳转车险支付界面", value = "/toOrderPay", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView toOrderPay(@RequestParam(value = "id") Long id) throws RemoteException {
        return new ModelAndView("/deal/payInsuranceInfoTpl", "insuranceOrder", carInsuranceInterface.getInsuranceOrder(id));
    }

    @RequestMapping(name = "提交车险订单", value = "/orderPay", method = RequestMethod.POST)
    @ResponseBody
    public Object orderPay(@RequestBody InsuranceOrderDTO insuranceOrderDTO) throws RemoteException {
        carInsuranceInterface.orderPay(insuranceOrderDTO);
        return Helper.getSuccessTemplate("提交成功!");
    }

    @RequestMapping(name = "车险续保列表", value = "/renewalList", method = RequestMethod.GET)
    public Object getRenewalList(String licenseNum, String mobile,
                                 @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                 @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) throws RemoteException, ParseException {
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> paramMap = new HashMap<>();
        if (StringUtils.isNotBlank(licenseNum)) {
            paramMap.put("licenseNumLike", licenseNum);
        }
        if (StringUtils.isNotBlank(mobile)) {
            paramMap.put("mobileLike", mobile);
        }

        PageNateDTO pageNateDTO = carInsuranceInterface.getRenewalList(paramMap, pageNo, pageSize);
        map.put("page", pageNateDTO);
        map.put("imageUrl", imageUrl);
        map.put("mobileSiteUrl", mobileSiteUrl);
        map.put("companyList", insuranceConfigInterface.getAllCompanyList());
        return new ModelAndView("/user/renewal/renewalList", "map", map);
    }

    @RequestMapping(name = "提交续保报价", value = "/submitRenewalQuote", method = RequestMethod.POST)
    @ResponseBody
    public Object submitRenewalQuote(@RequestParam(value = "carId") Long carId,
                                     @RequestParam(value = "quoterId") Long quoterId) throws RemoteException {
        carInsuranceInterface.saveRenewalQuote(carId, quoterId);
        return Helper.getSuccessTemplate("提交成功!");
    }

    @RequestMapping(name = "查看车辆全部报价", value = "/getRenewalQuoteInfos", method = RequestMethod.GET)
    @ResponseBody
    public ModelAndView getRenewalQuoteInfos(@RequestParam(value = "carId") Long carId) throws RemoteException {
        List list = carInsuranceInterface.getRenewalQuoteInfos(carId);
        return new ModelAndView("/deal/infoRenewalListTpl", "infoList", list);
    }

    @RequestMapping(name = "提交续保车险订单", value = "/orderRenewalPay", method = RequestMethod.POST)
    @ResponseBody
    public Object orderRenewalPay(@RequestBody InsuranceOrderDTO insuranceOrderDTO) throws RemoteException {
        carInsuranceInterface.orderPay(insuranceOrderDTO);
        return Helper.getSuccessTemplate("提交成功!");
    }

    @RequestMapping(name = "查看续保保单", value = "/getRenewalInfo", method = RequestMethod.GET)
    @ResponseBody
    public ModelAndView getRenewalInfo(@RequestParam(value = "carId") Long carId) throws RemoteException {
        Map<String, Object> map = new HashMap<>();
        if (carId != 0) {
            map = carInsuranceInterface.getRenewalInfo(carId);
        }
        return new ModelAndView("/user/renewal/renewalTpl", "map", map);
    }

    @RequestMapping(name = "跳转车险支付界面", value = "/toRenewalOrderPay", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView toRenewalOrderPay(@RequestParam(value = "infoId") Long infoId) throws RemoteException {
        carInsuranceInterface.chooseQuote(infoId, InsuranceInfoDTO.TYPE_RENEWAL);
        return new ModelAndView("/deal/payInsuranceInfoTpl", "insuranceOrder", carInsuranceInterface.getInsuranceOrder(infoId));
    }
}