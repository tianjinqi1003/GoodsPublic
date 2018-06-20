package com.goodsPublic.shiro.manager;

import org.apache.shiro.cache.Cache;
import org.springframework.beans.factory.annotation.Autowired;

import com.goodsPublic.shiro.cache.JedisShiroCache;
import com.goodsPublic.shiro.inter.ShiroCacheManager;
import com.goodsPublic.util.LoggerUtils;

public class JedisShiroCacheManager implements ShiroCacheManager{
	@Autowired
	private JedisManager jedisManager;

	@Override
	public <K, V> Cache<K, V> getCache(String name) {
		// TODO Auto-generated method stub
		return new JedisShiroCache<K, V>(name, getJedisManager());
	}

	/**
	 * 关闭redis的链接
	 */
	@Override
	public void destroy() {
		getJedisManager().getJedis().close();
		LoggerUtils.fmtDebug(getClass(),"redis连接关闭。。。。。");
	}

	public JedisManager getJedisManager() {
		return jedisManager;
	}

	public void setJedisManager(JedisManager jedisManager) {
		this.jedisManager = jedisManager;
	}

}
