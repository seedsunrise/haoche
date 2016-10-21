$(function(){
    var OnlineSaleStaic = {
        url: "/index/search",
        init: function() {
            this.initEvent();
        },
        initEvent: function() {
            var self = this;
            $("body").on("GetOnlineSaleStatic:SUCCESS", function(e, data){
                var tmp = JSON.parse(data.data);
                self.drawTotalPriceChart(tmp);
                self.drawRegistrationDateChart(tmp);
                self.drawChartByYearType(tmp);
                self.drawChartByCity(tmp);
            });
            var $chartSearchBtn = $(".ChartSearchWrapper .Btn");
            $chartSearchBtn.on("click", function(){
                $(".ChartWrapper").show();
                var query = $(".ChartQuery").val().trim();
                var date = $(".ChartDate").val();
                if (query) {
                    query = query.replace(" ", "+");
                    date = date.replace("年", "").replace("月", "").replace("日", "");
                    self.getStatic(query, date);
                }
            });
            $chartSearchBtn.trigger("click");
            $('.ChartDate').on("change", function(){
                $chartSearchBtn.trigger("click");
            });
        },
        getStatic: function(query, date) {
            $(".Chart").html("查询中...");
            Util.Ajax({
                url: this.url,
                type: "get",
                dataType: "html",
                data: {
                    q: query,
                    d: date,
                    i: "30"
                },
                noInterActive: true,
                nameSpace: "GetOnlineSaleStatic"
            });
        },
        drawTotalPriceChart: function(data) {
            console.log(data);
            var self = this;
            var totalPriceChart = echarts.init(document.getElementById("TotalChart"), 'shine');
            var  xAxisData = [];
            var seriesTotalCarData = [];
            var seriesAvgPriceData = [];
            if (data && data.data && data.data.length > 0) {
                $.each(data.data, function(index, val){
                    var keys = Object.keys(val);
                    var tmp = val[keys[0]];
                    if (tmp) {
                        xAxisData.push(self.parseDate(keys[0]));
                        seriesTotalCarData.push(tmp.count);
                        seriesAvgPriceData.push(tmp.avg);
                    }
                })
            }
            xAxisData.reverse();
            seriesAvgPriceData.reverse();
            seriesTotalCarData.reverse();
            var option = {
                title: {
                    subtext: ' 平均价格（万元）/ 车辆总数（台）'
                },
                animation: false,
                tooltip : {
                    trigger: 'axis',
                    axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                        type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
                    }
                },
                toolbox: {
                    feature: {
                        dataZoom: {
                            yAxisIndex: false
                        },
                        brush: {
                            type: ['lineX', 'clear']
                        }
                    }
                },
                brush: {
                    xAxisIndex: 'all',
                    brushLink: 'all',
                    outOfBrush: {
                        colorAlpha: 0.1
                    }
                },
                legend: {
                    data:["平均价格"]
                },
                grid: [
                    {
                        left: '10%',
                        right: '8%',
                        height: '50%'
                    },
                    {
                        left: '10%',
                        right: '8%',
                        top: '66%',
                        height: '16%'
                    }
                ],
                xAxis: [
                    {
                        type: 'category',
                        data : xAxisData,
                        scale: true,
                        boundaryGap : false,
                        axisLine: {onZero: false},
                        splitLine: {show: false},
                        splitNumber: 20,
                        min: 'dataMin',
                        max: 'dataMax'
                    },
                    {
                        type: 'category',
                        gridIndex: 1,
                        data : xAxisData,
                        scale: true,
                        boundaryGap : false,
                        axisLine: {onZero: false},
                        axisTick: {show: false},
                        splitLine: {show: false},
                        axisLabel: {show: false},
                        splitNumber: 20,
                        min: 'dataMin',
                        max: 'dataMax'
                    }
                ],
                yAxis: [
                    {
                        scale: true,
                        splitArea: {
                            show: true
                        }
                    },
                    {
                        scale: true,
                        gridIndex: 1,
                        splitNumber: 2,
                        axisLabel: {show: false},
                        axisLine: {show: false},
                        axisTick: {show: false},
                        splitLine: {show: false}
                    }
                ],
                dataZoom: [
                    {
                        type: 'inside',
                        xAxisIndex: [0, 1]
                        //start: 98,
                        //end: 100
                    },
                    {
                        show: true,
                        type: 'slider',
                        top: '85%'
                        //start: 98,
                        //end: 100
                    }
                ],
                series : [
                    {
                        name: '平均价格',
                        type: 'line',
                        data: seriesAvgPriceData,
                        smooth: true,
                        lineStyle: {
                            normal: {opacity: 0.5}
                        }
                    },
                    {
                        name:'车辆总台数',
                        type:'bar',
                        barWidth : 20,
                        xAxisIndex: 1,
                        yAxisIndex: 1,
                        data: seriesTotalCarData
                    },
                ]
            };
            totalPriceChart.setOption(option, true);
            totalPriceChart.dispatchAction({
                type: 'brush',
                areas: [
                    {
                        brushType: 'lineX',
                        coordRange: [xAxisData[0], xAxisData[xAxisData.length-1]],
                        xAxisIndex: 0
                    }
                ]
            });
        },
        drawRegistrationDateChart: function(data) {
            var self = this;
            var registrationDateChart = echarts.init(document.getElementById("ChartByRegistrationDate"), 'shine');
            registrationDateChart.setOption(self.getDrawOption(data, "years", "year", "上牌", "均价（元）"));
        },
        drawChartByYearType: function(data) {
            var self = this;
            var yearChart = echarts.init(document.getElementById("ChartByYearType"), 'shine');
            yearChart.setOption(self.getDrawOption(data, "kuans", "kuan", "款", "均价（元）"));
        },
        drawChartByCity: function(data) {
            var self = this;
            var option = self.getDrawOption(data, "citys", "city", "", "均价（元）");
            var length = option.series.length;
            var cityCount = option.series.slice(0, length);
            // 保存参数,备用
            var storeCity = option.series.slice(0, length);
            cityCount.sort(function(a, b){
                return b.count - a.count;
            });
            var sortCity = cityCount.slice(0,4);
            // 取卖数量总和最多的四个城市
            option.series = sortCity;
            var legendData = [];
            $.each(sortCity, function(index, val){
                legendData.push(val.name);
            });
            option.legend.data = legendData;


            // 添加成都和福州
            //option.series.push(self.getSeriesByCityName("福州", storeCity));
            //option.legend.data.push("福州");
            //option.series.push(self.getSeriesByCityName("成都", storeCity));
            //option.legend.data.push("成都");

            // 获取y轴最小值
            var yMin = 9999999999;
            $.each(option.series, function(index, val){
                $.each(val.data, function(i, value){
                    if (yMin> value) {
                        yMin = value;
                    }
                });
            });
            if (yMin > 10000) {
                yMin -= 10000;
            }
            option.yAxis[0].min = yMin;
            var cityChart = echarts.init(document.getElementById("ChartByCity"), 'shine');
            cityChart.setOption(option);
        },
        getSeriesByCityName: function(name, series) {
            var out = {};
            $.each(series, function(index, val){
                //console.log(val);
                if (val.name == name) {
                    out = val;
                }
            });
            return out;
        },
        getDrawOption: function(data, byType, type, label, subtext) {
            var self = this;
            var  xAxisData = [];
            var seriesAvgPriceData = [];
            var legendData = [];
            var seriesDataLabel = {};
            var yMin = 9999999999;
            if (data && data.data && data.data.length > 0) {
                $.each(data.data, function(index, val){
                    var keys = Object.keys(val);
                    var tmp = val[keys[0]]
                    if (tmp && tmp[byType] && tmp[byType].length > 0) {
                        // 横坐标
                        xAxisData.push(self.parseDate(keys[0]));
                        $.each(tmp[byType], function(i, tmpVal){
                            if (!seriesDataLabel[tmpVal[type] + label]) {
                                seriesDataLabel[tmpVal[type] + label] = {
                                    count: 0,
                                    data: []
                                };
                            }

                            // 统计该 type 的所有日期的总数
                            seriesDataLabel[tmpVal[type] + label].count += tmpVal.count;

                            // 该 type 各个日期的均价数组
                            seriesDataLabel[tmpVal[type] + label].data.push(tmpVal.avg);
                            // 记录y轴最小值
                            if (yMin > tmpVal.avg) {
                                yMin = tmpVal.avg
                            }
                            // legend标识符 只用统计第一条数据
                            if (index == 0) {
                                legendData.push(tmpVal[type] + label);
                            }
                        });
                    }
                })
            }

            if (yMin > 10000) {
                yMin -= 10000;
            }
            xAxisData.reverse();
            seriesAvgPriceData.reverse();
            var seriesData = [];
            $.each(legendData, function(key, val){
                seriesData.push({
                    name: val,
                    type:'line',
                    data: seriesDataLabel[val].data.reverse(),
                    count: seriesDataLabel[val].count
                });
            });
            var option = {
                title: {
                    subtext: subtext,
                    left: 50
                },
                tooltip : {
                    trigger: 'axis',
                    axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                        type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                    }
                },
                legend: {
                    data: legendData
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                xAxis : [
                    {
                        type : 'category',
                        data : xAxisData
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        min: yMin
                    }
                ],
                series : seriesData
            };
            return option;
        },
        parseDate: function(date) {
            var out = [date.slice(0, 4), "-", date.slice(4)].join('');
            out = [out.slice(0, 7), "-", out.slice(7)].join('');
            var tmp = new Date(out);
            return (tmp.getMonth() + 1) + "月" + tmp.getDate() + "日";
        }
    };

    if ($("#HomeOnlineSaleStatic")[0]) {
        OnlineSaleStaic.init();
    }
});