package com.haoche.bos.service;

import com.haoche.remoting.dto.*;
import org.springframework.stereotype.Service;

import com.haoche.bos.config.security.EmpInfo;
import com.haoche.bos.factory.RmiFactory;
import com.haoche.bos.controller.command.NewEmpCommand;
import com.haoche.remoting.exceptions.MobileExistException;
import com.haoche.remoting.exceptions.MobileNotExistException;
import com.haoche.remoting.exceptions.PasswordErrorException;
import com.haoche.remoting.exceptions.PositionExistException;
import com.haoche.remoting.stub.EmpInterface;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;
import java.util.List;

@Service("empService")
public class EmpService {

    @Autowired
    private EmpInterface empInterface;

    public EmpListDTO login(String mobile, String password) throws PasswordErrorException, RemoteException, MobileNotExistException {
        return empInterface.login(mobile, password);
    }

    public PageNateDTO getEmpList(Long cityId, Long departmentId, Long positionId, String mobile, int pageNo, int pageSize,int workStatus) throws RemoteException {
        return empInterface.getEmpList(cityId,departmentId,positionId,mobile,pageNo,pageSize,workStatus);
    }

    public void empQuit(Long empId) throws RemoteException {
        empInterface.empQuit(empId);
    }

    public EmpListDTO newEmp(NewEmpCommand newEmpCommand) throws RemoteException, MobileExistException {
        NewEmpStaffDTO newEmp = new NewEmpStaffDTO();
        BeanUtils.copyProperties(newEmpCommand,newEmp);
        return empInterface.newEmp(newEmp);
    }

    public EmpListDTO getEmp(Long id) throws RemoteException {
        return empInterface.getEmp(id);
    }

    public PageNateDTO getPositionList(Long id,int pageNo,int pageSize) throws RemoteException {
        return empInterface.getPositionListByDept(id,pageNo,pageSize);
    }

    public PageNateDTO getEmpPositionList(int pageNo, int pageSize) throws RemoteException{
        return empInterface.getEmpPositionList(pageNo, pageSize);
    }

    public void saveEmpPosition(EmpPositionDTO empPositionDTO, List<Long> groupIds) throws RemoteException,PositionExistException{
        this.empInterface.save(empPositionDTO, groupIds);
    }

    public EmpPositionDTO getPositonById(Long id) throws RemoteException {
        return this.empInterface.getPositionById(id);
    }

    public void deletePosition(Long id) throws RemoteException {
        this.empInterface.deletePosition(id);
    }

    public List<GroupDTO> getEmpGroupList() throws RemoteException {
        return this.empInterface.getEmpGroupList();
    }

    public  List<Long> getGroupId(Long positionId) throws RemoteException {
        return this.empInterface.getGroupId(positionId);
    }

    public void resetPwd(Long empId, String password) throws RemoteException {
        empInterface.resetPwd(empId,password);
    }

    public void changePwd(Long empId,String password,String newPassword) throws RemoteException,PasswordErrorException {
        empInterface.changePwd(empId,password,newPassword);
    }

    public void savePositionGroup(Long positionId, List<Long> longList) throws RemoteException {
        empInterface.savePositionGroup(positionId, longList);
    }

    public void newPositionGroup(Long positionId, List<Long> groupIds) throws RemoteException {
    }

    public void deleteEmp(Long empId) throws RemoteException {
        empInterface.delete(empId);
    }
}
