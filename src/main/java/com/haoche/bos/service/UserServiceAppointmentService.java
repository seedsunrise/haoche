package com.haoche.bos.service;

import com.haoche.carmaintain.remoting.dto.PageNateDTO;
import com.haoche.carmaintain.remoting.dto.UserServiceAppointmentDTO;
import com.haoche.carmaintain.remoting.stub.UserServiceAppointmentInterface;
import com.haoche.carowner.remoting.dto.CarOwnerDTO;
import com.haoche.carowner.remoting.stub.CarOwnerInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;
import java.util.List;
import java.util.Map;

/**
 * Created by tiger on 2016/8/3.
 */
@Service("userServiceAppointmentService")
public class UserServiceAppointmentService {

    @Autowired
    private UserServiceAppointmentInterface userServiceAppointmentInterface;
    @Autowired
    private CarOwnerInterface carOwnerInterface;
    public void delete(Long id) throws RemoteException{
        this.userServiceAppointmentInterface.delete(id);
    }

    public UserServiceAppointmentDTO findById(Long id) throws RemoteException {
        return this.userServiceAppointmentInterface.findById(id);
    }

    public void checkAppointment(UserServiceAppointmentDTO userServiceAppointmentDTO) throws RemoteException {
        this.userServiceAppointmentInterface.checkOrStartAppoint(userServiceAppointmentDTO);
    }

    public void finalCheck(UserServiceAppointmentDTO userServiceAppointmentDTO) throws RemoteException {
        this.userServiceAppointmentInterface.finalCheck(userServiceAppointmentDTO);
    }

    public PageNateDTO getUserServiceAppointmentList(final Map<String, Object> mapParameter, final String search, final String sort, final String sc, int pageNo, int pageSize,int type) throws RemoteException {
        return this.userServiceAppointmentInterface.getUserServiceAppointmentList(mapParameter,search,sort,sc,pageNo,pageSize,type);
    }

    public UserServiceAppointmentDTO newAppointment(UserServiceAppointmentDTO userServiceAppointmentDTO) throws RemoteException {
        return userServiceAppointmentInterface.newAppointment(userServiceAppointmentDTO);
    }



    public UserServiceAppointmentDTO resetAppointStatus(Long appointId, int appointmentStatus, int mark) throws RemoteException {
        return userServiceAppointmentInterface.resetAppointStatus(appointId, appointmentStatus, mark);
    }

    public void initLisenceNum() throws RemoteException {
       List<UserServiceAppointmentDTO > appointmentDTOs=userServiceAppointmentInterface.getAppoints();
        for(UserServiceAppointmentDTO appointmentDTO:appointmentDTOs){
            CarOwnerDTO carOwnerDTO=carOwnerInterface.get(appointmentDTO.getUserId());
            if(carOwnerDTO!=null&&carOwnerDTO.getCarInfos()!=null &&carOwnerDTO.getCarInfos().size()>0 &&carOwnerDTO.getCarInfos().get(0)!=null){
                appointmentDTO.setLicenseNum(carOwnerDTO.getCarInfos().get(0).getLicenseNum());
            }
            userServiceAppointmentInterface.saveAppoint(appointmentDTO);
        }
    }

}
