package com.goodsPublic.shiro.manager;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.util.Destroyable;

import com.goodsPublic.shiro.inter.ShiroCacheManager;
/**
 * 用户缓存
 * 方法包括获取cache(到底是什么我也不知道)
 * 销毁cache
 * @author Administrator
 *
 */
public class CustomShiroCacheManager implements CacheManager, Destroyable{
	
	 private ShiroCacheManager shiroCacheManager;
	
	@Override
	public void destroy() throws Exception {
		 shiroCacheManager.destroy();
		
	}

	@Override
	public <K, V> Cache<K, V> getCache(String name) throws CacheException {
		 return getShiroCacheManager().getCache(name);
	}

	public ShiroCacheManager getShiroCacheManager() {
		return shiroCacheManager;
	}

	public void setShiroCacheManager(ShiroCacheManager shiroCacheManager) {
		this.shiroCacheManager = shiroCacheManager;
	}
}
