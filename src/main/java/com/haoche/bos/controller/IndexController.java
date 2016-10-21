package com.haoche.bos.controller;

import com.haoche.bos.util.CurrentUser;
import com.haoche.remoting.dto.PageNateDTO;
import com.haoche.remoting.dto.help.HelpDocumentDTO;
import com.haoche.remoting.dto.help.HelpMenuDTO;
import com.haoche.remoting.exceptions.HelpException;
import com.haoche.remoting.stub.HelpInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class IndexController {
    @Autowired
    private HelpInterface helpInterface;

    @RequestMapping(value = "/",method = RequestMethod.GET)
    public ModelAndView index() {
//        if (CurrentUser.get() != null) {
//            return new ModelAndView("redirect:/index");
//        }
        return new ModelAndView("/emp/login");
    }

    @RequestMapping(value = "/index",method = RequestMethod.GET)
    public ModelAndView welcome() {
        return new ModelAndView("redirect:/index/statistical");
    }

    @RequestMapping(value = "/error",method = RequestMethod.GET)
    public String error() {
        return "/error";
    }

    @RequestMapping(name="首页帮助文档列表页面",value="/index/help/documentList",method=RequestMethod.GET)
    public ModelAndView helpDocumentList(@RequestParam(value = "firstLevelMenuId") Long firstLevelMenuId,
                                         @RequestParam(value = "secondLevelMenuId",defaultValue = "0") Long secondLevelMenuId,
                                         @RequestParam(value = "pageNo",defaultValue = "0")int pageNo,
                                         @RequestParam(value = "pageSize",defaultValue = "10")int pageSize) throws RemoteException {
        Map<String,Object> map = new HashMap<>();
        //一级标题
        List<HelpMenuDTO> firstLevelMenuList = this.helpInterface.getHelpMenuList(1,null,new Boolean[]{false},0,100).getList();
        map.put("firstLevelMenuList",firstLevelMenuList);

        //二级标题
        List<HelpMenuDTO> secondLevelMenuList = new ArrayList<>();
        if(firstLevelMenuId != null && firstLevelMenuId != 0){
            secondLevelMenuList = this.helpInterface.getHelpMenuListByParentId(firstLevelMenuId,new Boolean[]{false});
        }else if(firstLevelMenuId == null || firstLevelMenuId == 0){
            if(firstLevelMenuList.size() > 0){
                secondLevelMenuList = this.helpInterface.getHelpMenuListByParentId(firstLevelMenuList.get(0).getId(),new Boolean[]{false});
            }
        }
        map.put("secondLevelMenuList",secondLevelMenuList);

        PageNateDTO page = this.helpInterface.getHelpDocumentList(firstLevelMenuId,secondLevelMenuId,new Boolean[]{false},0,100);
        map.put("page",page);

        map.put("firstLevelMenuId",firstLevelMenuId);
        map.put("secondLevelMenuId",secondLevelMenuId);
        return new ModelAndView("/index/help/helpdocument_list","map",map);
    }

    @RequestMapping(name="首页帮助文档详情",value="/index/help/documentDetail",method=RequestMethod.GET)
    public ModelAndView documentDetail(@RequestParam(value = "documentId")Long documentId) throws RemoteException, HelpException {
        Map<String,Object> map = new HashMap<>();
        //一级标题
        List<HelpMenuDTO> firstLevelMenuList = this.helpInterface.getHelpMenuList(1,null,new Boolean[]{false},0,100).getList();
        map.put("firstLevelMenuList",firstLevelMenuList);

        HelpDocumentDTO documentDTO = this.helpInterface.getHelpDocumentById(documentId);
        map.put("document",documentDTO);
        return new ModelAndView("/index/help/helpdocument_detail","map",map);
    }
}
