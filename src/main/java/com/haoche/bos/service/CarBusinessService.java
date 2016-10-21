package com.haoche.bos.service;

import com.haoche.remoting.dto.CarBusinessDTO;
import com.haoche.remoting.dto.PageNateDTO;
import com.haoche.remoting.stub.CarBusinessInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;

@Service("carBusinessService")
public class CarBusinessService {

    @Autowired
    private CarBusinessInterface carBusinessInterface;

    public PageNateDTO list(int pageNo, int pageSize, String cityName) throws RemoteException {
        return carBusinessInterface.list(pageNo, pageSize, cityName);
    }

    public CarBusinessDTO findOne(Long id) throws RemoteException {
        return carBusinessInterface.findOne(id);
    }

    public void update(CarBusinessDTO carBusinessDTO) throws RemoteException {
        carBusinessInterface.update(carBusinessDTO);
    }

    public void delete(Long id) throws RemoteException {
        carBusinessInterface.delete(id);
    }

    public void changeStatus(Long id, int isOpened) throws RemoteException {
        carBusinessInterface.changeOpened(id,isOpened);
    }
}
