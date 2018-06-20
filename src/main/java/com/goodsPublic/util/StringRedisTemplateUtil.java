package com.goodsPublic.util;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;
@Component
public class StringRedisTemplateUtil {
	@Autowired
	private  StringRedisTemplate stringRedisTemplate ;

	public String get(String key) {  

		if (StringUtils.isEmpty(key)) {  
			return null;  
		}  
		return stringRedisTemplate.opsForValue().get(key);  
	}  

	public StringRedisTemplate getStringRedisTemplate() {
		return stringRedisTemplate;
	}

	public void setStringRedisTemplate(StringRedisTemplate stringRedisTemplate) {
		this.stringRedisTemplate = stringRedisTemplate;
	}

	public void set(String key, String value) {  
		if (StringUtils.isEmpty(key) || StringUtils.isEmpty(value)) {  
			return;  
		}  
		stringRedisTemplate.opsForValue().set(key, value);  
	}  
}
