package com.haoche.bos.service;


import com.basedata.remoting.dto.CarLineDTO;
import com.basedata.remoting.dto.PageNateDTO;
import com.basedata.remoting.exceptions.CarLineExistException;
import com.basedata.remoting.exceptions.CarLineNotExistException;
import com.basedata.remoting.stub.CarLineInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;
import java.util.List;

/**
 * Created by tiger on 2016/5/10.
 */
@Service("carLineService")
public class CarLineService {

    @Autowired
    private CarLineInterface carLineInterface;

    public void save(CarLineDTO carLineDTO) throws RemoteException, CarLineExistException {
        carLineInterface.save(carLineDTO);
    }

    public CarLineDTO getCarLineById(Long carLineId) throws RemoteException, CarLineNotExistException {
        return carLineInterface.getCarLineById(carLineId);
    }

    public PageNateDTO getCarLineList(int pageNo, int pageSize) throws RemoteException {
        return carLineInterface.getCarLineList(pageNo, pageSize);
    }

    public List<CarLineDTO> getCarLineListByName(String lineName) throws RemoteException {
        return carLineInterface.getCarLineListByName(lineName);
    }

    public PageNateDTO getCarLineListByName(String lineName, int pageNo, int pageSize) throws RemoteException {
        return carLineInterface.getCarLineListByName(lineName, pageNo, pageSize);
    }

    public List<CarLineDTO> getCarLineListByCarSubBrandId(Long subBrandId) throws RemoteException {
        return carLineInterface.getCarLineListByCarSubBrandId(subBrandId);
    }

    public void delete(Long id) throws RemoteException {
        carLineInterface.delete(id);
    }
}
