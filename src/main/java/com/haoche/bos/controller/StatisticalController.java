package com.haoche.bos.controller;

import com.alibaba.fastjson.JSONObject;
import com.haoche.bos.util.CalendarUtils;
import com.haoche.bos.util.Helper;
import com.haoche.bos.util.JsonUtil;
import com.haoche.remoting.stub.StatisticalInterface;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.swing.plaf.synth.SynthTextAreaUI;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.rmi.RemoteException;
import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
public class StatisticalController {
    @Autowired
    StatisticalInterface statisticalInterface;

    @Value("${onlineSaleStatic.url}")
    private String onlineSaleStaticUrl;

    /**
     * @param days 天数(指定的多少天内)
     * @param start 开始时间
     * @param end 结束时间
     * @return
     * @throws RemoteException
     */
    @RequestMapping(name="首页统计",value="/index/statistical",method = RequestMethod.GET)
    public ModelAndView getStatistical(Integer days,
                                       String start,
                                       String end) throws RemoteException, ParseException {
        Date startDate;
        Date endDate;
        if(days == null && (start == null || end == null)){
            days = new Integer(7);
        }
        if(!(start != null && end != null)){
            endDate = CalendarUtils.dayEnd(new Date());
            startDate = CalendarUtils.dayStart(CalendarUtils.beforeOfDays(new Date(),days-1));
        }else{
            startDate = CalendarUtils.dayStart(DateUtils.parseDate(start,"yyyy年MM月dd日"));
            endDate = CalendarUtils.dayEnd(DateUtils.parseDate(end,"yyyy年MM月dd日"));
        }

        Map<String,Object> map = new HashMap<>();
        Map<String,Integer> inventoryStatistics = this.statisticalInterface.inventoryStatistics();
        Map<String,Integer> timeStatistics = this.statisticalInterface.timeStatistics(startDate,endDate);
        map.put("inventoryStatistics",inventoryStatistics);
        map.put("timeStatistics",timeStatistics);
        map.put("currentDate",DateFormatUtils.format(new Date(),"yyyy-MM-dd hh:mm:ss"));
        map.put("start",DateFormatUtils.format(startDate,"yyyy年MM月dd日"));
        map.put("end",DateFormatUtils.format(endDate,"yyyy年MM月dd日"));
        map.put("days",(endDate.getTime()-startDate.getTime())/(1000*60*60*24)+1);
        return new ModelAndView("/welcome","map",map);
    }

    @RequestMapping(name="二手车线上在售分析",value="/index/onlineSaleStatistic",method = RequestMethod.GET)
    public ModelAndView onlineSaleStatic() {
        Map<String,Object> map = new HashMap<>();
        return new ModelAndView("/index/static/online_sale_static","map",map);
    }

    @RequestMapping(name="二手车线上获取数据",value="/index/search",method = RequestMethod.GET)
    @ResponseBody
    public Object getStatic(@RequestParam(value = "q")String q,
                          @RequestParam(value = "d")String d,
                          @RequestParam(value = "i",defaultValue = "3")String i
                          ) throws IOException {
        String url;
        url = this.onlineSaleStaticUrl + "?q=" + q;
        if (d != "") {
            url += "&d=" + d;
        }
        if (i != "") {
            url += "&i=" + i;
        }
        System.out.println(url);
        String output = "";
        HttpClient httpClient = new DefaultHttpClient();
        HttpGet httpget = new HttpGet(url);
        HttpResponse response = httpClient.execute(httpget);
        if (response.getStatusLine().getStatusCode() == 200) {
            BufferedReader br = new BufferedReader(
                    new InputStreamReader((response.getEntity().getContent())));
            String output1;
            while ((output1 = br.readLine()) != null) {
                output = output + output1;
            }
        }
        return JSONObject.parse(output);
    }
}