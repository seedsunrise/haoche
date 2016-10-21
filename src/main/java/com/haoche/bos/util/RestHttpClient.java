package com.haoche.bos.util;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.client.RestTemplate;

import java.net.URI;
import java.net.URISyntaxException;

public class RestHttpClient {

    private static Logger logger = LoggerFactory.getLogger(RestHttpClient.class);

    private static RestTemplate restTemplate = new RestTemplate();

    public static <T> T getForObject(String url, Class<T> responseType) throws URISyntaxException {
        logger.debug("request to platform:\n url=" + url);
        T responseEntity = (T) restTemplate.getForObject(url, responseType);
        logger.debug("response from platform:\n body=[" + responseEntity.toString() + "]");
        return responseEntity;
    }

    public static <T> T post(String url, Object request, Class<T> responseType) throws URISyntaxException {
        logger.debug("request to platform:\n url=" + url + "\nbody=[" + request.toString() + "]");
        T responseEntity = restTemplate.postForObject(new URI(url), request, responseType);
        logger.debug("response from platform:\n body=[" + responseEntity.toString() + "]");
        return responseEntity;
    }
}

