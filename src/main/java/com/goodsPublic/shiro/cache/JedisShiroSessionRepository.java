package com.goodsPublic.shiro.cache;

import java.io.Serializable;
import java.util.Collection;

import org.apache.shiro.session.Session;

import com.goodsPublic.shiro.inter.ShiroSessionRepository;
import com.goodsPublic.shiro.manager.JedisManager;

public class JedisShiroSessionRepository implements ShiroSessionRepository{

	public static final String REDIS_SHIRO_SESSION = "wem-shiro-session:";
	//这里有个小BUG，因为Redis使用序列化后，Key反序列化回来发现前面有一段乱码，解决的办法是存储缓存不序列化
	public static final String REDIS_SHIRO_ALL = "*wem-shiro-session:*";
	private static final int SESSION_VAL_TIME_SPAN = 18000;
	private static final int DB_INDEX = 1;

	private JedisManager jedisManager;
	@Override
	public void saveSession(Session session) {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteSession(Serializable sessionId) {
		// TODO Auto-generated method stub

	}

	@Override
	public Session getSession(Serializable sessionId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Collection<Session> getAllSessions() {
		// TODO Auto-generated method stub
		return null;
	}

}
