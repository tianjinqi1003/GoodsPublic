package com.goodsPublic.shiro.inter;

import org.apache.shiro.cache.Cache;

public interface ShiroCacheManager {
	//获得缓存？
    <K, V> Cache<K, V> getCache(String name);
    //删除缓存？
    void destroy();

}
