package com.haoche.bos.service.market;

import com.haoche.remoting.dto.PageNateDTO;
import com.haoche.remoting.dto.capp.MarketAppBannerDTO;
import com.haoche.remoting.stub.capp.MarketAppBannerInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;

/**
 * APP广告
 * Created by allan on 2016/8/23.
 */
@Service("marketAppBannerService")
public class MarketAppBannerService {
    @Autowired
    private MarketAppBannerInterface marketAppBannerInterface;

    public MarketAppBannerDTO getMarketAppBanner(Long id) throws RemoteException {
        if(id == null || id <= 0L){
            return null;
        }
        return this.marketAppBannerInterface.getMarketAppBanner(id);
    }

    public MarketAppBannerDTO save(MarketAppBannerDTO marketAppBannerDTO) throws RemoteException {
        if(marketAppBannerDTO == null){
            return null;
        }
        if(marketAppBannerDTO.getId() == null){
            return this.marketAppBannerInterface.save(marketAppBannerDTO);
        }else{
            MarketAppBannerDTO dto = this.marketAppBannerInterface.getMarketAppBanner(marketAppBannerDTO.getId());
            dto.setBannerPic(marketAppBannerDTO.getBannerPic());
            dto.setClickType(marketAppBannerDTO.getClickType());
            dto.setBannerType(marketAppBannerDTO.getBannerType());
            dto.setClickUrl(marketAppBannerDTO.getClickUrl());
            dto.setSortIndex(marketAppBannerDTO.getSortIndex());
            dto.setProject(marketAppBannerDTO.getProject());
            return this.marketAppBannerInterface.save(dto);
        }
    }

    public boolean delete(Long id) throws RemoteException {
        if(id == null || id <= 0L){
            return false;
        }
        return this.marketAppBannerInterface.delete(id);
    }

    public PageNateDTO list(int pageNo, int pageSize) throws RemoteException {
        List<Integer> list = new ArrayList<>();
        list.add(0);
        return this.marketAppBannerInterface.list(list,pageNo,pageSize);
    }
}
