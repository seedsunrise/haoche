package com.haoche.bos.handler;

import com.haoche.bos.config.ActionType;
import com.haoche.remoting.dto.ActionDTO;
import com.haoche.remoting.stub.PermissionsInterface;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.BeanFactoryUtils;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.mvc.condition.PatternsRequestCondition;
import org.springframework.web.servlet.mvc.condition.RequestMethodsRequestCondition;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@Component
public class AuthenticationInitHandler extends ApplicationObjectSupport implements InitializingBean {

	private final static Logger logger = LoggerFactory.getLogger(AuthenticationInitHandler.class);

    @Autowired
    private PermissionsInterface permissionsInterface;

	public void getAnnotionRequestUrl() throws RemoteException {

		Map<String, HandlerMapping> allRequestMappings = BeanFactoryUtils.beansOfTypeIncludingAncestors(getApplicationContext(),HandlerMapping.class, true, false);

		List<ActionDTO> actions = new ArrayList<ActionDTO>();

		for (HandlerMapping handlerMapping : allRequestMappings.values())  {

			if (handlerMapping instanceof RequestMappingHandlerMapping) {

				RequestMappingHandlerMapping requestMappingHandlerMapping = (RequestMappingHandlerMapping) handlerMapping;
				Map<RequestMappingInfo, HandlerMethod> handlerMethods = requestMappingHandlerMapping.getHandlerMethods();

				for (Map.Entry<RequestMappingInfo, HandlerMethod> requestMappingInfoHandlerMethodEntry : handlerMethods.entrySet()){

					RequestMappingInfo requestMappingInfo = requestMappingInfoHandlerMethodEntry.getKey();
					RequestMethodsRequestCondition methodCondition = requestMappingInfo.getMethodsCondition();
                    PatternsRequestCondition patternsCondition = requestMappingInfo.getPatternsCondition();
                    String requestUrl = CollectionUtils.findValueOfType(patternsCondition.getPatterns(), String.class);
                    if (requestUrl.equals("/error")) {
                        continue;
                    }
					String requestType = CollectionUtils.findValueOfType(methodCondition.getMethods(), RequestMethod.class).name();
					String name = requestMappingInfo.getName();

					ActionDTO action = new ActionDTO();
					action.setActionName(name);
					action.setActionType(ActionType.ACTION_URL);
					action.setActionValue(requestUrl.replaceAll("\\{dd\\}","*"));
					action.setMethodType(requestType);
					actions.add(action);

				}
			}
		}
		if (actions.size()<1) {
			logger.debug("There isn't requestURL to mapping!");
		} else {
			logger.debug("Persistence requestURL...");
            permissionsInterface.updateActions(actions);
		}
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		getAnnotionRequestUrl();
	}



}
