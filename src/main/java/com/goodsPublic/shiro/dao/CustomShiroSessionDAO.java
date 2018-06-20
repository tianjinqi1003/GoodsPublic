package com.goodsPublic.shiro.dao;

import java.io.Serializable;
import java.util.Collection;

import org.apache.shiro.session.Session;
import org.apache.shiro.session.UnknownSessionException;
import org.apache.shiro.session.mgt.eis.AbstractSessionDAO;

import com.goodsPublic.shiro.inter.ShiroSessionRepository;
import com.goodsPublic.util.LoggerUtils;


/**
 * 实现了抽象session的持久层
 * @author Administrator
 *
 */
public class CustomShiroSessionDAO extends AbstractSessionDAO{

	private ShiroSessionRepository shiroSessionRepository;


	public ShiroSessionRepository getShiroSessionRepository() {
		return shiroSessionRepository;
	}

	public void setShiroSessionRepository(ShiroSessionRepository shiroSessionRepository) {
		this.shiroSessionRepository = shiroSessionRepository;
	}

	@Override
	public void delete(Session session) {
		if (session == null) {
			LoggerUtils.error(getClass(), "Session 不能为null");
			return;
		}
		Serializable id = session.getId();
		if (id != null)
			getShiroSessionRepository().deleteSession(id);
		LoggerUtils.fmtDebug(getClass(), "call sessionDAO delete()");
	}

	@Override
	public Collection<Session> getActiveSessions() {
		return getShiroSessionRepository().getAllSessions();
	}

	@Override
	public void update(Session session) throws UnknownSessionException {
		getShiroSessionRepository().saveSession(session);
		LoggerUtils.fmtDebug(getClass(), "call sessionDAO update()");
	}

	@Override
	protected Serializable doCreate(Session session) {
		Serializable sessionId = this.generateSessionId(session);
		this.assignSessionId(session, sessionId);
		getShiroSessionRepository().saveSession(session);
		LoggerUtils.fmtDebug(getClass(), "call sessionDAO doCreate()");
		return sessionId;
	}

	@Override
	protected Session doReadSession(Serializable sessionId) {
		//当请求客户端携带了sessionId, 会通过传入的sessionId 查找redis内的缓存
		//如果redis内不存在该session数据, 会返回null
		//然后抛出 UnknownSessionException
		ShiroSessionRepository shiroSessionRepository = getShiroSessionRepository();
		LoggerUtils.fmtDebug(getClass(), "call sessionDAO doReadSession()");
		return shiroSessionRepository.getSession(sessionId);
	}

	@Override
	public Session readSession(Serializable sessionId) throws UnknownSessionException {
		return super.readSession(sessionId);
	}
}
