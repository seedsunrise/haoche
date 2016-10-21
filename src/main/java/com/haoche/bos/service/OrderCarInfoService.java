package com.haoche.bos.service;

import com.haoche.bos.config.security.EmpInfo;
import com.haoche.bos.util.DictEnum;
import com.haoche.remoting.dto.OrderEditParam;
import com.haoche.remoting.dto.OrderFollowParamDTO;
import com.haoche.remoting.dto.OrderListParamDTO;
import com.haoche.remoting.dto.PageNateDTO;
import com.haoche.remoting.stub.OrderCarInfoInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * OrderCarService
 *
 * @author Chen fei
 * @date 2016/5/20
 */
@Service("orderCarInfoService")
public class OrderCarInfoService {

    @Autowired
    private OrderCarInfoInterface orderCarInfoInterface;

    public PageNateDTO findOrderList(OrderListParamDTO orderListParamDTO)throws RemoteException{
        return orderCarInfoInterface.findOrderList(orderListParamDTO);
    }

    public Map getOrderDetail(Long orderId)throws RemoteException {
        return orderCarInfoInterface.getOrderDetail(orderId);
    }

    public OrderEditParam editOrder(Long orderId)throws RemoteException {
        return orderCarInfoInterface.getEditOrder(orderId);
    }

    public void saveEditOrder(OrderEditParam orderEditParam,Long userId,String userName)throws RemoteException {
        orderCarInfoInterface.saveEditOrder(orderEditParam,userId,userName);
    }


    public String getContract(Long orderId,Long statusId)throws RemoteException {
        String image = orderCarInfoInterface.getContract(orderId,statusId);
        return image;
    }


    public void cancelOrder(Long orderId, Long id, String realName)throws RemoteException {
        orderCarInfoInterface.cancelOrder(orderId,id,realName);
    }

    public void saveOrderFollow(OrderFollowParamDTO orderFollowParamDTO,Long userId,String userName)throws RemoteException {
        orderCarInfoInterface.saveOrderFollow(orderFollowParamDTO,userId,userName);
    }

    public Map getOrderDetailPrint(Long orderId) throws RemoteException {
        return orderCarInfoInterface.getOrderDetailPrint(orderId);
    }

    public void saveLoanAmount(Long orderId, double loanAmount)throws RemoteException{
        orderCarInfoInterface.saveLoanAmount(orderId,loanAmount);
    }

    public double getLoanAmount(Long orderId)throws RemoteException{
        return orderCarInfoInterface.getLoanAmount(orderId);
    }

    public void saveCarLicenseTypeAndTime(Long orderId, int licenseSelectType, Date licenseSelectDate)throws RemoteException{

        orderCarInfoInterface.saveCarLicenseTypeAndTime(orderId,licenseSelectType,licenseSelectDate);
    }

    public void saveFinalPayment(Long orderId, int finalPayment, Date finalPaymentDate)throws RemoteException{
        orderCarInfoInterface.saveFinalPayment(orderId,finalPayment,finalPaymentDate);

    }

    public void saveMainTain(Long orderId, String mainTainProject, int mainTainPayTotal, int mainTainIsPay, int mainTainIsComplete, String mainTainPhoto)throws RemoteException{

        orderCarInfoInterface.saveMainTain(orderId,mainTainProject,mainTainPayTotal,mainTainIsPay,mainTainIsComplete,mainTainPhoto);
    }

    public void saveHighQualityAdd(Long orderId, String highQualityAddProject, int highQualityAddPayTotal, int highQualityAddIsPay, int highQualityAddIsComplete, String highQualityAddPhoto)throws RemoteException{

        orderCarInfoInterface.saveHighQualityAdd(orderId,highQualityAddProject,highQualityAddPayTotal,highQualityAddIsPay,highQualityAddIsComplete,highQualityAddPhoto);
    }

    public void savePickCarTime(Long orderId, Date pickCarTime)throws RemoteException{
        orderCarInfoInterface.savePickCarTime(orderId, pickCarTime);
    }

    public Map getOrderCarSop(Long orderId)throws RemoteException{
        return orderCarInfoInterface.getOrderCarSop(orderId);
    }

    public void saveBankReceiveInfo(Long orderId, int isReceive)throws RemoteException{
        orderCarInfoInterface.saveBankReceiveInfo(orderId,isReceive);
    }

    public void saveBankApproval(Long orderId,int bankLoanAmount,int isApproval)throws RemoteException{
        orderCarInfoInterface.saveBankApproval(orderId,bankLoanAmount,isApproval);
    }

    public void saveCarMortage(Long orderId, int isComplete)throws RemoteException{
        orderCarInfoInterface.saveCarMortage(orderId,isComplete);
    }

    public void saveCarBeauty(Long orderId, String carBeautyProject, int carBeautyPayTotal, int carBeautyIsPay, int carBeautyIsComplete, String carBeautyPhoto)throws RemoteException{

        orderCarInfoInterface.saveCarBeauty(orderId,carBeautyProject,carBeautyPayTotal,carBeautyIsPay,carBeautyIsComplete,carBeautyPhoto);
    }
}
