package com.haoche.bos.controller.market;

import com.haoche.bos.service.market.MarketAppBannerService;
import com.haoche.remoting.dto.capp.MarketAppBannerDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.rmi.RemoteException;

/**
 * APP广告
 * Created by allan on 2016/8/23.
 */
public class MarketAppBannerController {
    @Autowired
    private MarketAppBannerService marketAppBannerService;


    public ModelAndView savePage(Long id) throws RemoteException {
        MarketAppBannerDTO marketAppBannerDTO = this.marketAppBannerService.getMarketAppBanner(id);
        return new ModelAndView("/","banner",marketAppBannerDTO);
    }
}
