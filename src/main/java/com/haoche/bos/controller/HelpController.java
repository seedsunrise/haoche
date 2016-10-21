package com.haoche.bos.controller;

import com.haoche.bos.config.security.EmpInfo;
import com.haoche.bos.datamapper.Template;
import com.haoche.remoting.dto.OrderListParamDTO;
import com.haoche.remoting.dto.PageNateDTO;
import com.haoche.remoting.dto.help.HelpDocumentDTO;
import com.haoche.remoting.dto.help.HelpMenuDTO;
import com.haoche.remoting.exceptions.HelpException;
import com.haoche.remoting.stub.HelpInterface;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 帮助中心Controller
 * Created by allan on 2016/6/12.
 */
@Controller
@RequestMapping("help")
public class HelpController {
    @Autowired
    HelpInterface helpInterface;

    /**
     * 菜单列表页面
     * @param level 菜单层级
     * @param pageNo
     * @param pageSize
     * @return
     * @throws RemoteException
     */
    @RequestMapping(name = "帮助中心菜单列表",value = "/helpMenu/list",method = RequestMethod.GET)
    public ModelAndView helpMenuList(@RequestParam(value = "level",defaultValue = "1")int level,
                                     String search,
                                     @RequestParam(value = "pageNo",defaultValue = "0")int pageNo,
                                     @RequestParam(value = "pageSize",defaultValue = "10")int pageSize) throws RemoteException {
        PageNateDTO page = this.helpInterface.getHelpMenuList(level,search,new Boolean[]{false,true},pageNo,pageSize);
        Map<String,Object> map = new HashMap<>();
        map.put("level",level);
        map.put("page",page);
        map.put("search",StringUtils.isBlank(search) ? "" : search);
        return new ModelAndView("/system/help/helpmenu_list","map",map);
    }

    @RequestMapping(name = "帮助中心菜单编辑页面",value = "/helpMenu/editPage",method = RequestMethod.GET)
    public ModelAndView editHelpMenuPage(@RequestParam(value = "level")int level,
                                         Long menuId) throws RemoteException, HelpException {
        Map<String,Object> map = new HashMap<>();
        map.put("menuId",menuId);
        map.put("level",level);
        if(null != menuId){
            HelpMenuDTO helpMenuDTO = this.helpInterface.getHelpMenuById(menuId);
            map.put("helpMenu",helpMenuDTO);
        }

        if(level == 2){
            List<HelpMenuDTO> list = this.helpInterface.getHelpMenuList(1,null,new Boolean[]{false,true},0,100).getList();
            map.put("helpMenuFirstLevelList",list);
        }
        return new ModelAndView("/system/help/helpmenu_edit","map",map);
    }

    @ResponseBody
    @RequestMapping(name = "保存帮助中心菜单编",value = "/helpMenu/edit",method = RequestMethod.POST)
    public Object editMenu(@RequestParam(value = "level")int level,
                           @RequestParam(value = "name")String name,
                           @RequestParam(value = "disable")Boolean disable,
                           Long menuId,
                           @RequestParam(value = "parentId",defaultValue = "0")long parentId,
                           @RequestParam(value = "parentName",defaultValue = "")String parentName) throws RemoteException, HelpException {
        HelpMenuDTO helpMenuDTO;
        if(null != menuId){
            helpMenuDTO = this.helpInterface.getHelpMenuById(menuId);
        }else{
            helpMenuDTO = new HelpMenuDTO();
        }
        helpMenuDTO.setLevel(level);
        helpMenuDTO.setName(name);
        helpMenuDTO.setDisable(disable);
        if(level == 2 && (parentId == 0l || StringUtils.isBlank(parentName))){
            throw new HelpException("请选择一级标题");
        }
        helpMenuDTO.setParentId(parentId);

        /*HelpMenuDTO hm = new HelpMenuDTO();
        if(level == 2){
            hm = this.helpInterface.getHelpMenuById(parentId);
            parentName = hm.getName();
        }*/
        helpMenuDTO.setParentName(StringUtils.isBlank(parentName) ? "" : parentName);

        this.helpInterface.saveHelpMenu(helpMenuDTO);

        Template template = new Template();
        Map<String,Object> map = new HashMap<>();
        map.put("helpMenu",helpMenuDTO);
        map.put("url","/help/helpMenu/list?level="+level);
        template.setData(map);
        template.setCode("200");
        template.setMsg("提交成功");
        return template;
    }

    @ResponseBody
    @RequestMapping(name = "禁用帮助中心菜单",value = "/helpMenu/disable",method = RequestMethod.POST)
    public Object disableHelpMenu(@RequestParam(value = "menuId")Long menuId,
                                  @RequestParam(value = "disable")Boolean disable,
                                  @RequestParam(value = "level")int level) throws RemoteException, HelpException {

        this.helpInterface.disableHelpMenu(menuId,disable);

        Template template = new Template();
        Map<String,Object> map = new HashMap<>();
        map.put("url","/help/helpMenu/list?level="+level);
        template.setCode("200");
        template.setMsg("设置成功");
        template.setData(map);
        return template;
    }

    @ResponseBody
    @RequestMapping(name = "删除帮助中心菜单",value = "/helpMenu/delete",method = RequestMethod.POST)
    public Object deleteHelpMenu(@RequestParam(value = "menuId")Long menuId,
                                 @RequestParam(value = "level")int level) throws RemoteException, HelpException {
        this.helpInterface.deleteHelpMenu(menuId);

        Template template = new Template();
        Map<String,Object> map = new HashMap<>();
        map.put("url","/help/helpMenu/list?level="+level);
        template.setCode("200");
        template.setMsg("删除成功");
        return template;
    }


    @RequestMapping(name = "帮助中心文档列表",value = "/helpDocument/list",method = RequestMethod.GET)
    public ModelAndView helpDocumentList(String search,
                                         @RequestParam(value = "pageNo",defaultValue = "0")int pageNo,
                                         @RequestParam(value = "pageSize",defaultValue = "10")int pageSize) throws RemoteException {
        PageNateDTO page = this.helpInterface.getHelpDocumentList(search,new Boolean[]{false,true},pageNo,pageSize);

        Map<String,Object> map = new HashMap<>();
        map.put("search",search);
        map.put("page",page);

        return new ModelAndView("/system/help/helpdocument_list","map",map);
    }

    @RequestMapping(name = "保存帮助中心文档页面",value = "/helpDocument/editPage",method = RequestMethod.GET)
    public ModelAndView editHelpDocumentPage(Long documentId) throws RemoteException, HelpException {
        HelpDocumentDTO helpDocumentDTO;
        Map<String,Object> map = new HashMap<>();
        if(null != documentId){
            helpDocumentDTO = this.helpInterface.getHelpDocumentById(documentId);
            map.put("helpDocument",helpDocumentDTO);
        }
        List<HelpDocumentDTO> firstMenuList = this.helpInterface.getHelpMenuList(1,null,new Boolean[]{false,true},0,100).getList();
        map.put("firstMenuList",firstMenuList);
        map.put("documentId",documentId);
        return new ModelAndView("/system/help/helpdocument_edit","map",map);
    }

    @ResponseBody
    @RequestMapping(name = "保存帮助中心菜单编",value = "/helpDocument/edit",method = RequestMethod.POST)
    public Object editHelpDocument(Long documentId,
                                   @RequestParam(value = "title")String title,
                                   @RequestParam(value = "label")String label,
                                   @RequestParam(value = "firstLevelMenuId")Long firstLevelMenuId,
                                   @RequestParam(value = "firstLevelMenuName")String firstLevelMenuName,
                                   @RequestParam(value = "secondLevelMenuId")Long secondLevelMenuId,
                                   @RequestParam(value = "secondLevelMenuName")String secondLevelMenuName,
                                   String content,
                                   @RequestParam(value = "disable")boolean disable) throws RemoteException, HelpException {
        HelpDocumentDTO helpDocumentDTO;
        if(null != documentId){
            helpDocumentDTO = this.helpInterface.getHelpDocumentById(documentId);
        }else{
            helpDocumentDTO = new HelpDocumentDTO();
        }
        helpDocumentDTO.setTitle(title);
        helpDocumentDTO.setLabel(label);
        helpDocumentDTO.setFirstLevelMenuId(firstLevelMenuId);
        helpDocumentDTO.setFirstLevelMenuName(firstLevelMenuName);
        helpDocumentDTO.setSecondLevelMenuId(secondLevelMenuId);
        helpDocumentDTO.setSecondLevelMenuName(secondLevelMenuName);
        helpDocumentDTO.setDisable(disable);
        helpDocumentDTO.setContent(content);
        EmpInfo empInfo = (EmpInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        helpDocumentDTO.setAuthorId(empInfo.getId());
        helpDocumentDTO.setAuthorName(StringUtils.isBlank(empInfo.getRealName())?empInfo.getUsername():empInfo.getRealName() );

        this.helpInterface.saveHelpDocument(helpDocumentDTO);

        Template template = new Template();
        template.setCode("200");
        template.setMsg("保存成功");
        return template;
    }

    @RequestMapping(name = "获取帮助中心二级菜单",value = "/helpDocument/getHelpMenuByParentId",method = RequestMethod.GET)
    public ModelAndView getHelpMenuByParentId(@RequestParam(value = "parentId")Long parentId) throws RemoteException {
        List<HelpMenuDTO> list = this.helpInterface.getHelpMenuListByParentId(parentId,new Boolean[]{false,true});
        return new ModelAndView("/system/help/helpMenuListTpl","list",list);
    }

    @ResponseBody
    @RequestMapping(name = "禁用帮助中心文档",value = "/helpDocument/disable",method = RequestMethod.POST)
    public Object disableHelpDocument(@RequestParam(value = "documentId")Long documentId,
                                      @RequestParam(value = "disable")boolean disable) throws RemoteException {
        this.helpInterface.disableHelpDocument(documentId,disable);

        Template template = new Template();
        Map<String,Object> map = new HashMap<>();
        map.put("url","/help/helpDocument/list");
        template.setCode("200");
        template.setMsg("设置成功");
        return template;
    }

    @ResponseBody
    @RequestMapping(name = "删除帮助中心菜单",value = "/helpDocument/delete",method = RequestMethod.POST)
    public Object deleteHelpDocument(@RequestParam(value = "documentId")Long documentId) throws RemoteException, HelpException {
        this.helpInterface.deleteHelpDocument(documentId);

        Template template = new Template();
        Map<String,Object> map = new HashMap<>();
        map.put("url","/help/helpDocument/list");
        template.setCode("200");
        template.setMsg("删除成功");
        return template;
    }

    // 根据订单的当前状态获取当前状态和下一个状态的描述, 以及下一步操作描述
    public static Map<String, String> GetTextOfOrderStatus(OrderListParamDTO order) {

        Integer orderStatus = order.getOrderStatus();
        Integer orderType = order.getOrderType();
        Map<String,String> map = new HashMap<>();
        String orderStatusText;
        String nextOrderStatusText;
        String nextAction;
        switch (orderStatus) {
            case 1:
                orderStatusText = "订单提交";
                nextOrderStatusText = "已签合同";
                nextAction = "签合同，交定金";
                break;
            case 2:
                orderStatusText = "已签合同";
                nextOrderStatusText = "待过户";
                if (orderType == 1) {
                    nextAction = "贷款审批，交齐首付";
                } else if (orderType == 2) {
                    nextAction = "交齐首付";
                } else {
                    nextAction = "";
                }
                break;
            case 3:
                orderStatusText = "待过户";
                nextOrderStatusText = "已过户";
                nextAction = "办理过户手续";
                break;
            case 4:
                orderStatusText = "已过户";
                nextOrderStatusText = "待提车";
                nextAction = "放款成功";
                break;
            case 5:
                orderStatusText = "待提车";
                nextOrderStatusText = "已提车";
                nextAction = "客户提车";
                break;
            case 6:
                orderStatusText = "已提车";
                nextOrderStatusText = "";
                nextAction = "";
                break;
            default:
                orderStatusText = "未知状态";
                nextOrderStatusText = "";
                nextAction = "";
        }
        map.put("OrderStatusText", orderStatusText);
        map.put("NextOrderStatusText", nextOrderStatusText);
        map.put("NextAction", nextAction);
        return map;
    }
}
