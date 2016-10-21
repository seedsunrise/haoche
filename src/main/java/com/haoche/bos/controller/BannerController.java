package com.haoche.bos.controller;

import com.haoche.bos.service.market.MarketAppBannerService;
import com.haoche.bos.util.Helper;
import com.haoche.remoting.dto.PageDTO;
import com.haoche.remoting.dto.PageNateDTO;
import com.haoche.remoting.dto.PageResultDTO;
import com.haoche.remoting.dto.capp.MarketAppBannerDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/system/banner")
public class BannerController {

    @Autowired
    private MarketAppBannerService bannerService;

    @Value("${platform.image.url}")
    private String imageUrl;

    @RequestMapping(name = "修改/新增banner页面", value = "/edit", method = RequestMethod.GET)
    public ModelAndView editBanner(@RequestParam(value = "id", defaultValue = "0")Long id) throws RemoteException{
        MarketAppBannerDTO marketAppBannerDTO = new MarketAppBannerDTO();
        if (id != 0) {
            marketAppBannerDTO = bannerService.getMarketAppBanner(id);
        }
        Map map = new HashMap();
        map.put("imageUrl",imageUrl);
        map.put("banner",marketAppBannerDTO);
        return new ModelAndView("/system/banner/edit","map",map);
    }

    @RequestMapping(name = "修改/新建banner", value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Object changeBanner(@RequestParam(value = "bannerType")int bannerType,
                               @RequestParam(value = "clickType")int clickType,
                               @RequestParam(value = "clickUrl")String clickUrl,
                               @RequestParam(value = "sortIndex",defaultValue = "0")int sortIndex,
                               @RequestParam(value = "bannerPic")String bannerPic) throws RemoteException{
        MarketAppBannerDTO newBanner = new MarketAppBannerDTO();
        newBanner.setBannerType(bannerType);
        newBanner.setClickType(clickType);
        newBanner.setClickUrl(clickUrl);
        newBanner.setSortIndex(sortIndex);
        newBanner.setBannerPic(bannerPic);
        bannerService.save(newBanner);
        return Helper.GetTemplateWithMap("url", "/system/banner/list");
    }

    @RequestMapping(name = "banner列表", value = "/list", method = RequestMethod.GET)
    public ModelAndView list(@RequestParam(value = "pageNo", required = false, defaultValue = "0") int page,
                       @RequestParam(value = "size", required = false, defaultValue = "10") int size,
                       @RequestParam(value = "type", required = false, defaultValue = "0") int type) throws RemoteException{
        PageNateDTO pageList = bannerService.list(page, size);
        PageDTO pageDTO = new PageDTO();
        pageDTO.setSize(size);
        pageDTO.setNumber(page+1);
        pageDTO.setTotalElements((int) pageList.getCount());
        pageDTO.setTotalPages((int) pageList.getCount() % size == 0 ? (int) pageList.getCount() / size : (int) pageList.getCount() / size + 1);
        //return new PageResultDTO(pageList.getList(), 0, pageDTO, true);
        PageResultDTO pageResultDTO = new PageResultDTO(pageList.getList(),0,pageDTO,true);
        Map resultMap = new HashMap();
        resultMap.put("page",pageList);
        return new ModelAndView("/system/banner/list","map",resultMap);
    }

    @RequestMapping(name = "删除banner", value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Object deleteBanner(@RequestParam(value = "id") Long id) throws RemoteException{
        bannerService.delete(id);
        return Helper.GetTemplateWithMap("url", "/system/banner/list");
    }
}