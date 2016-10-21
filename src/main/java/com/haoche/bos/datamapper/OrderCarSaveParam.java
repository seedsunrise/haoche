package com.haoche.bos.datamapper;

import com.haoche.remoting.dto.BaseDTO;

/**
 * OrderCarSaveParam
 *
 * @author Chen fei
 * @date 2016/5/26
 */
public class OrderCarSaveParam extends BaseDTO {

    private double downPay;
    private Long carId;
    private String buyUserIdCardNumber;
    private double buyPrice;
    private double payments;
    private String buyUserMobile;
    private double insurace;
    private String buyUserName;
    private String saleUserMobile;
    private double salePriceReal;
    private double loanAmount;
    private String buyUserAddress;
    private double totalSalePrice;
    private int orderType;
    private double downPayPer;
    private String insuraceDes;
    private String detailList;

    public String getInsuraceDes() {
        return insuraceDes;
    }

    public void setInsuraceDes(String insuraceDes) {
        this.insuraceDes = insuraceDes;
    }

    public double getDownPay() {
        return downPay;
    }

    public void setDownPay(double downPay) {
        this.downPay = downPay;
    }

    public Long getCarId() {
        return carId;
    }

    public void setCarId(Long carId) {
        this.carId = carId;
    }

    public String getBuyUserIdCardNumber() {
        return buyUserIdCardNumber;
    }

    public void setBuyUserIdCardNumber(String buyUserIdCardNumber) {
        this.buyUserIdCardNumber = buyUserIdCardNumber;
    }

    public double getBuyPrice() {
        return buyPrice;
    }

    public void setBuyPrice(double buyPrice) {
        this.buyPrice = buyPrice;
    }

    public double getPayments() {
        return payments;
    }

    public void setPayments(double payments) {
        this.payments = payments;
    }

    public String getBuyUserMobile() {
        return buyUserMobile;
    }

    public void setBuyUserMobile(String buyUserMobile) {
        this.buyUserMobile = buyUserMobile;
    }

    public double getInsurace() {
        return insurace;
    }

    public void setInsurace(double insurace) {
        this.insurace = insurace;
    }

    public String getBuyUserName() {
        return buyUserName;
    }

    public void setBuyUserName(String buyUserName) {
        this.buyUserName = buyUserName;
    }

    public String getSaleUserMobile() {
        return saleUserMobile;
    }

    public void setSaleUserMobile(String saleUserMobile) {
        this.saleUserMobile = saleUserMobile;
    }

    public double getSalePriceReal() {
        return salePriceReal;
    }

    public void setSalePriceReal(double salePriceReal) {
        this.salePriceReal = salePriceReal;
    }

    public double getLoanAmount() {
        return loanAmount;
    }

    public void setLoanAmount(double loanAmount) {
        this.loanAmount = loanAmount;
    }

    public String getBuyUserAddress() {
        return buyUserAddress;
    }

    public void setBuyUserAddress(String buyUserAddress) {
        this.buyUserAddress = buyUserAddress;
    }

    public double getTotalSalePrice() {
        return totalSalePrice;
    }

    public void setTotalSalePrice(double totalSalePrice) {
        this.totalSalePrice = totalSalePrice;
    }

    public int getOrderType() {
        return orderType;
    }

    public void setOrderType(int orderType) {
        this.orderType = orderType;
    }

    public double getDownPayPer() {
        return downPayPer;
    }

    public void setDownPayPer(double downPayPer) {
        this.downPayPer = downPayPer;
    }

    public String getDetailList() {
        return detailList;
    }

    public void setDetailList(String detailList) {
        this.detailList = detailList;
    }
}
