package com.haoche.bos.controller;


import com.haoche.bos.config.ConstantField;
import com.haoche.bos.config.security.EmpInfo;
import com.haoche.bos.controller.command.NewEmpCommand;
import com.haoche.bos.datamapper.GroupDto;
import com.haoche.bos.datamapper.Template;
import com.haoche.bos.service.*;

import com.haoche.bos.util.CurrentUser;
import com.haoche.remoting.dto.*;

import com.haoche.remoting.exceptions.MobileExistException;
import com.haoche.remoting.exceptions.MobileNotExistException;
import com.haoche.remoting.exceptions.PasswordErrorException;
import com.haoche.remoting.exceptions.PositionExistException;
import com.sun.net.httpserver.HttpsServer;
import org.omg.CORBA.Request;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.rmi.RemoteException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/emp")
public class EmpStaffController {

    @Autowired
    private EmpService empService;

    @Autowired
    private SessionService sessionService;

    @Autowired
    private DeptService deptService;

    @Autowired
    private CityService cityService;

    @Autowired
    private PermissionsService permissionsService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(
                dateFormat, true));
        binder.registerCustomEditor(int.class, "0",new CustomNumberEditor(Integer.class, false));
        binder.registerCustomEditor(long.class, "0",new CustomNumberEditor(Long.class, false));
    }

    @RequestMapping(name = "登录页面",value = "/index",method = RequestMethod.GET)
    public String login() throws PasswordErrorException, RemoteException, MobileNotExistException {
        return "/emp/login";
    }

    @ResponseBody
    @RequestMapping(name = "是否登录",value = "/isLogin",method = RequestMethod.POST)
    public Object isLogin() throws RemoteException {
        Template template = new Template();
        if (CurrentUser.get()!= null) {
            template.setMsg("已登录");
            return template;
        }
        template.setMsg("未登录");
        return template;
    }

    @ResponseBody
    @RequestMapping(name = "登录动作",value = "/login",method = RequestMethod.POST)
    public Object login(@RequestParam(value = "userName") String userName,@RequestParam(value = "password") String password, HttpSession session) throws PasswordErrorException, RemoteException, MobileNotExistException {
        EmpInfo empInfo = sessionService.keep(userName,password);
        session.setMaxInactiveInterval(ConstantField.SESSION_TIME_OUT);
        Template template = new Template();
        template.setMsg("登录成功");
        template.setData(empInfo);
        return template;
    }

    @ResponseBody
    @RequestMapping(name = "重置密码",value = "/resetPwd",method = RequestMethod.POST)
    public Object resetPwd(@RequestParam(value = "empId",defaultValue = "0") Long empId,
                           @RequestParam(value = "password") String password,
                           @RequestParam(value = "workStatus", defaultValue = "2")int workStatus) throws PasswordErrorException, RemoteException, MobileNotExistException {
        if (empId != 0) {
            empService.resetPwd(empId,password);
        }
        Template template = new Template();
        Map map = new HashMap();
        if (workStatus == 2) {
            map.put("url","/emp/list");
        } else {
            map.put("url","/emp/list?workStatus=0");
        }
        template.setData(map);
        return template;
    }

    @RequestMapping(name = "重置密码页面",value = "/resetPasswordPage",method = RequestMethod.GET)
    public ModelAndView resetPasswordPage(@RequestParam(value = "empId",defaultValue = "0") Long empId,
                                 @RequestParam(value = "workStatus", defaultValue = "2")int workStatus) throws RemoteException {
        Map map = new HashMap();
        map.put("empId",empId);
        map.put("workStatus",workStatus);
        return new ModelAndView("/emp/resetPassword","map",map);
    }

    @ResponseBody
    @RequestMapping(name = "修改密码",value = "/changePwd",method = RequestMethod.POST)
    public Object changePwd(@RequestParam(value = "password") String password,@RequestParam(value = "newPassword") String newPassword) throws PasswordErrorException, RemoteException, MobileNotExistException {
        empService.changePwd(CurrentUser.get().getId(),password,newPassword);
        Template template = new Template();
        template.setMsg("重置密码成功");
        Map map = new HashMap();
        map.put("url","/emp/changePasswordPage");
        template.setData(map);
        return template;
    }
    @RequestMapping(name = "修改密码页面",value = "/changePasswordPage",method = RequestMethod.GET)
    public ModelAndView changePasswordPage() throws RemoteException {
        return new ModelAndView("/emp/changePassword");
    }

    @RequestMapping(name = "退出登录",value = "/session/destroy",method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public String logout() {
        SecurityContextHolder.clearContext();
        return "/emp/login";
    }

    @RequestMapping(name = "员工列表页面",value = "/list",method = RequestMethod.GET)
    public Object emp(@RequestParam(value = "cityId",defaultValue = "0") Long cityId, @RequestParam(value = "departmentId",defaultValue = "0") Long departmentId,
                      @RequestParam(value = "positionId",defaultValue = "0") Long positionId, @RequestParam(value = "mobile",defaultValue = "") String mobile,
                      @RequestParam(value = "pageNo",defaultValue = "0") int pageNo, @RequestParam(value = "pageSize",defaultValue = "10")int pageSize,
                      @RequestParam(value = "workStatus", defaultValue = "2")int workStatus) throws RemoteException {
        PageNateDTO pageNateDTO = empService.getEmpList(cityId,departmentId,positionId,mobile,pageNo,pageSize,workStatus);
        PageNateDTO citys = cityService.getCityList(0,1000);
        PageNateDTO depts = deptService.getDeptList(0,100);
        Map map = new HashMap();
        map.put("citys",citys.getList());
        map.put("depts",depts.getList());
        map.put("page",pageNateDTO);
        if (workStatus == 2) {
            return new ModelAndView("/emp/listAll","map",map);
        } else {
            return new ModelAndView("/emp/list","map",map);
        }
    }

    @ResponseBody
    @RequestMapping(name = "设置员工离职",value = "/empQuit",method = RequestMethod.POST)
    public Template empQuit(@RequestParam(value = "empId")Long empId) throws RemoteException {
        Template template = new Template();
        empService.empQuit(empId);
        Map map = new HashMap();
        map.put("url","/emp/list");
        template.setData(map);
        return template;
    }

    @ResponseBody
    @RequestMapping(name = "删除员工",value = "/deleteEmp",method = RequestMethod.POST)
    public Template deleteEmp(@RequestParam(value = "empId",defaultValue = "0")Long empId) throws RemoteException {
        Template template = new Template();
        if (empId != 0) {
            empService.deleteEmp(empId);
        }
        Map map = new HashMap();
        map.put("url","/emp/list");
        template.setData(map);
        return template;
    }

    @RequestMapping(name = "员工新建更新页面",value = "/edit",method = RequestMethod.GET)
    public ModelAndView newPage(@RequestParam(value = "id",defaultValue = "0") Long id,
                                @RequestParam(value = "workStatus", defaultValue = "2")int workStatus,
                                @RequestParam(value = "from",defaultValue = "0")int from) throws RemoteException {
        PageNateDTO pageNateDTO = deptService.getDeptList(0,100);
        PageNateDTO p = cityService.getCityList(0,500);
        Map map = new HashMap();
        map.put("depList",pageNateDTO.getList());
        map.put("cityList",p.getList());
        map.put("workStatus", workStatus);
        if (id != 0) {
            map.put("emp",empService.getEmp(id));
        }
        if(from == 0) {
            return new ModelAndView("/emp/edit", "list", map);
        }else {
            return new ModelAndView("/emp/editEmp","list",map);
        }
    }

    @ResponseBody
    @RequestMapping(name = "员工新建更新动作",value = "/update",method = RequestMethod.POST)
    public Template newEmp(@ModelAttribute NewEmpCommand newEmpCommand, @RequestParam(value = "status", defaultValue = "2")int status) throws RemoteException, MobileExistException {
        EmpListDTO empListDTO = empService.newEmp(newEmpCommand);
        Map map = new HashMap();
        if (status == 2) {
            map.put("url","/emp/list");
        } else {
            map.put("url","/emp/list?workStatus=0");
        }
        Template template = new Template();
        template.setData(map);
        return template;
    }

    @RequestMapping(name = "更新员工角色页面",value = "/updateEmpGroup",method = RequestMethod.GET)
    public ModelAndView updateEmpGroup(@RequestParam(value = "empId") Long empId,
                                       @RequestParam(value = "workStatus", defaultValue = "2")int workStatus ) throws RemoteException {
        List<GroupDTO> groupDTOs = permissionsService.groups(empId);
        List<GroupDTO> allGroupDTOs = permissionsService.groups(0,100).getList();
        List<GroupDto> groupDtos = new ArrayList<>();
        for (GroupDTO groupDTO:allGroupDTOs) {
            GroupDto groupDto = new GroupDto();
            BeanUtils.copyProperties(groupDTO,groupDto);
            for (GroupDTO groupDTO1:groupDTOs) {
                if (groupDTO.getId().equals(groupDTO1.getId())) {
                    groupDto.setIsSelect(1);
                }
            }
            groupDtos.add(groupDto);
        }
        Map map = new HashMap();
        map.put("groups",groupDtos);
        EmpListDTO empListDTO = empService.getEmp(empId);
        map.put("realName", empListDTO.getRealName());
        map.put("username",empListDTO.getUsername());
        map.put("id",empListDTO.getId());
        map.put("workStatus",workStatus);
        return new ModelAndView("/emp/updateGroup","map",map);
    }

    @ResponseBody
    @RequestMapping(name = "更新员工角色",value = "/updateEmpGroup",method = RequestMethod.POST)
    public Template updateEmpGroup(@RequestParam(value = "empId") Long empId, @RequestParam(value = "groups")List<Long> groups,
                                   @RequestParam(value = "workStatus", defaultValue = "2")int workStatus) throws RemoteException {
        Template template = new Template();
        Map map = new HashMap();
        map.put("url","/emp/list");
        template.setData(map);
        permissionsService.updateUserGroup(empId,groups);
        return template;
    }

    @RequestMapping(name = "员工详情页面",value = "/detail",method = RequestMethod.GET)
    public ModelAndView newEmp(@RequestParam(value = "id") Long id, @RequestParam(value = "workStatus", defaultValue = "2")int workStatus,
                               @RequestParam(value = "from",defaultValue = "0")int frome) throws RemoteException {
        Map map = new HashMap();
        map.put("emp", empService.getEmp(id));
        map.put("workStatus", workStatus);
        if(frome==0) {
            return new ModelAndView("/emp/detail", "map", map);
        }else {
            return new ModelAndView("/emp/detailEmp","map",map);
        }
    }

    @ResponseBody
    @RequestMapping(value = "/getPositionList",method = RequestMethod.GET)
    public ModelAndView getPositionList(@RequestParam(value = "departmentId") Long departmentId) throws RemoteException {
        return new ModelAndView("/emp/positionListTpl","positionList",empService.getPositionList(departmentId,0,100).getList());
    }

    @RequestMapping(name = "职位列表页面", value = "/position/list", method = RequestMethod.GET)
    public ModelAndView list(@RequestParam(value = "pageNo",defaultValue = "0")Integer pageNo,
                             @RequestParam(value = "pageSize",defaultValue = "10")Integer pageSize) throws RemoteException{
        PageNateDTO pageNateDTO;
        pageNateDTO=this.empService.getEmpPositionList(pageNo,pageSize);
        return new ModelAndView("/position/list","page",pageNateDTO);
    }

    @RequestMapping(name="新增/更新职位", value = "/position/update", method = RequestMethod.POST)
    @ResponseBody
    public Object updateEmpPosition(@ModelAttribute EmpPositionDTO empPositionDTO,
                                    @RequestParam(name = "groupIds")List<Long> groupIds)throws RemoteException,PositionExistException{
        this.empService.saveEmpPosition(empPositionDTO, groupIds);
        Map map = new HashMap();
        Template template = new Template();
        map.put("url","/emp/position/list");
        template.setData(map);
        return template;
    }

    @RequestMapping(name = "新增/更新职位页面", value = "/position/edit", method = RequestMethod.GET)
    public ModelAndView updateEmpPositionPage(@RequestParam(value = "id", defaultValue = "0")Long id)throws RemoteException{
        ModelAndView mv = new ModelAndView("/position/edit");
        EmpPositionDTO empPositionDTO = new EmpPositionDTO();
        List<GroupDTO> groupDTOList = this.empService.getEmpGroupList();
        List<GroupDto> groupDToList = new ArrayList<>();
        List<Long> longList = new ArrayList<>();
        List<Long> groupIdList = this.empService.getGroupId(id);
        if(id != 0){
            empPositionDTO = this.empService.getPositonById(id);
            for(GroupDTO groupDTO : groupDTOList){
                GroupDto groupDto = new GroupDto();
                BeanUtils.copyProperties(groupDTO,groupDto);
                for (Long groupId : groupIdList){
                    if(groupDto.getId().equals(groupId)){
                        groupDto.setIsSelect(1);
                    }
                }
                groupDToList.add(groupDto);
            }
        }else {
            for(GroupDTO groupDTO : groupDTOList){
                GroupDto groupDto = new GroupDto();
                BeanUtils.copyProperties(groupDTO,groupDto);
                groupDToList.add(groupDto);
            }
        }
        List<EmpDepartmentDTO> empDepartmentDTOList = this.deptService.getEmpDepartmentListByName("%%");

        mv.addObject(groupDToList);
        mv.addObject(empPositionDTO);
        mv.addObject(empDepartmentDTOList);
        return mv;
    }

    @RequestMapping(name = "删除职位", value = "/position/delete", method = RequestMethod.POST)
    @ResponseBody
    public Object deleteEmpPosition(@RequestParam(value = "id") Long id) throws RemoteException {
        this.empService.deletePosition(id);
        Map map = new HashMap();
        Template template = new Template();
        map.put("url","/emp/position/list");
        template.setData(map);
        return template;
    }
}