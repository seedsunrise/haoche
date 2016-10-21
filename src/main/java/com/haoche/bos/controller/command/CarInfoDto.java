package com.haoche.bos.controller.command;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class CarInfoDto {

    private Long id;
    private String carTitle;
    private long carBrandId; // 品牌id
    private String brandName; // 品牌名称
    private long carSubBrandId; // 品牌细分/厂商id
    private String subBrandName; // 品牌细分/厂商名称
    private long carLineId; // 车系id
    private String lineName; // 车系名称
    private long carModelId; // 型号id
    private String modelName; // 型号名称
    private String firstLicenseDate; // 首次上牌时间
    private int runKm; // 里程
    private int salePrice; // 车主售价
    private Long firstLicenseCityId; // 首次上牌城市id
    private String firstLicenseCityName; // 首次上牌城市名称
    private String lastLicenseDate; // 最近一次上牌时间
    private long carCityId; // 当前所在城市id
    private String carCityName; // 当前所在城市名称
    private String licenseNum; // 当前车牌号
    private String cardCityName; // 当前上牌城市
    private Long cardCityId; // 当前上牌城市id
    private String carColor; // 车身颜色
    private String carInteriorColor; // 内饰颜色
    private String engineNo; // 发动机号
    private String displacement; // 排量
    private String carVin; // 车架号
    private String nameplatePhoto; // 铭牌图片
    private Long carBusinessId;
    private String carBusinessName;
    private int inventoryDay; // 库存天数
    private String sendCarName;
    private Date sendCarTime;
    private String takeCarName;
    private Date takeCarTime;
    private int transferNum;
    private String transferNote;
    private String statusDescription; // 当前状态描述
    // 烟灰缸
    private int numberOfAshtray;
    // 点烟器
    private int numberOfCigaretteLighter;
    // 急救包
    private int numberOfAidKit;
    // 拖车钩
    private int numberOfTrailerHook;
    // 备用轮胎
    private int numberOfSpareTire;
    // 千斤顶
    private int numberOfJack;
    // 网兜
    private int numberOfNet;
    // 三角警示牌
    private int numberOfWarningTriangle;
    // 车载灭火器
    private int numberOfExtinguisher;
    // 备注
    private String remarks;
    private int action;
    // 损坏描述
    private String damageDescription;
    private int propertyCertificate; // 是否有产权证
    private String propertyCertificatePhoto; // 产权证照片
    private int isInGuarantee; // 是否有三包
    private int numberOfKey; // 钥匙数量
    private int isIllegal; // 是否有违章
    private String illegalPhoto; // 违章记录照片
    private String placeOfOrigin; // 产地
    private int isUserManual; // 是否有用户手册
    private int isPurchaseCertificate; // 是否有购置证
    private int isDrivingLicense; // 是否有行驶证
    private String drivingLicensePhoto; // 行驶证示意图
    private int isMaintenanceManual; // 是否有保养手册
    private String maintenanceInvoicePhoto; // 保养记录照片
    private int isPolicy; // 是否有保单
    private Date timeOfMaturity; // 交强险到期时间
    private Date annualInspection; // 年检到期时间
    private int isNormalTransfer; // 是否能正常过户
    private int isCopyOfID; // 是否有车主身份证复印件
    private int isCarInvoice; // 是否有二手车发票

    private Long carInfoApplyId;

    public Long getCarInfoApplyId() {
        return carInfoApplyId;
    }

    public void setCarInfoApplyId(Long carInfoApplyId) {
        this.carInfoApplyId = carInfoApplyId;
    }

    public String getCardCityName() {
        return cardCityName;
    }

    public void setCardCityName(String cardCityName) {
        this.cardCityName = cardCityName;
    }

    public Long getCardCityId() {
        return cardCityId;
    }

    public void setCardCityId(Long cardCityId) {
        this.cardCityId = cardCityId;
    }

    public void setSendCarTime(Date sendCarTime) {
        this.sendCarTime = sendCarTime;
    }

    public void setTakeCarTime(Date takeCarTime) {
        this.takeCarTime = takeCarTime;
    }

    public String getSendCarName() {
        return sendCarName;
    }

    public void setSendCarName(String sendCarName) {
        this.sendCarName = sendCarName;
    }

    public Date getSendCarTime() {
        return sendCarTime;
    }

    public void setSendCarTime(String sendCarTime) {
        if (sendCarTime != null) {
            try {
                DateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd");
                Date date = dateFormat.parse(sendCarTime);
                this.sendCarTime = date;
            } catch (Exception e) {
                this.sendCarTime = null;
            }
        } else {
            this.sendCarTime = null;
        }
    }

    public int getTransferNum() {
        return transferNum;
    }

    public void setTransferNum(int transferNum) {
        this.transferNum = transferNum;
    }

    public String getTakeCarName() {
        return takeCarName;
    }

    public void setTakeCarName(String takeCarName) {
        this.takeCarName = takeCarName;
    }

    public Date getTakeCarTime() {
        return takeCarTime;
    }

    public void setTakeCarTime(String takeCarTime) {
        if (takeCarTime != null) {
            try {
                DateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd");
                Date date = dateFormat.parse(takeCarTime);
                this.takeCarTime = date;
            } catch (Exception e) {
                this.takeCarTime = null;
            }
        } else {
            this.takeCarTime = null;
        }
    }

    public String getTransferNote() {
        return transferNote;
    }

    public void setTransferNote(String transferNote) {
        this.transferNote = transferNote;
    }

    public Long getCarBusinessId() {
        return carBusinessId;
    }

    public void setCarBusinessId(Long carBusinessId) {
        this.carBusinessId = carBusinessId;
    }

    public String getCarBusinessName() {
        return carBusinessName;
    }

    public void setCarBusinessName(String carBusinessName) {
        this.carBusinessName = carBusinessName;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCarTitle() {
        return carTitle;
    }

    public void setCarTitle(String carTitle) {
        this.carTitle = carTitle;
    }

    public long getCarBrandId() {
        return carBrandId;
    }

    public void setCarBrandId(long carBrandId) {
        this.carBrandId = carBrandId;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public long getCarSubBrandId() {
        return carSubBrandId;
    }

    public void setCarSubBrandId(long carSubBrandId) {
        this.carSubBrandId = carSubBrandId;
    }

    public String getSubBrandName() {
        return subBrandName;
    }

    public void setSubBrandName(String subBrandName) {
        this.subBrandName = subBrandName;
    }

    public long getCarLineId() {
        return carLineId;
    }

    public void setCarLineId(long carLineId) {
        this.carLineId = carLineId;
    }

    public String getLineName() {
        return lineName;
    }

    public void setLineName(String lineName) {
        this.lineName = lineName;
    }

    public long getCarModelId() {
        return carModelId;
    }

    public void setCarModelId(long carModelId) {
        this.carModelId = carModelId;
    }

    public String getModelName() {
        return modelName;
    }

    public void setModelName(String modelName) {
        this.modelName = modelName;
    }

    public String getFirstLicenseDate() {
        return firstLicenseDate;
    }

    public void setFirstLicenseDate(String firstLicenseDate) {
        if (firstLicenseDate != null) {
            try {
                DateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd");
                Date date = dateFormat.parse(firstLicenseDate);
                firstLicenseDate = new SimpleDateFormat("yyyyMMdd").format(date);
            } catch (Exception e) {
            }
        }
        this.firstLicenseDate = firstLicenseDate;
    }

    public int getRunKm() {
        return runKm;
    }

    public void setRunKm(int runKm) {
        this.runKm = runKm;
    }

    public int getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(int salePrice) {
        this.salePrice = salePrice;
    }

    public Long getFirstLicenseCityId() {
        return firstLicenseCityId;
    }

    public void setFirstLicenseCityId(Long firstLicenseCityId) {
        this.firstLicenseCityId = firstLicenseCityId;
    }

    public String getFirstLicenseCityName() {
        return firstLicenseCityName;
    }

    public void setFirstLicenseCityName(String firstLicenseCityName) {
        this.firstLicenseCityName = firstLicenseCityName;
    }

    public String getLastLicenseDate() {
        return lastLicenseDate;
    }

    public void setLastLicenseDate(String lastLicenseDate) {
        if (lastLicenseDate != null) {
            try {
                DateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd");
                Date date = dateFormat.parse(lastLicenseDate);
                lastLicenseDate = new SimpleDateFormat("yyyyMMdd").format(date);
            } catch (Exception e) {
            }
        }
        this.lastLicenseDate = lastLicenseDate;
    }

    public long getCarCityId() {
        return carCityId;
    }

    public void setCarCityId(long carCityId) {
        this.carCityId = carCityId;
    }

    public String getCarCityName() {
        return carCityName;
    }

    public void setCarCityName(String carCityName) {
        this.carCityName = carCityName;
    }

    public String getLicenseNum() {
        return licenseNum;
    }

    public void setLicenseNum(String licenseNum) {
        this.licenseNum = licenseNum;
    }

    public String getCarColor() {
        return carColor;
    }

    public void setCarColor(String carColor) {
        this.carColor = carColor;
    }

    public String getCarInteriorColor() {
        return carInteriorColor;
    }

    public void setCarInteriorColor(String carInteriorColor) {
        this.carInteriorColor = carInteriorColor;
    }

    public String getEngineNo() {
        return engineNo;
    }

    public void setEngineNo(String engineNo) {
        this.engineNo = engineNo;
    }

    public String getDisplacement() {
        return displacement;
    }

    public void setDisplacement(String displacement) {
        this.displacement = displacement;
    }

    public String getCarVin() {
        return carVin;
    }

    public void setCarVin(String carVin) {
        this.carVin = carVin;
    }

    public String getNameplatePhoto() {
        return nameplatePhoto;
    }

    public void setNameplatePhoto(String nameplatePhoto) {
        this.nameplatePhoto = nameplatePhoto;
    }

    public int getInventoryDay() {
        return inventoryDay;
    }

    public void setInventoryDay(int inventoryDay) {
        this.inventoryDay = inventoryDay;
    }

    public String getStatusDescription() {
        return statusDescription;
    }

    public void setStatusDescription(String statusDescription) {
        this.statusDescription = statusDescription;
    }

    public int getPropertyCertificate() {
        return propertyCertificate;
    }

    public void setPropertyCertificate(int propertyCertificate) {
        this.propertyCertificate = propertyCertificate;
    }

    public String getPropertyCertificatePhoto() {
        return propertyCertificatePhoto;
    }

    public void setPropertyCertificatePhoto(String propertyCertificatePhoto) {
        this.propertyCertificatePhoto = propertyCertificatePhoto;
    }

    public int getIsInGuarantee() {
        return isInGuarantee;
    }

    public void setIsInGuarantee(int isInGuarantee) {
        this.isInGuarantee = isInGuarantee;
    }

    public int getNumberOfKey() {
        return numberOfKey;
    }

    public void setNumberOfKey(int numberOfKey) {
        this.numberOfKey = numberOfKey;
    }

    public int getIsIllegal() {
        return isIllegal;
    }

    public void setIsIllegal(int isIllegal) {
        this.isIllegal = isIllegal;
    }

    public String getIllegalPhoto() {
        return illegalPhoto;
    }

    public void setIllegalPhoto(String illegalPhoto) {
        this.illegalPhoto = illegalPhoto;
    }

    public String getPlaceOfOrigin() {
        return placeOfOrigin;
    }

    public void setPlaceOfOrigin(String placeOfOrigin) {
        this.placeOfOrigin = placeOfOrigin;
    }

    public int getIsUserManual() {
        return isUserManual;
    }

    public void setIsUserManual(int isUserManual) {
        this.isUserManual = isUserManual;
    }

    public int getIsPurchaseCertificate() {
        return isPurchaseCertificate;
    }

    public void setIsPurchaseCertificate(int isPurchaseCertificate) {
        this.isPurchaseCertificate = isPurchaseCertificate;
    }

    public int getIsDrivingLicense() {
        return isDrivingLicense;
    }

    public void setIsDrivingLicense(int isDrivingLicense) {
        this.isDrivingLicense = isDrivingLicense;
    }

    public String getDrivingLicensePhoto() {
        return drivingLicensePhoto;
    }

    public void setDrivingLicensePhoto(String drivingLicensePhoto) {
        this.drivingLicensePhoto = drivingLicensePhoto;
    }

    public int getIsMaintenanceManual() {
        return isMaintenanceManual;
    }

    public void setIsMaintenanceManual(int isMaintenanceManual) {
        this.isMaintenanceManual = isMaintenanceManual;
    }

    public String getMaintenanceInvoicePhoto() {
        return maintenanceInvoicePhoto;
    }

    public void setMaintenanceInvoicePhoto(String maintenanceInvoicePhoto) {
        this.maintenanceInvoicePhoto = maintenanceInvoicePhoto;
    }

    public int getIsPolicy() {
        return isPolicy;
    }

    public void setIsPolicy(int isPolicy) {
        this.isPolicy = isPolicy;
    }

    public Date getTimeOfMaturity() {
        return timeOfMaturity;
    }

    public void setTimeOfMaturity(Date timeOfMaturity) {
        this.timeOfMaturity = timeOfMaturity;
    }

    public Date getAnnualInspection() {
        return annualInspection;
    }

    public void setAnnualInspection(Date annualInspection) {
        this.annualInspection = annualInspection;
    }

    public int getIsNormalTransfer() {
        return isNormalTransfer;
    }

    public void setIsNormalTransfer(int isNormalTransfer) {
        this.isNormalTransfer = isNormalTransfer;
    }

    public int getIsCopyOfID() {
        return isCopyOfID;
    }

    public void setIsCopyOfID(int isCopyOfID) {
        this.isCopyOfID = isCopyOfID;
    }

    public int getIsCarInvoice() {
        return isCarInvoice;
    }

    public void setIsCarInvoice(int isCarInvoice) {
        this.isCarInvoice = isCarInvoice;
    }

    public int getNumberOfAshtray() {
        return numberOfAshtray;
    }

    public void setNumberOfAshtray(int numberOfAshtray) {
        this.numberOfAshtray = numberOfAshtray;
    }

    public int getNumberOfCigaretteLighter() {
        return numberOfCigaretteLighter;
    }

    public void setNumberOfCigaretteLighter(int numberOfCigaretteLighter) {
        this.numberOfCigaretteLighter = numberOfCigaretteLighter;
    }

    public int getNumberOfAidKit() {
        return numberOfAidKit;
    }

    public void setNumberOfAidKit(int numberOfAidKit) {
        this.numberOfAidKit = numberOfAidKit;
    }

    public int getNumberOfTrailerHook() {
        return numberOfTrailerHook;
    }

    public void setNumberOfTrailerHook(int numberOfTrailerHook) {
        this.numberOfTrailerHook = numberOfTrailerHook;
    }

    public int getNumberOfSpareTire() {
        return numberOfSpareTire;
    }

    public void setNumberOfSpareTire(int numberOfSpareTire) {
        this.numberOfSpareTire = numberOfSpareTire;
    }

    public int getNumberOfJack() {
        return numberOfJack;
    }

    public void setNumberOfJack(int numberOfJack) {
        this.numberOfJack = numberOfJack;
    }

    public int getNumberOfNet() {
        return numberOfNet;
    }

    public void setNumberOfNet(int numberOfNet) {
        this.numberOfNet = numberOfNet;
    }

    public int getNumberOfWarningTriangle() {
        return numberOfWarningTriangle;
    }

    public void setNumberOfWarningTriangle(int numberOfWarningTriangle) {
        this.numberOfWarningTriangle = numberOfWarningTriangle;
    }

    public int getNumberOfExtinguisher() {
        return numberOfExtinguisher;
    }

    public void setNumberOfExtinguisher(int numberOfExtinguisher) {
        this.numberOfExtinguisher = numberOfExtinguisher;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public int getAction() {
        return action;
    }

    public void setAction(int action) {
        this.action = action;
    }

    public String getDamageDescription() {
        return damageDescription;
    }

    public void setDamageDescription(String damageDescription) {
        this.damageDescription = damageDescription;
    }
}
