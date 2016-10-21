package com.haoche.bos.controller;

import com.haoche.bos.service.FeedBackService;
import com.haoche.bos.service.UserInfoService;
import com.haoche.remoting.dto.FeedBackDTO;
import com.haoche.remoting.dto.PageNateDTO;
import com.haoche.userauth.remoting.dto.UserInfoDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.rmi.RemoteException;

/**
 * 消息反馈
 * Created by allan on 2016/8/9.
 */
@Controller
@RequestMapping("/system/feedBack")
public class FeedBackController {
    @Autowired
    FeedBackService feedBackService;

    @RequestMapping(name = "消息反馈列表",value = "/list",method = RequestMethod.GET)
    public ModelAndView list(@RequestParam(value = "pageNo",defaultValue = "0")int pageNo,
                             @RequestParam(value = "pageSize",defaultValue = "10")int pageSize) throws RemoteException {
        PageNateDTO page = this.feedBackService.getList(pageNo,pageSize);
        return new ModelAndView("/system/feedback/list","page",page);
    }
}
