package com.haoche.bos.service;

import com.haoche.remoting.dto.CarLoanInfoDTO;
import com.haoche.remoting.dto.capp.CarLoanChannelDTO;
import com.haoche.remoting.dto.capp.CarLoanChannelRateDTO;
import com.haoche.remoting.stub.CarLoanInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;
import java.util.List;

/**
 * CarLoanService
 *
 * @author Chen fei
 * @date 2016/8/16
 */
@Service("carLoanService")
public class CarLoanService {

    @Autowired
    private CarLoanInterface carLoanInterface;

    public List<CarLoanInfoDTO> findCarLoan() throws RemoteException{
        return carLoanInterface.findCarLoan();
    }

    public List<CarLoanChannelDTO> findAllCarLoan() throws RemoteException{

        return carLoanInterface.findAllCarLoanChannel();
    }

    public CarLoanChannelRateDTO findCarLoanChannelRate(Long channelId, int downPayment, int periodNumber) throws RemoteException{
        return carLoanInterface.findCarLoanChannelRate(channelId,downPayment,periodNumber);
    }
}
