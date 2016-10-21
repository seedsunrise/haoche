package com.haoche.bos.service;

import com.haoche.remoting.dto.EmpDepartmentDTO;
import com.haoche.remoting.dto.EmpListDTO;
import com.haoche.remoting.dto.PageNateDTO;
import com.haoche.remoting.exceptions.DepartmentNotExistException;
import com.haoche.remoting.stub.DeptInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;
import java.util.List;

@Service("deptService")
public class DeptService {
    @Autowired
    private DeptInterface deptInterface;

    /**
     * 获取部门列表
     * @param pageNo
     * @param pageSize
     * @return
     * @throws RemoteException
     */
    public PageNateDTO getDeptList(int pageNo, int pageSize) throws RemoteException {
        return this.deptInterface.getDeptList(pageNo, pageSize);
    }

    /**
     * 获取部门下的员工列表
     * @param departmentId 部门id
     * @return
     * @throws RemoteException
     */
    public PageNateDTO getEmpInDeptList(Long departmentId, int pageNo, int pageSize) throws RemoteException {
        return this.deptInterface.getEmpInDeptList(departmentId, pageNo, pageSize);
    }

    /**
     * 获取部门信息
     * @param departmentId 部门id
     * @return
     * @throws RemoteException
     * @throws DepartmentNotExistException
     */
    public EmpDepartmentDTO getEmpDepartmentDTO(Long departmentId) throws RemoteException, DepartmentNotExistException {
        return this.deptInterface.getEmpDepartmentDTO(departmentId);
    }

    public Long save(Long departmentId, String departmentName, Long managerId, String managerName) throws RemoteException, DepartmentNotExistException {
        return this.deptInterface.save(departmentId, departmentName, managerId, managerName);
    }

    public void delete(Long departmentId) throws RemoteException, DepartmentNotExistException {
        this.deptInterface.delete(departmentId);
    }

    /**
     * 获取所有在职员工
     * @return
     * @throws RemoteException
     */
    public List<EmpListDTO> getEmpListDTO() throws RemoteException {
        return this.deptInterface.getEmpListDTO();
    }

    /**
     * 获取部门列表
     * @param departmentName
     * @throws RemoteException
     * @return
     * */
    public List<EmpDepartmentDTO> getEmpDepartmentListByName(String departmentName) throws RemoteException {
        return this.deptInterface.getEmpDepartmentListByName(departmentName);
    }
}
