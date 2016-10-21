package com.haoche.bos.controller;

import com.haoche.bos.config.security.EmpInfo;
import com.haoche.bos.datamapper.ActionDto;
import com.haoche.bos.datamapper.Template;
import com.haoche.bos.service.PermissionsService;
import com.haoche.bos.util.CurrentUser;
import com.haoche.remoting.dto.ActionDTO;
import com.haoche.remoting.dto.GroupDTO;
import com.haoche.remoting.dto.PageNateDTO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/permissions")
public class PermissionsController {

    @Autowired
    private PermissionsService permissionsService;

    @RequestMapping(name = "权限列表",value = "/actionList",method = RequestMethod.GET)
    public ModelAndView actions(@RequestParam(name = "search",defaultValue = "") String search,@RequestParam(name = "pageNo",defaultValue = "0") int pageNo,@RequestParam(name = "pageSize",defaultValue = "10") int pageSize) throws RemoteException {
        PageNateDTO pageNateDTO = permissionsService.actions(search, pageNo, pageSize);
        return new ModelAndView("/permissions/actionList","page",pageNateDTO);
    }

    @RequestMapping(name = "角色列表",value = "/groupList",method = RequestMethod.GET)
    public ModelAndView groups(@RequestParam(name = "pageNo",defaultValue = "0") int pageNo,@RequestParam(name = "pageSize",defaultValue = "10") int pageSize) throws RemoteException {
        PageNateDTO pageNateDTO = permissionsService.groups(pageNo, pageSize);
        return new ModelAndView("/permissions/groupList","page",pageNateDTO);
    }

    @RequestMapping(name = "新增/更新角色页面",value = "/edit",method = RequestMethod.GET)
    public ModelAndView edit(@RequestParam(value = "groupId", defaultValue = "0") Long grouId) throws RemoteException {
        Map map = new HashMap();
        List<ActionDto> actionDtos = new ArrayList<>();
        List<ActionDTO> actionDTOs = permissionsService.actions("",0,500).getList();
        if (grouId == 0) {
            for (ActionDTO actionDTO:actionDTOs) {
                ActionDto actionDto = new ActionDto();
                BeanUtils.copyProperties(actionDTO,actionDto);
                actionDtos.add(actionDto);
            }
        } else {
            List<ActionDTO> actions = permissionsService.actions(grouId);
            for (ActionDTO actionDTO:actionDTOs) {
                ActionDto actionDto = new ActionDto();
                BeanUtils.copyProperties(actionDTO,actionDto);
                for (ActionDTO action:actions) {
                    if (action.getId().equals(actionDTO.getId())) {
                        actionDto.setIsSelect(1);
                    }
                }
                actionDtos.add(actionDto);
            }
            map.put("group",permissionsService.getOneGroup(grouId));
        }
        map.put("actions",actionDtos);
        return new ModelAndView("/permissions/edit","map",map);
    }

    @ResponseBody
    @RequestMapping(name = "新增/更新角色动作",value = "/update",method = RequestMethod.POST)
    public Template updateGroup(@RequestParam (name = "id",defaultValue = "0")Long id, @RequestParam(name = "groupName") String groupName, @RequestParam(name = "groupDesc",defaultValue = "") String groupDesc, @RequestParam(name = "actions")List<String> actions) throws RemoteException {
        Template template = new Template();
        Map map = new HashMap();
        map.put("url","/permissions/groupList");
        template.setData(map);
        permissionsService.updateGroups(id,groupName, groupDesc,actions);
        return template;
    }

    @ResponseBody
    @RequestMapping(name = "删除角色",value = "/delete",method = RequestMethod.POST)
    public Template delete(@RequestParam(value = "id",defaultValue = "0") Long groupId) throws RemoteException {
        permissionsService.deleteGrou(groupId);
        Template template = new Template();
        Map map = new HashMap();
        map.put("url","/permissions/groupList");
        template.setData(map);
        return template;
    }

    @RequestMapping(name = "角色详情",value = "/detail",method = RequestMethod.GET)
    public ModelAndView detail(@RequestParam(value = "id",defaultValue = "0") Long groupId) throws RemoteException {
        GroupDTO groupDTO = permissionsService.getOneGroup(groupId);
        List<ActionDTO> actions = permissionsService.actions(groupId);
        Map map = new HashMap();
        map.put("group",groupDTO);
        map.put("actions",actions);
        return new ModelAndView("/permissions/detail","group",map);
    }

    @RequestMapping(name = "获取角色权限",value = "/groupActions",method = RequestMethod.POST)
    public ModelAndView actions(@RequestParam (name = "id",defaultValue = "0")Long id) throws RemoteException {
        List<ActionDTO> actionDTOs = permissionsService.actions(id);
        return new ModelAndView("/permissions/groupList");
    }
}