package com.haoche.bos.controller;

import com.basedata.remoting.dto.CarBrandDTO;
import com.basedata.remoting.dto.CarLineDTO;
import com.basedata.remoting.stub.CarLineInterface;
import com.haoche.bos.config.security.EmpInfo;
import com.haoche.bos.datamapper.Template;
import com.haoche.bos.service.CarBrandService;
import com.haoche.bos.service.CarLineService;
import com.haoche.bos.service.CarLoanService;
import com.haoche.bos.service.OrderCarInfoService;
import com.haoche.bos.util.CurrentUser;
import com.haoche.bos.util.DictEnum;
import com.haoche.bos.util.Helper;
import com.haoche.remoting.dto.*;
import com.haoche.remoting.dto.capp.CarLoanChannelDTO;
import com.haoche.remoting.dto.capp.CarLoanChannelRateDTO;
import com.haoche.remoting.stub.CarExtraItemInterface;
import com.haoche.remoting.stub.CarInsuranceInterface;
import com.haoche.remoting.stub.CarSourceInterface;
import com.haoche.remoting.stub.OrderCarInfoInterface;
import com.haoche.userauth.remoting.stub.UserInfoInterface;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.rmi.RemoteException;
import java.text.ParseException;
import java.util.*;

@Controller
@RequestMapping("/deal")
public class DealController {

    @Autowired
    private OrderCarInfoService orderCarInfoService;

    @Autowired
    private CarBrandService carBrandService;

    @Autowired
    private CarLineService carLineService;

    @Autowired
    private CarLineInterface carLineInterface;

    @Value("${platform.image.url}")
    private String imageUrl;

    @Value("${platform.mobileSite.url}")
    private String mobileSiteUrl;

    @Resource
    private CarExtraItemInterface carExtraItemInterface;

    @Resource
    private CarInsuranceInterface carInsuranceInterface;

    @Autowired
    private UserInfoInterface userInfoInterface;

    @Autowired
    private CarSourceInterface carSourceInterface;

    @Autowired
    private OrderCarInfoInterface orderCarInfoInterface;


    @Autowired
    private CarLoanService carLoanService;

    /**
     * 交付列表页，搜索
     * @param
     * @return
     * @throws RemoteException
     */
    @RequestMapping(name = "交付列表",value = "/list", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public ModelAndView list(
                             @RequestParam(value = "carBrandId",defaultValue = "0")Long carBrandId,
                             @RequestParam(value = "carLineId",defaultValue = "0")Long carLineId,
                             @RequestParam(value = "payType",defaultValue = "0")int payType,
                             @RequestParam(value = "pageNo",defaultValue = "0")int pageNo,
                             @RequestParam(value = "pageSize",defaultValue = "10")int pageSize,
                             @RequestParam(value = "carAction",defaultValue = "1")int carAction,
                             @RequestParam(value = "sort",defaultValue = "updatedAt")String sort,
                             @RequestParam(value = "order",defaultValue = "desc")String order,
                             @RequestParam(value = "startTime",required = false)String startTime,
                             @RequestParam(value = "endTime",required = false)String endTime,
                             @RequestParam(value = "search",required = false)String search,
                             @RequestParam(value = "orderStatusSearch",required = false)String[] orderStatusSearch) throws RemoteException {
        OrderListParamDTO orderListParamDTO = new OrderListParamDTO();
        orderListParamDTO.setPageNo(pageNo);
        orderListParamDTO.setPageSize(pageSize);
        orderListParamDTO.setCarBrandId(carBrandId);
        orderListParamDTO.setCarLineId(carLineId);
        orderListParamDTO.setOrderType(payType);
        orderListParamDTO.setCarAction(carAction);
        orderListParamDTO.setSort(sort);
        orderListParamDTO.setOrder(order);
        orderListParamDTO.setStartTime(startTime);
        orderListParamDTO.setEndTime(endTime);
        orderListParamDTO.setSearch(search);
        orderListParamDTO.setOrderStatusSearch(orderStatusSearch);
        PageNateDTO pageNateDTO = this.orderCarInfoService.findOrderList(orderListParamDTO);
        List<CarBrandDTO> carBrandList = this.carBrandService.getCarBrandList(0,10000).getList();
        Map resultMap = new HashMap();
        String param = Helper.createUrl(orderListParamDTO);
        resultMap.put("page",pageNateDTO);
        resultMap.put("carBrandList",carBrandList);
        resultMap.put("imageUrl",imageUrl);
        resultMap.put("param",param);
        resultMap.put("carAction",carAction);
        resultMap.put("paramDTO",orderListParamDTO);
        return new ModelAndView("/deal/list","map",resultMap);
    }

    /**
     * 获取车系
     * @param carBrandId
     * @return
     * @throws RemoteException
     */
    @ResponseBody
    @RequestMapping(name = "获取车系",value = "/queryLine",method = RequestMethod.GET)
    public ModelAndView queryLineList(@RequestParam(value="carBrandId")Long carBrandId) throws RemoteException {
        List<CarLineDTO>  list = this.carLineInterface.getCarLineListByBrandId(carBrandId);
        return new ModelAndView("/deal/list","carLineList",list);
    }

    /**
     * 订单详情
     * @param orderId
     * @return
     * @throws RemoteException
     */
    @RequestMapping(name = "订单详情",value = "/orderDetail",method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public ModelAndView getOrderDetail(@RequestParam(value = "orderId")Long orderId)throws RemoteException{
        Map resultMap = this.orderCarInfoService.getOrderDetail(orderId);
        resultMap.put("imageUrl",imageUrl);
        resultMap.put("mobileSiteUrl", mobileSiteUrl);
        OrderListParamDTO orderListParamDTO = (OrderListParamDTO) resultMap.get("orderInfo");
        Map<String, String> orderText = HelpController.GetTextOfOrderStatus(orderListParamDTO);
        resultMap.put("orderStatusText", orderText);
        // 分别获取保养,美容,加装的项目
        resultMap.put("maintainProject", carExtraItemInterface.getItemByType(0));
        resultMap.put("carBeautyProject", carExtraItemInterface.getItemByType(1));
        resultMap.put("highQualityAddProject", carExtraItemInterface.getItemByType(2));
        // 获取车辆车险状态信息
        resultMap.put("carInsuranceOrderDTO", carInsuranceInterface.getCarOrderInfo(orderListParamDTO.getCarId()));
        return new ModelAndView("/deal/deliverDetail/orderDetail","map",resultMap);
    }

    /**
     * 订单编辑
     * @param orderId
     * @return
     * @throws RemoteException
     */
    @RequestMapping(name = "订单编辑",value = "/editOrder",method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public ModelAndView editOrder(@RequestParam(value = "orderId")Long orderId)throws RemoteException{
        OrderEditParam orderEditParam = this.orderCarInfoService.editOrder(orderId);
        return new ModelAndView("/deal/editOrder","orderEdit",orderEditParam);

    }

    @RequestMapping(name = "订单编辑保存",value = "/saveEditOrder",method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public Template saveEditOrder(@ModelAttribute OrderEditParam orderEditParam)throws RemoteException{
        Template template = new Template();
        EmpInfo empInfo = CurrentUser.get();
        Long userId = empInfo.getId();
        String userName = empInfo.getRealName();
        String saleUserName = (orderEditParam.getSaleUserName().split(","))[0];
        String buyUserName = (orderEditParam.getBuyUserName().split(","))[0];
        String buyUserIdCardNumber = (orderEditParam.getBuyUserIdCardNumber().split(","))[0];
        String buyUserMobile = (orderEditParam.getBuyUserMobile().split(","))[0];
        String buyUserAddress = (orderEditParam.getBuyUserAddress().split(","))[0];
        orderEditParam.setSaleUserName(saleUserName);
        orderEditParam.setBuyUserAddress(buyUserAddress);
        orderEditParam.setBuyUserIdCardNumber(buyUserIdCardNumber);
        orderEditParam.setBuyUserName(buyUserName);
        orderEditParam.setBuyUserMobile(buyUserMobile);
        this.orderCarInfoService.saveEditOrder(orderEditParam,userId,userName);
        Map map = new HashMap();
        map.put("url","/deal/list");
        template.setCode(DictEnum.success_code);
        template.setData(map);
        return template;
    }

    /**
     * 取消订单
     * @param orderId
     * @param statusId
     * @return
     * @throws RemoteException
     */
    @RequestMapping(name = "取消订单",value = "/cancelOrder",method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public Template cancelOrder(@RequestParam(value = "orderId")Long orderId,@RequestParam(value = "statusId")Long statusId)
        throws RemoteException{
        Template template = new Template();
        EmpInfo empInfo = CurrentUser.get();
        this.orderCarInfoService.cancelOrder(orderId,empInfo.getId(),empInfo.getRealName());
        template.setCode(DictEnum.success_code);
        return template;
    }

    /**
     * 查看合同
     * @param orderId
     * @return
     * @throws RemoteException
     */
    @RequestMapping(name = "查看合同",value = "/getContract",method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public Template getContract(@RequestParam(value = "orderId")Long orderId,
                                @RequestParam(value = "statusId")Long statusId)throws RemoteException{
        Template template = new Template();
        String image = this.orderCarInfoService.getContract(orderId,statusId);
        template.setCode(DictEnum.success_code);
        template.setData(image);
        return template;
    }

    /**
     * 订单跟进
     * @param orderId
     * @param statusId
     * @return
     * @throws RemoteException
     */
//    @RequestMapping(name = "订单跟进",value = "/orderFollow",method = RequestMethod.POST)
//    @ResponseStatus(HttpStatus.OK)
//    @ResponseBody
//    public Template orderFollow(@RequestParam(value = "orderId")Long orderId,@RequestParam(value = "statusId")Long statusId)
//        throws RemoteException{
//        Template template = new Template();
//        return template;
//    }
     @RequestMapping(name = "订单跟进",value = "/orderFollow",method = RequestMethod.GET)
     @ResponseStatus(HttpStatus.OK)
     public ModelAndView orderFollow(@RequestParam(value = "orderId")Long orderId,@RequestParam(value = "statusId")Long statusId)
            throws RemoteException{
        Template template = new Template();
        return new ModelAndView("/deal/orderFollow");
     }

    /**
     * 保存订单跟进
     *
     * @return
     * @throws RemoteException
     */
    @RequestMapping(name = "保存订单跟进",value = "/saveOrderFollow",method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public Template saveOrderFollow(@ModelAttribute OrderFollowParamDTO orderFollowParamDTO)throws RemoteException{
        Template template = new Template();
        EmpInfo empInfo = CurrentUser.get();
        Long UserId = empInfo.getId();
        String userName = empInfo.getRealName();
        if(StringUtils.isNotEmpty(orderFollowParamDTO.getContent())){
            String content = (orderFollowParamDTO.getContent().split(","))[0];
            orderFollowParamDTO.setContent(content);
        }
        if(StringUtils.isNotEmpty(orderFollowParamDTO.getImage())){
            String image = (orderFollowParamDTO.getImage().split(","))[0];
            if(StringUtils.isNotEmpty(image)){
                int i = image.split("\\|").length;
                if(i>3){
                    template.setCode(DictEnum.fail_code);
                    template.setMsg("上传图片超过限制");
                    return template;
                }else{
                    orderFollowParamDTO.setImage(image);
                }
            }
        }
        if(StringUtils.isNotEmpty(orderFollowParamDTO.getContractImage())){
            String contractImage = (orderFollowParamDTO.getContractImage().split(","))[0];
            if(StringUtils.isNotEmpty(contractImage)){
                int j = contractImage.split("\\|").length;
                if(j>3){
                    template.setCode(DictEnum.fail_code);
                    template.setMsg("上传图片超过限制");
                    return template;
                }else{
                    orderFollowParamDTO.setContractImage(contractImage);
                }
            }
        }
        String createUserName = CurrentUser.get().getRealName();
        orderFollowParamDTO.setCreateUserName(createUserName);
        this.orderCarInfoService.saveOrderFollow(orderFollowParamDTO,UserId,userName);
        template.setCode(DictEnum.success_code);
        Map map = new HashMap();
        map.put("url","/deal/list");
        template.setData(map);
        return template;
    }

    @RequestMapping(name = "打印交付合同",value = "/print",method = RequestMethod.GET)
    public ModelAndView print(@RequestParam(value = "orderId")Long orderId)throws RemoteException{
        Map resultMap = this.orderCarInfoService.getOrderDetailPrint(orderId);
        return new ModelAndView("/deal/printContract","map",resultMap);
    }

    @RequestMapping(name = "资料提交银行保存",value = "/saveBankReceiveInfo",method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public Template saveBankReceiveInfo(@RequestParam(value = "orderId")Long orderId,
                                        @RequestParam(value = "isReceive",defaultValue = "1")int isReceive)throws RemoteException{
        //参数 isReceive 是否提交 1未提交  9已提交
        Template template =new Template();
        this.orderCarInfoService.saveBankReceiveInfo(orderId,isReceive);
        template.setCode(DictEnum.success_code);
        Map map = new HashMap();
        map.put("url","/deal/list");
        template.setData(map);
        return template;
    }

    @RequestMapping(name = "银行审批保存",value = "/saveBankApproval",method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public Template saveBankApproval(@RequestParam(value = "orderId")Long orderId,
                                     @RequestParam(value = "bankLoanAmount")int bankLoanAmount,
                                     @RequestParam(value = "isApproval",defaultValue = "1")int isApproval)throws RemoteException{
        //参数 isApproval 是否审批 1未审批 9已审批
        Template template = new Template();
        this.orderCarInfoService.saveBankApproval(orderId,bankLoanAmount,isApproval);
        template.setCode(DictEnum.success_code);
        Map map = new HashMap();
        map.put("url","/deal/list");
        template.setData(map);
        return template;
    }

//    @RequestMapping(name = "保存银行放款金额",value = "/saveLoanAmount",method = RequestMethod.POST)
//    @ResponseStatus(HttpStatus.OK)
//    @ResponseBody
//    public Template saveLoanAmount(@RequestParam(value = "orderId")Long orderId,
//                                   @RequestParam(value = "loanAmount")double loanAmount)throws RemoteException{
//        Template template = new Template();
//        this.orderCarInfoService.saveLoanAmount(orderId,loanAmount);
//        template.setCode(DictEnum.success_code);
//        Map map = new HashMap();
//        map.put("url","/deal/list");
//        template.setData(map);
//        return template;
//
//    }
//
//    @RequestMapping(name = "获取银行放款金额",value = "/getLoanAmount",method = RequestMethod.POST)
//    @ResponseStatus(HttpStatus.OK)
//    @ResponseBody
//    public Template getLoanAmount(@RequestParam(value = "orderId")Long orderId)throws RemoteException{
//        Template template = new Template();
//        double loanAmount = this.orderCarInfoService.getLoanAmount(orderId);
//        template.setData(loanAmount);
//        template.setCode(DictEnum.success_code);
//        return template;
//    }

    @RequestMapping(name = "保存车牌号选取方式和时间",value = "/saveCarLicenseTypeAndTime",method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public Template saveCarLicenseTypeAndTime(@RequestParam(value = "orderId")Long orderId,
                                              @RequestParam(value = "licenseSelectType",defaultValue = "1")int licenseSelectType,
                                              @RequestParam(value = "licenseSelectDate")String licenseSelectDateStr)throws RemoteException,ParseException{
        Template template = new Template();
        Date licenseSelectDate = Helper.translateStrToDate(licenseSelectDateStr);
        orderCarInfoService.saveCarLicenseTypeAndTime(orderId,licenseSelectType,licenseSelectDate);
        template.setCode(DictEnum.success_code);
        Map map = new HashMap();
        map.put("url","/deal/list");
        template.setData(map);
        return template;
    }

    @RequestMapping(name = "保存尾款支付时间和金额",value = "/saveFinalPayment",method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public Template saveFinalPayment(@RequestParam(value = "orderId")Long orderId,
                                     @RequestParam(value = "finalPayment")int finalPayment,
                                     @RequestParam(value = "finalPaymentDate")String finalPaymentDateStr)throws RemoteException,ParseException{
        Template template = new Template();
        Date finalPaymentDate = Helper.translateStrToDate(finalPaymentDateStr);
        orderCarInfoService.saveFinalPayment(orderId,finalPayment,finalPaymentDate);
        template.setCode(DictEnum.success_code);
        Map map = new HashMap();
        map.put("url","/deal/list");
        template.setData(map);
        return template;
    }

    @RequestMapping(name = "保存车辆抵押手续办理",value = "/saveCarMortage",method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public Template saveCarMortage(@RequestParam(value = "orderId")Long orderId,
                                   @RequestParam(value = "isComplete",defaultValue = "1")int isComplete)throws RemoteException{
        //参数isComplete 1为完成 9已完成
        Template template = new Template();
        this.orderCarInfoService.saveCarMortage(orderId,isComplete);
        template.setCode(DictEnum.success_code);
        Map map = new HashMap();
        map.put("url","/deal/list");
        template.setData(map);
        return template;
    }

    @RequestMapping(name = "保存预约提车手续",value = "/savePickCar",method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public Template savePickCarTime(@RequestParam(value = "orderId")Long orderId,
                                    @RequestParam(value = "pickCarTime")String pickCarTimeStr)throws RemoteException,ParseException{
        Template template = new Template();
        Date pickCarTime = Helper.translateStrToDate(pickCarTimeStr);
        orderCarInfoService.savePickCarTime(orderId, pickCarTime);
        template.setCode(DictEnum.success_code);
        Map map = new HashMap();
        map.put("url","/deal/list");
        template.setData(map);
        return template;
    }

    @RequestMapping(name = "保养信息保存",value = "/saveMainTain",method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public Template saveMainTail(@RequestParam(value = "orderId")Long orderId,
                                 @RequestParam(value = "mainTainProject")String mainTainProject,
                                 @RequestParam(value = "mainTainPayTotal")int mainTainPayTotal,
                                 @RequestParam(value = "mainTainIsPay")int mainTainIsPay,
                                 @RequestParam(value = "mainTainIsComplete")int mainTainIsComplete,
                                 @RequestParam(value = "mainTainPhoto")String mainTainPhoto)throws RemoteException{
        Template template = new Template();
        orderCarInfoService.saveMainTain(orderId, mainTainProject, mainTainPayTotal, mainTainIsPay, mainTainIsComplete, mainTainPhoto);
        template.setCode(DictEnum.success_code);
        return template;
    }

    @RequestMapping(name = "精品加装保存",value = "/saveHighQualityAdd",method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public Template saveHighQualityAdd(@RequestParam(value = "orderId")Long orderId,
                                       @RequestParam(value = "highQualityAddProject")String highQualityAddProject,
                                       @RequestParam(value = "highQualityAddPayTotal")int highQualityAddPayTotal,
                                       @RequestParam(value = "highQualityAddIsPay")int highQualityAddIsPay,
                                       @RequestParam(value = "highQualityAddIsComplete")int highQualityAddIsComplete,
                                       @RequestParam(value = "highQualityAddPhoto")String highQualityAddPhoto)throws RemoteException{
        Template template = new Template();
        orderCarInfoService.saveHighQualityAdd(orderId,highQualityAddProject,highQualityAddPayTotal,highQualityAddIsPay,highQualityAddIsComplete,highQualityAddPhoto);
        template.setCode(DictEnum.success_code);
        return template;
    }


    @RequestMapping(name = "美容信息保存",value = "/saveCarBeauty",method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public Template saveCarBeauty(@RequestParam(value = "orderId")Long orderId,
                                  @RequestParam(value = "carBeautyProject")String carBeautyProject,
                                  @RequestParam(value = "carBeautyPayTotal")int carBeautyPayTotal,
                                  @RequestParam(value = "carBeautyIsPay")int carBeautyIsPay,
                                  @RequestParam(value = "carBeautyIsComplete")int carBeautyIsComplete,
                                  @RequestParam(value = "carBeautyPhoto")String carBeautyPhoto)throws RemoteException{
        Template template = new Template();
        orderCarInfoService.saveCarBeauty(orderId,carBeautyProject,carBeautyPayTotal,carBeautyIsPay,carBeautyIsComplete,carBeautyPhoto);
        template.setCode(DictEnum.success_code);
        return template;
    }

    @RequestMapping(name = "获取车主交付流程",value = "/getOrderCarSop",method = RequestMethod.GET)
    @ResponseBody
    public Map getOrderCarsop(@RequestParam(value = "orderId")Long orderId)throws RemoteException{
        Map map = orderCarInfoService.getOrderCarSop(orderId);
        List<OrderSopResponseCzDTO> resList = (List<OrderSopResponseCzDTO>)map.get("orderList");
//        MyComparator myComparator = new MyComparator();
//        Collections.sort(resList,myComparator);
        map.put("orderList",resList);
        return map;
    }

    static class MyComparator implements Comparator {
        public int compare(Object arg0, Object arg1) {
            OrderSopResponseCzDTO cop1 = (OrderSopResponseCzDTO) arg0;
            OrderSopResponseCzDTO cop2 = (OrderSopResponseCzDTO) arg1;
            return new Integer(cop1.getIndex()).compareTo(new Integer(cop2.getIndex()));
        }
    }


    @RequestMapping(name = "获取订单车辆和保险信息",value = "/getOrderCarAndInsuranceInfo",method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public ModelAndView getOrderCarAndInsuranceInfo(@RequestParam(value = "carId")Long carId,
                                           @RequestParam(value = "orderType",defaultValue = "1")int orderType)throws RemoteException{
        List<InsuranceInfoDTO> insList = carInsuranceInterface.getQuoteInfos(carId, true);
        CarInfoDTO carInfoDTO = carSourceInterface.getCarInfo(carId);
        List<CarLoanChannelDTO> carLoanChannelDTOs = carLoanService.findAllCarLoan();
        Map resultMap = new HashMap();
        resultMap.put("carInfo",carInfoDTO);
        resultMap.put("insuranceList",insList);
        resultMap.put("imageUrl",imageUrl);
        resultMap.put("carLoanChannelList",carLoanChannelDTOs);
        resultMap.put("orderType",orderType);
        return new ModelAndView("/goods/orderCar","map",resultMap);
    }

    @RequestMapping(name = "保存下单信息",value = "/saveOrderCarInfo",method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public Template saveOrderCarInfo(@RequestBody OrderBosSaveDTO orderBosSaveDTO
    )throws RemoteException{
        OrderCarSaveParamDTO orderCarSaveParamDTO = orderBosSaveDTO.getOrderCarParam();
        List<InsuranceDetailDTO> details = orderBosSaveDTO.getDetails();
        Template template = new Template();
        orderCarInfoInterface.saveOrderCarInfo(orderCarSaveParamDTO);
        if(details.size()>0){
            carInsuranceInterface.updateInsuranceDetails(details, InsuranceInfoDTO.QUOTESTATUS_COMFIRM);
        }
        template.setCode(DictEnum.success_code);
        return template;
    }


    @RequestMapping(name = "获取贷款利率",value = "getCarLoanRate",method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public CarLoanChannelRateDTO getCarLoanRate(@RequestParam(value = "channelId")Long channelId,
                              @RequestParam(value = "downPayment")int downPayment,
                              @RequestParam(value = "periodNumber")int  periodNumber)throws RemoteException{
        CarLoanChannelRateDTO carLoanChannelRateDTO = carLoanService.findCarLoanChannelRate(channelId,downPayment,periodNumber);
        int h = downPayment/periodNumber;
        int rateYear = carLoanChannelRateDTO.getChannelInterestRate()*12/10;
        int j = downPayment*(rateYear/100/12);
        int payments = h+j;
        int year = periodNumber/12;
        int totalInterest = downPayment*(rateYear*year/100);
        carLoanChannelRateDTO.setChannelRateYear(rateYear);
        carLoanChannelRateDTO.setPayments(payments);
        carLoanChannelRateDTO.setTotalInterest(totalInterest);
        return carLoanChannelRateDTO;
    }




}