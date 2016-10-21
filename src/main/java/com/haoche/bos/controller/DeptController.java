package com.haoche.bos.controller;

import com.haoche.bos.datamapper.Template;
import com.haoche.bos.service.DeptService;
import com.haoche.bos.service.EmpService;
import com.haoche.remoting.dto.EmpDepartmentDTO;
import com.haoche.remoting.dto.EmpListDTO;
import com.haoche.remoting.dto.PageNateDTO;
import com.haoche.remoting.exceptions.DepartmentNotExistException;
import org.springframework.beans.factory.annotation.Autowired;
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

@Controller
@RequestMapping("/dept")
public class DeptController {
    @Autowired
    private DeptService deptService;

    @Autowired
    private EmpService empService;

    /**
     * 访问部门主页
     * @return
     * @throws RemoteException
     */
    @RequestMapping(name = "部门列表",value = "/list",method = RequestMethod.GET)
    public ModelAndView deptMain(@RequestParam(value = "pageNo",defaultValue = "0")Integer pageNo,
                                 @RequestParam(value = "pageSize",defaultValue = "10")Integer pageSize) throws  RemoteException {
        PageNateDTO pageNateDTO = deptService.getDeptList(pageNo.intValue(), pageSize.intValue());
        return new ModelAndView("/department/list","page",pageNateDTO);
    }

    @RequestMapping(name = "部门详情页面",value = "/detail",method = RequestMethod.GET)
    public ModelAndView departmentDetail(@RequestParam(value = "departmentId")Long departmentId,
                                         @RequestParam(value = "pageNo",defaultValue = "0")Integer pageNo,
                                         @RequestParam(value = "pageSize",defaultValue = "10")Integer pageSize) throws RemoteException, DepartmentNotExistException {
        EmpDepartmentDTO empDepartmentDTO = deptService.getEmpDepartmentDTO(departmentId);
        PageNateDTO page = this.deptService.getEmpInDeptList(departmentId,pageNo,pageSize);
        Map<String,Object> map = new HashMap<>();
        map.put("department",empDepartmentDTO);
        map.put("page",page);
        return new ModelAndView("/department/detail","map",map);
    }

    @RequestMapping(name = "编辑修改部门页面",value = "/edit",method = RequestMethod.GET)
    public ModelAndView departmentEdit(@RequestParam(value = "departmentId", defaultValue = "0")Long departmentId) throws RemoteException, DepartmentNotExistException {
        Map map = new HashMap();
        List<EmpListDTO> list = this.deptService.getEmpListDTO();
        map.put("empList",list);
        if (departmentId != 0) {
            map.put("dept",deptService.getEmpDepartmentDTO(departmentId));
        }
        return new ModelAndView("/department/edit","map",map);
    }

    /**
     * 保存部门（添加，修改）
     * @param departmentId 部门ID
     * @param departmentName 部门名称
     * @param managerId 部门经理ID
     * @param managerName 部门经理名字
     * @return
     * @throws RemoteException
     * @throws DepartmentNotExistException
     */
    @ResponseBody
    @RequestMapping(value = "/update",method = RequestMethod.POST)
    public Template newDept(@RequestParam(value = "departmentId",defaultValue = "0") Long departmentId,
                                                 @RequestParam(value = "departmentName")String departmentName,
                                                 @RequestParam(value = "managerId")Long managerId,
                                                 @RequestParam(value = "managerName")String managerName) throws RemoteException, DepartmentNotExistException {
        Long dptId = this.deptService.save(departmentId == null ? 0 : departmentId.longValue(), departmentName, managerId, managerName);
        Map map = new HashMap();
        map.put("url","/dept/list");
        Template template = new Template();
        template.setData(map);
        return template;
    }

    /**
     * 删除部门
     * @param id 部门Id
     * @return
     * @throws RemoteException
     * @throws DepartmentNotExistException
     */
    @ResponseBody
    @RequestMapping(name = "删除部门",value = "/delete",method = RequestMethod.POST)
    public Template delete(@RequestParam(value="id")Long id) throws RemoteException, DepartmentNotExistException {
        this.deptService.delete(id);
        Template template = new Template();
        Map map = new HashMap();
        map.put("url","/dept/list");
        template.setData(map);
        return template;
    }
}