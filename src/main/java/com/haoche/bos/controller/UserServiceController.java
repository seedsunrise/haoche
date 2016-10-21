package com.haoche.bos.controller;

import com.haoche.bos.datamapper.Template;
import com.haoche.bos.service.ShopService;
import com.haoche.bos.service.UserServiceAppointmentService;
import com.haoche.bos.service.UserServiceProjectService;
import com.haoche.bos.util.Helper;
import com.haoche.bos.util.JsonUtil;
import com.haoche.carmaintain.remoting.dto.PageNateDTO;
import com.haoche.carmaintain.remoting.dto.UserServiceAppointmentDTO;
import com.haoche.carmaintain.remoting.dto.UserServiceProjectDTO;
import com.haoche.userauth.remoting.dto.UserInfoDTO;
import com.haoche.userauth.remoting.stub.UserInfoInterface;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.rmi.RemoteException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/userservice")
public class UserServiceController {

    @Autowired
    private UserServiceProjectService userServiceProjectService;
    @Autowired
    private UserServiceAppointmentService userServiceAppointmentService;
    @Autowired
    private UserInfoInterface userInfoInterface;
    @Autowired
    private ShopService shopService;

    @Value("${platform.image.url}")
    private String imageUrl;

    @RequestMapping(name = "新增预约页面", value = "/appointment/save", method = RequestMethod.GET)
    @ResponseBody
    public Object save(Long userId) throws RemoteException {
        Template template = new Template();
        Map map = new HashMap();
        UserInfoDTO userInfo = userInfoInterface.getUserInfo(userId);
        List<UserServiceProjectDTO> projects = userServiceProjectService.getAll(0);
        map.put("userInfo", userInfo);
        map.put("projects", projects);
        template.setData(map);
        return template;
    }

    @RequestMapping(name = "新增预约动作", value = "/appointment/update", method = RequestMethod.POST)
    @ResponseBody
    public Object update(@ModelAttribute UserServiceAppointmentDTO userServiceAppointmentDTO,
                         @RequestParam(value = "time") String time,
                         @RequestParam(value = "projectIds") String projectIds) throws IOException, ParseException {
        DateFormat format = new SimpleDateFormat("yyyy年MM月dd日 HH:mm");
        List list = (List) JsonUtil.jsonToBean(projectIds, List.class);
        List<UserServiceProjectDTO> projectList = new ArrayList<>();
        for (Object i : list) {
            projectList.add(userServiceProjectService.getById(Long.valueOf(i.toString())));
        }
        userServiceAppointmentDTO.setProjectDTOList(projectList);
        userServiceAppointmentDTO.setAppointmentTime(format.parse(time));
        UserServiceAppointmentDTO appointment = userServiceAppointmentService.newAppointment(userServiceAppointmentDTO);
        Template template = new Template();
        Map map = new HashMap();
        map.put("appointment", appointment);
        template.setMsg("预约成功");
        template.setData(map);
        return template;
    }


    @RequestMapping(name = "服务预约项目列表", value = "/project/list", method = RequestMethod.GET)
    public ModelAndView list(@RequestParam(value = "pageNo", defaultValue = "0") int pageNo,
                             @RequestParam(value = "pageSize", defaultValue = "10") int pageSize) throws RemoteException {
        PageNateDTO pageNateDTO =new PageNateDTO();
        Map map = new HashMap();
        pageNateDTO = this.userServiceProjectService.getUserServiceProjectList(pageNo,pageSize,0);
        map.put("page", pageNateDTO);
        return new ModelAndView("/user/userService/project/list", "map", map);
    }

    @RequestMapping(name = "新增编辑/服务预约项目页面", value = "/project/edit", method = RequestMethod.GET)
    public ModelAndView projectPage(@RequestParam (value = "id",defaultValue = "0") Long id) throws RemoteException{
        UserServiceProjectDTO userServiceProjectDTO = new UserServiceProjectDTO();
        if (id != 0) {
            userServiceProjectDTO = this.userServiceProjectService.getById(id);
        }
        Map map = new HashMap();
        map.put("userServiceProject",userServiceProjectDTO);
        return new ModelAndView("/user/userService/project/edit","map",map);
    }

    @RequestMapping(name="新增更新/服务预约项目动作", value = "/project/update", method = RequestMethod.POST)
    @ResponseBody
    public Object update(@ModelAttribute UserServiceProjectDTO userServiceProjectDTO) throws RemoteException{
        this.userServiceProjectService.save(userServiceProjectDTO);
        return Helper.GetTemplateWithMap("url", "/userservice/project/list");
    }

    @RequestMapping(name="删除服务预约项目", value = "/project/delete", method = RequestMethod.POST)
    @ResponseBody
    public Object deleteProject(@RequestParam (value = "id")Long id) throws RemoteException {
        this.userServiceProjectService.delete(id);
        return Helper.GetTemplateWithMap("url", "/userservice/project/list");
    }

    @RequestMapping(name = "服务预约项目查询", value = "/appointment/list", method = RequestMethod.GET)
    public ModelAndView list(String appointmentDateStart,
                             String appointmentDateEnd,
                             String pickUpTime,
                             String search,
                             String status,
                             String sort,
                             String sc,
                             @RequestParam(value = "pageNo", defaultValue = "0") int pageNo,
                             @RequestParam(value = "pageSize", defaultValue = "10") int pageSize) throws RemoteException, ParseException {
        PageNateDTO pageNateDTO =new PageNateDTO();
        StringBuilder param = new StringBuilder("status="+status);
        Map<String,Object> mapParameter = new HashMap<>();
        DateFormat format = new SimpleDateFormat("yyyy年MM月dd日");
        Map map = new HashMap();
        if(StringUtils.isNotBlank(status)){
            mapParameter.put("status",status);
            map.put("status",status);
            param.append("&status="+status);
        }

        if(StringUtils.isNotBlank(search)){
            map.put("search",search);
            param.append("&search="+search);
        }

        if(StringUtils.isNotBlank(pickUpTime)){
            mapParameter.put("pickUpTime",format.parse(pickUpTime));
            map.put("pickUpTime",pickUpTime);
            param.append("&pickUpTime="+pickUpTime);
        }
        if(StringUtils.isNotBlank(appointmentDateStart) && !StringUtils.equals(appointmentDateStart.trim(),"预约时间开始")){
            mapParameter.put("appointmentDateStart",format.parse(appointmentDateStart));
            map.put("appointmentDateStart",appointmentDateStart);
            param.append("&appointmentDateStart="+appointmentDateStart);
        }

        if(StringUtils.isNotBlank(appointmentDateEnd) && !StringUtils.equals(appointmentDateEnd.trim(),"预约时间结束")){
            mapParameter.put("appointmentDateEnd",format.parse(appointmentDateEnd));
            map.put("appointmentDateEnd",appointmentDateEnd);
            param.append("&appointmentDateEnd="+appointmentDateEnd);
        }

        if(StringUtils.isNotBlank(sort)){
            map.put("sort",sort);
            param.append("&sort="+sort);
        }
        if(StringUtils.isNotBlank(sc)){
            map.put("sc",sc);
        }
        pageNateDTO = userServiceAppointmentService.getUserServiceAppointmentList(mapParameter,search,sort,sc,pageNo,pageSize,0);
        map.put("page", pageNateDTO);
        return new ModelAndView("/user/userService/appointment/list", "map", map);
    }

    @RequestMapping(name = "审核预约页面/完结预约页面/查看详情", value = "/appointment/edit", method = RequestMethod.GET)
    public ModelAndView appointmentPage(@RequestParam(value = "id",defaultValue = "0") Long id) throws RemoteException {
        UserServiceAppointmentDTO userServiceAppointmentDTO = new UserServiceAppointmentDTO();
        if(id != 0){
            userServiceAppointmentDTO = this.userServiceAppointmentService.findById(id);
        }
        Map map = new HashMap();
        map.put("imageUrl",imageUrl);
        map.put("userServiceAppointment",userServiceAppointmentDTO);
        return new ModelAndView("/userService/appointment/details", "map", map);
    }

    @RequestMapping(name = "获取审核信息", value = "/appointment/getAppointmentInfo", method = RequestMethod.GET)
    @ResponseBody
    public ModelAndView getAppointmentInfo(@RequestParam(value = "id") Long id, @RequestParam(value = "type") int type) throws RemoteException {
        UserServiceAppointmentDTO userServiceAppointmentDTO = this.userServiceAppointmentService.findById(id);
        Map map = new HashMap();
        map.put("imageUrl",imageUrl);
        map.put("appointment",userServiceAppointmentDTO);
        if (type == 0) {
            return new ModelAndView("/user/userService/appointment/reviewInfoTpl", "appointment", userServiceAppointmentDTO);
        } else if (type == 1) {
            return new ModelAndView("/user/userService/appointment/overReviewInfoTpl", "appointment", userServiceAppointmentDTO);
        } else {
            return new ModelAndView("/user/userService/appointment/reviewInfoDetailTpl", "map", map);
        }
    }

    @RequestMapping(name = "审核预约动作", value = "/appointment/check", method = RequestMethod.POST)
    @ResponseBody
    public Template checkAppointment(@ModelAttribute UserServiceAppointmentDTO userServiceAppointmentDTO,
                                     @RequestParam("time") String time,
                                     @RequestParam("projectList") String projectList) throws IOException, ParseException {
        List list = (List) JsonUtil.jsonToBean(projectList,List.class);
        List<UserServiceProjectDTO> projectDTOList = new ArrayList<>();
        for(Object i: list){
            UserServiceProjectDTO u = new UserServiceProjectDTO();
            u.setId(Long.valueOf(i.toString()));
            projectDTOList.add(u);
        }
        DateFormat format = new SimpleDateFormat("yyyy年MM月dd");
        userServiceAppointmentDTO.setAppointmentTime(format.parse(time));
        userServiceAppointmentDTO.setProjectDTOList(projectDTOList);
        this.userServiceAppointmentService.checkAppointment(userServiceAppointmentDTO);
        Template template = new Template();
        Map map = new HashMap();
        map.put("url","/userservice/appointment/list");
        template.setData(map);
        return template;
    }

    @RequestMapping(name = "完结预约动作", value = "/appointment/finalcheck", method = RequestMethod.POST)
    @ResponseBody
    public Template finalCheck(@ModelAttribute UserServiceAppointmentDTO userServiceAppointmentDTO) throws RemoteException{

        List<UserServiceProjectDTO> list = new ArrayList<>();
        for(UserServiceProjectDTO u:userServiceAppointmentDTO.getProjectDTOList()){
            if(u.getId() != null){
                u.setAppointmentId(userServiceAppointmentDTO.getId());
                list.add(u);
            }
        }
        userServiceAppointmentDTO.setProjectDTOList(list);
        this.userServiceAppointmentService.finalCheck(userServiceAppointmentDTO);

        Map map = new HashMap();
        map.put("url","/userservice/appointment/list");
        Template template =new Template();
        template.setData(map);
        return template;
    }


    @RequestMapping(name = "开始服务", value = "/appointment/startService", method = RequestMethod.POST)
    @ResponseBody
    public Template startService(@RequestParam(value = "id")Long id) throws RemoteException {
        this.userServiceAppointmentService.resetAppointStatus(id,2,1);
        return Helper.GetTemplateWithMap("url", "/userservice/appointment/list");
    }

    @RequestMapping(name = "删除预约动作", value = "/appointment/delete", method = RequestMethod.POST)
    @ResponseBody
    public Template deleteAppointment(@RequestParam(value = "id")Long id) throws RemoteException {
        this.userServiceAppointmentService.delete(id);
        return Helper.GetTemplateWithMap("url", "/userservice/appointment/list");
    }


    @RequestMapping(name = "初始化车牌号", value = "/appointment/initLisenceNum", method = RequestMethod.GET)
    @ResponseBody
    public Template initLisenceNum() throws RemoteException {
        this.userServiceAppointmentService.initLisenceNum();
        return Helper.GetTemplateWithMap("url", "/userservice/appointment/list");
    }
}