package com.goodsPublic.shiro.manager;

import java.io.Serializable;
import javax.servlet.ServletRequest;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.UnknownSessionException;
import org.apache.shiro.session.mgt.SessionKey;
import org.apache.shiro.web.session.mgt.DefaultWebSessionManager;
import org.apache.shiro.web.session.mgt.WebSessionKey;
/**
 * Created by terabithia on 11/12/17.
 * 继承 DefaultWebSessionManage 重写retrieveSession方法，
 * 减少对redis的访问 减少readSession的调用次数
 */
public class CustomDefaultWebSessionManager extends DefaultWebSessionManager{
	 @Override
	    protected Session retrieveSession(SessionKey sessionKey) throws UnknownSessionException {
	        //获取sessionId
	        Serializable sessionId = getSessionId(sessionKey);

	        ServletRequest request = null;
	        if(sessionKey instanceof WebSessionKey){
	            //通过webSessionKey 获取 request对象
	            request = ((WebSessionKey)sessionKey).getServletRequest();
	        }

	        if(request != null && null != sessionId){
	            Object sessionObj = request.getAttribute(sessionId.toString());
	            if(sessionObj != null){
	                return (Session) sessionObj;
	            }
	        }

	        //调用父类的retrieveSession方法，从redis中获得session
	        Session session = super.retrieveSession(sessionKey);
	        if(request != null && null != sessionId){
	            //存入request中
	            request.setAttribute(sessionId.toString(),session);
	        }
	        return session;
	    }
}
