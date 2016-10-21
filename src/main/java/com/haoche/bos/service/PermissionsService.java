package com.haoche.bos.service;


import com.haoche.bos.util.CurrentUser;
import com.haoche.remoting.dto.ActionDTO;
import com.haoche.remoting.dto.GroupDTO;
import com.haoche.remoting.dto.PageNateDTO;
import com.haoche.remoting.stub.PermissionsInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;

@Service("permissionsService")
public class PermissionsService {

    @Autowired
    private PermissionsInterface permissionsInterface;

    public PageNateDTO actions(String searchStr,int pageNo,int pageSize) throws RemoteException {
        PageNateDTO pageNateDTO = permissionsInterface.actions(searchStr, pageNo, pageSize);
        return pageNateDTO;
    }

    public PageNateDTO groups(int pageNo, int pageSize) throws RemoteException {
        PageNateDTO pageNateDTO = permissionsInterface.groups(pageNo,pageSize);
        return pageNateDTO;
    }

    public GroupDTO getOneGroup(Long groupId) throws RemoteException {
        GroupDTO groupDTO= permissionsInterface.getOneGroup(groupId);
        return groupDTO;
    }

    public void deleteGrou(Long groupId) throws RemoteException {
        permissionsInterface.deleteGroup(groupId);
    }

    public void updateGroups(Long id,String groupName, String groupDesc, List<String> actions) throws RemoteException {
        GroupDTO groupDTO = new GroupDTO();
        groupDTO.setId(id);
        groupDTO.setCreator(CurrentUser.get().getRealName());
        groupDTO.setCreatorId(CurrentUser.get().getId());
        groupDTO.setGroupName(groupName);
        groupDTO.setGroupDes(groupDesc);
        List<Long> action = new ArrayList<>();
        for (String a:actions) {
            Long ac = Long.valueOf(a);
            action.add(ac);
        }
        groupDTO.setActions(action);
        permissionsInterface.updateGroup(groupDTO);
    }

    public void updateUserGroup(Long empId,List<Long> groups) throws RemoteException {
        permissionsInterface.updateUserGroup(empId,groups);
    }

    public List<ActionDTO> actions(Long id) throws RemoteException {
        List<ActionDTO> list = permissionsInterface.actions(id);
        return list;
    }

    public List<ActionDTO> empActions(Long id) throws RemoteException {
        List<ActionDTO> list = permissionsInterface.empGroups(id);
        return list;
    }

    public List<GroupDTO> groups(Long empId) throws RemoteException {
        return permissionsInterface.groups(empId);
    }
}
