$(function(){
    // 分组最后的一行没有border
    $('.ParamGroup').each(function(){
        var $lis = $(this).find('li');
        var length = $lis.length;
        $lis.eq(length-1).addClass("NoBorder");
        if ( length % 2 == 0) {
            $lis.eq(length-2).addClass("NoBorder");
        }
    });
    $(".PrintBtn").on("click", function(){
        window.print();
    });

    // 字段
    var fieldsMap =  {
        // 基本参数
        basicParameter:{
            _class: "BaseParameter",
            _: "基本参数",
            modleName: "车型名称",
            guidePrice: "指导价",
            brandName: "品牌名称",
            carevel: "车辆级别",
            transmissionBox: "变速箱",
            lengthWidthHeight: "长宽高(mm)",
            carStructure: "车身结构",
            maxSpeed: "最高速度(km/h)",
            officialAccelerationTime: "官方0-100Km加速(s)",
            actualAccelerationTime: "实测0-100Km加速(s)",
            actualBrakingLength: "实测100-0制动距离(s)",
            oilConsumption: "油耗(L/100km)",
            officialOilConsumption: "工信部综合油耗(L/100km)",
            groundClearance: "离地间隙(mm)",
            warranty: "整车质保"
        },
        // 车身参数
        carBodyParameter: {
            _class: "CarBody",
            _: "车身参数",
            length: "长(mm)",
            width: "宽(mm)",
            height: "高(mm)",
            wheelbase: "轴距(mm)",
            frontTrack: "前轮距(mm)",
            rearWheel: "后轮距(mm)",
            minimumGroundClearance: "最小离地间隙(mm)",
            curbWeight: "整备质量(kg)",
            carBodyStructure: "车身结构",
            numberOfCarDoor: "车门数(个)",
            numberOfCarSeats: "座位数(个)",
            tankVolume: "油箱容积(L)",
            trunkVolume: "后备箱容积(L)"
        },
        // 发动机参数
        engineParameter: {
            _class: "Engine",
            _: "发动机参数",
            engineIdentity: "发动机型号",
            displacement: "排量(mL)",
            airIntakeForm: "进气形式",
            cylinderArrangement: "气缸排列形式",
            numberOfCylinders: "气缸数(个)",
            valveTrain: "每缸气门数(个)",
            compressionRatio: "压缩比",
            airDistributionMechanism: "配气机构",
            bore: "缸径(mm)",
            stroke: "行程(mm)",
            maximumHorsepower: "最大马力(Ps)",
            maximumPower: "最大功率(kW)",
            maximumPowerSpeed: "最大功率转速(rpm)",
            maxTorque: "最大扭矩(N·m)",
            maximumTorqueSpeed: "最大扭矩转速(rpm)",
            engineSpecificTechnology: "发动机特有技术",
            fuelForm: "燃料形式",
            fuelLabel: "燃油标号",
            oilSupplyMode: "供油方式",
            cylinderHeadMaterial: "缸盖材料",
            cylinderMaterial: "缸体材料",
            environmentalStandards: "环保标准"
        },
        // 变速箱
        transmissionBox: {
            _class: "Gearbox",
            _: "变速箱",
            abbreviation: "简称",
            numberOfBlock: "挡位个数",
            transmissionType: "变速箱类型"
        },
        // 底盘转向
        chassisSTEERING: {
            _class: "ChassisSteering",
            _: "底盘转向",
            drivingMethod: "驱动方式",
            fourWheelFriveForm: "四驱形式",
            centralDifferentialStructure: "中央差速器结构",
            frontSuspensionType: "前悬架类型",
            endSuspensionType: "后悬架类型",
            assistType: "助力类型",
            carBodyStructure: "车体结构"
        },
        // 车轮制动
        wheelBrake: {
            _class: "WheelBrake",
            _: "车轮制动",
            frontBrakeType: "前制动器类型",
            rearBrakeType: "后制动器类型",
            parkingBrakeType: "驻车制动类型",
            frontTireSize: "前轮胎规格",
            rearTireSpecification: "后轮胎规格",
            spareTireSpecifications: "备胎规格"
        },
        // 安全装备
        safeConfig: {
            _class: "SafetyEquipment",
            '_': "安全装备",
            mainSubAirBag: "主/副驾驶座安全气囊",
            sideAirBag: "前/后排侧气囊",
            headAirBag: "前/后排头部气囊(气帘)",
            kneeAirBag: "膝部气囊",
            tirePressureDevice: "胎压监测装置",
            zeroTire: "零胎压继续行驶",
            seatBelt: "安全带未系提示",
            childSeatInterface: "ISOFIX儿童座椅接口",
            enginelAntiTheft: "发动机电子防盗",
            carLock: "车内中控锁",
            remoteKey: "遥控钥匙",
            noKeyStartSystem: "无钥匙启动系统",
            noKeyInCar: "无钥匙进入系统"
        },
        // 操控配置
        controlConfiguration: {
            _class: "ConfigurationControl",
            _: "操控配置",
            ABSantiLock: "ABS防抱死",
            brakeForceDistribution: "制动力分配(EBD/CBC等)",
            brakeAssist: "刹车辅助(EBA/BAS/BA等)",
            tractionControl: "牵引力控制(ASR/TCS/TRC等)",
            bodyStabilityControl: "车身稳定控制(ESC/ESP/DSC等)",
            hillStartAssist: "上坡辅助",
            autoHold: "自动驻车",
            hdc: "陡坡缓降",
            variableSuspension: "可变悬架",
            airSuspension: "空气悬架",
            variableSteeringRatio: "可变转向比",
            limitedSlipDifferential: "前桥限滑差速器/差速锁",
            centralDifferentialLockFunction: "中央差速器锁止功能",
            differentialLock: "后桥限滑差速器/差速锁"
        },
        // 外部配置
        externalConfiguration: {
            _class: "ExternalConfig",
            _: "外部配置",
            electricSkylight: "电动天窗",
            panoramicSunroof: "全景天窗",
            sportAppearancePackage: "运动外观套件",
            aluminumAlloyWheels: "铝合金轮圈",
            electricDoorPull: "电动吸合门",
            slidingDoor: "侧滑门",
            electricReserve: "电动后备厢",
            inductionTrunk: "感应后备厢",
            roofLuggageRack: "车顶行李架"
        },
        // 内部配置
        internalConfiguration: {
            _class: "InnerConfig",
            _: "内部配置",
            leatherSteeringWheel: "真皮方向盘",
            steeringWheelAdjustment: "方向盘调节",
            steeringWheelElectricRegulation: "方向盘电动调节",
            multifunctionSteeringWheel: "多功能方向盘",
            steeringWheelShift: "方向盘换挡",
            heatedSteeringWheel: "方向盘加热",
            cruiseControl: "定速巡航",
            parkingRadar: "前/后驻车雷达",
            reverseVideo: "倒车视频影像",
            drivingComputer: "行车电脑显示屏",
            headerDigitalDisplay: "HUD抬头数字显示"
        },
        // 座椅配置
        seatConfiguration: {
            _class: "SeatConfig",
            _: "座椅配置",
            seatMaterial: "座椅材质",
            sportSeat: "运动风格座椅",
            seatHeightAdjustment: "座椅高低调节",
            sumbarSupportAdjustment: "腰部支撑调节",
            shoulderSupportAdjustment: "肩部支撑调节",
            electricRegulation: "主/副驾驶座电动调节",
            angleAdjustment: "第二排靠背角度调节",
            seatMovement: "第二排座椅移动",
            rearSeatElectricAdjustment: "后排座椅电动调节",
            electricSeatMemory: "电动座椅记忆",
            seatHeating: "前/后排座椅加热",
            seatVentilation: "前/后排座椅通风",
            seatMassage: "前/后排座椅按摩",
            seatsReclineWay: "后排座椅放倒方式",
            centralRail: "前/后中央扶手",
            cupHolder: "后排杯架"
        },
        // 多媒体配置
        mediaConfiguration: {
            _class: "DisplayConfig",
            _: "多媒体配置",
            GPS: "GPS导航系统",
            interactiveServices: "定位互动服务",
            centralControl: "中控台彩色大屏",
            remotePhone: "蓝牙/车载电话",
            carTV: "车载电视",
            rearVideo: "后排液晶屏",
            CD: "CD支持MP3/WMA",
            media: "多媒体系统",
            speakerBrand: "扬声器品牌",
            numberOfSpeaker: "扬声器数量"
        },
        // 灯光配置
        lightConfiguration: {
            _class: "LightConfig",
            _: "灯光配置",
            dippedHeadlight: "近光灯",
            daytimeDrivingLights: "日间行车灯",
            automaticHeadlights: "自动头灯",
            corneringLamp: "转向辅助灯",
            turnTheHeadlights: "转向头灯",
            FrontFogLamp: "前雾灯",
            headlightHeightAdjustable: "大灯高度可调",
            headlightCleaningDevice: "大灯清洗装置",
            interiorAirLamp: "车内氛围灯",
            highBeam: "远光灯",
            adaptiveFarAndNearLight: "自适应远近光"
        },
        // 玻璃/后视镜
        glassConfiguration: {
            _class: "GlassAndMirrors",
            _: "玻璃/后视镜",
            frontRearPowerWindow: "前/后电动车窗",
            windowAntiPinchFunction: "车窗防夹手功能",
            heatInsulationGlass: "防紫外线/隔热玻璃",
            electricControlMirror: "后视镜电动调节",
            mirrorHeating: "后视镜加热",
            rearviewMirror: "内/外后视镜自动防眩目",
            electricMirror: "后视镜电动折叠",
            mirrorMemory: "后视镜记忆",
            sunShade: "后风挡遮阳帘",
            rearSideSunShading: "后排侧遮阳帘",
            rearSidePrivacyGlass: "后排侧隐私玻璃",
            sunShadingBoard: "遮阳板化妆镜",
            rearWiper: "后雨刷",
            sensingWipers: "感应雨刷"
        },
        // 空调/冰箱
        airConditioning: {
            _class: "AirConditioningAndRefrigerator",
            _: "空调/冰箱",
            airControl: "空调控制方式",
            rearAirControl: "后排独立空调",
            rearAirOutlet: "后座出风口",
            airZoneControl: "温度分区控制",
            pollenFiltration: "车内空气调节/花粉过滤",
            vehicleMountedRefrigerator: "车载冰箱"
        },
        // 高科技配置
        highTechConfiguration: {
            _class: "TechConfig",
            _: "高科技配置",
            automaticParking: "自动泊车入位",
            startStop: "发动机启停技术",
            auxiliary: "并线辅助",
            ldws: "车道偏离预警系统",
            activeBrake: "主动刹车/主动安全系统",
            integralActiveSteering: "整体主动转向系统",
            nightVisionSystem: "夜视系统",
            divideVideo: "中控液晶屏分屏显示",
            adaptiveCruiseControl: "自适应巡航",
            panoramicCamera: "全景摄像头"
        }
    };

    var data = $("#CarConfig").val();
    if (data) {
        data  = JSON.parse(data).carConfig;
        var html = "";
        for(var g in fieldsMap) {
            var gs=fieldsMap[g];
            html += '<div class="EachGroup '+ gs._class + '">' +
                '<h3 class="PageTip">' + gs._ + '<span>' +
                '<span>● 标配</span>' +
                '<span>○ 选配</span>' +
                '<span>- 无</span>' +
                '</span>' +
                '</h3>';
            delete gs._;
            delete gs._class;
            html += '<ul class="Clearfix ParamGroup">';
            for(var k in gs) {
                html += '<li class="Clearfix">' +
                    '<span>' + gs[k] + '</span>' +
                    '<span class="ParameterValue">' + data[g][k] + '</span>' +
                    '</li>';
            }
            html += '</ul></div>';
        }
        $('.CarConfigWrapper').append(html);
    }
});