package com.haoche.bos.service;

import com.haoche.remoting.dto.PageNateDTO;
import com.haoche.remoting.dto.ShopDTO;
import com.haoche.remoting.stub.ShopInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;

/**
 * 门店服务
 * Created by allan on 2016/5/6.
 */
@Service("shopService")
public class ShopService {

    @Autowired
    private ShopInterface shopInterface;

    public void save(ShopDTO shopDTO) throws RemoteException {
        this.shopInterface.save(shopDTO);
    }

    public ShopDTO getShopById(Long shopId) throws RemoteException {
        return this.shopInterface.getShopById(shopId);
    }

    public PageNateDTO getShopList(int pageNo, int pageSize) throws RemoteException {
        return this.shopInterface.getShopList(pageNo,pageSize);
    }

    public PageNateDTO getShopListByCityName(String cityName, int pageNO, int pageSize) throws RemoteException {
        return this.shopInterface.getShopListByCityName(cityName,pageNO,pageSize);
    }

    public void delete(Long id) throws RemoteException {
        shopInterface.delete(id);
    }
}
