package com.goodsPublic.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MethodUtil {

	/**
	 * 计算总金�?
	 * @param list 
	 * @param colName 
	 * **/
	public static float getMoneySum(List<Map<String, Object>> list, String colName) {
		float moneySum=0;
		for (Map<String, Object> ff : list) {
			Object moneyObj = ff.get(colName);
			if(moneyObj!=null){
				moneySum+=Float.parseFloat(moneyObj.toString());
			}
		}
		return moneySum;
	}
	
	/**
	 * �?Map里放�?
	 * @param defValue 
	 * @param equValue 
	 * @param value 
	 * @param key 
	 * @param result 
	 * **/
	public static void putMapValue(Map<String, Object> result, String key, String value, String equValue, String defValue) {
		if(equValue.equals(value))
			result.put(key, defValue);
		else
			result.put(key, value);
	}
	
	/**
	 * String转换成Map  key  value
	 */
	public static Map<String, Object> StringToKV(String mapText) {  
		  
        if (mapText == null || mapText.equals("")) {  
            return null;  
        }
        mapText = mapText.substring(1, mapText.length()-1);
        String mapStr[] = mapText.split(",");
        Map<String, Object> map = new HashMap<String, Object>();  
        String key = ""; // key 
        String value = ""; // value
        for (String str : mapStr) {  
            String[] keyText = str.split("="); // 转换key与value的数�?  
            if (keyText.length < 1) {  
                continue;  
            }  
			try {
				key += "," + keyText[0];
				value += ",'" + keyText[1] + "'";
			} catch (Exception e) {
			}
        }
        map.put("key", key);
        map.put("value", value);
        return map;
    }
	
	/**
	 * String转换成List  key  value
	 */
	public static List<Map<String, Object>> StringToList(String listText) {
//		System.out.println(listText);
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
        if (listText == null || listText.equals("")) {  
            return null;  
        }
        String listStr[] = listText.split(";");
        for(String lStr : listStr){
        	if (lStr == null || lStr.equals("")) {  
                return null;  
            }
        	lStr = lStr.substring(1, lStr.length()-1);
        	String mapStr[] = lStr.split(",");
            Map<String, Object> map = new HashMap<String, Object>();  
            String key = ""; // key 
            String value = ""; // value
            for (String str : mapStr) {  
                String[] keyText = str.split("="); // 转换key与value的数�?  
                if (keyText.length < 1) {  
                    continue;  
                }  
    			try {
    				key += "," + keyText[0];
    				value += ",'" + keyText[1] + "'";
    			} catch (Exception e) {
    			}
            }
            map.put("key", key);
            map.put("value", value);
            System.out.println(key);
            System.out.println(value);
            list.add(map);
        }
//        System.out.println(list);
        return list;
    }
	
	/** 
     * 时间戳转换成日期格式字符�? 
     * @param seconds 精确到秒的字符串 
     * @param formatStr 
     * @return 
     */  
    public static String timeStamp2Date(String seconds,String format) {  
        if(seconds == null || seconds.isEmpty() || seconds.equals("null")){  
            return "";  
        }  
        if(format == null || format.isEmpty()) format = "yyyy-MM-dd HH:mm:ss";  
        SimpleDateFormat sdf = new SimpleDateFormat(format);  
        return sdf.format(new Date(Long.valueOf(seconds+"000")));  
    }  
	
	/** 
     * 发起http请求获取返回结果 
     * @param req_url 请求地址 
     * @return 
     */ 
	public static String httpRequest(String req_url) {
        StringBuffer buffer = new StringBuffer();  
        try {  
            URL url = new URL(req_url);  
            HttpURLConnection httpUrlConn = (HttpURLConnection) url.openConnection();  

            httpUrlConn.setDoOutput(false);  
            httpUrlConn.setDoInput(true);  
            httpUrlConn.setUseCaches(false);  

            httpUrlConn.setRequestMethod("GET");  
            httpUrlConn.connect();  

            // 将返回的输入流转换成字符�?  
            InputStream inputStream = httpUrlConn.getInputStream();  
            InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");  
            BufferedReader bufferedReader = new BufferedReader(inputStreamReader);  

            String str = null;  
            while ((str = bufferedReader.readLine()) != null) {  
                buffer.append(str);  
            }  
            bufferedReader.close();  
            inputStreamReader.close();  
            // 释放资源  
            inputStream.close();  
            inputStream = null;  
            httpUrlConn.disconnect();  

        } catch (Exception e) {  
            System.out.println(e.getStackTrace());  
        }  
        return buffer.toString();  
    }  
	
	public static void main(String[] args) {
		String str = "{package_no=,package_name=,bill_no=16030411532601,dish_no=9202,dishes=美式淡咖�?,la_carte_man=999999,la_carte_time=2016-03-04 11:53:26,give_man=,give_reason=,retreat_food_man=,retreat_food_reason=,la_carte_number=1,retreat_food__number=0,give_number=0,consumption_number=1,company=�?,original_price=15,actual_price=15,food_costs=15,surcharge=0,service_charge=0,discount_amount=0,dubtotal=15};{package_no=,package_name=,bill_no=16030411532601,dish_no=9204,dishes=玫瑰花奶�?,la_carte_man=999999,la_carte_time=2016-03-04 11:53:26,give_man=,give_reason=,retreat_food_man=,retreat_food_reason=,la_carte_number=1,retreat_food__number=0,give_number=0,consumption_number=1,company=�?,original_price=20,actual_price=20,food_costs=20,surcharge=0,service_charge=0,discount_amount=0,dubtotal=20};{package_no=,package_name=,bill_no=16030411532601,dish_no=9207,dishes=金骏�?,la_carte_man=999999,la_carte_time=2016-03-04 11:53:26,give_man=,give_reason=,retreat_food_man=,retreat_food_reason=,la_carte_number=1,retreat_food__number=0,give_number=0,consumption_number=1,company=�?,original_price=88,actual_price=88,food_costs=88,surcharge=0,service_charge=0,discount_amount=0,dubtotal=88};{package_no=,package_name=,bill_no=16030411532601,dish_no=9208,dishes=铁观�?,la_carte_man=999999,la_carte_time=2016-03-04 11:53:26,give_man=,give_reason=,retreat_food_man=,retreat_food_reason=,la_carte_number=1,retreat_food__number=0,give_number=0,consumption_number=1,company=�?,original_price=38,actual_price=38,food_costs=38,surcharge=0,service_charge=0,discount_amount=0,dubtotal=38};{package_no=,package_name=,bill_no=16030411532601,dish_no=9210,dishes=�?心果,la_carte_man=999999,la_carte_time=2016-03-04 11:53:26,give_man=,give_reason=,retreat_food_man=,retreat_food_reason=,la_carte_number=1,retreat_food__number=0,give_number=0,consumption_number=1,company=�?,original_price=25,actual_price=25,food_costs=25,surcharge=0,service_charge=0,discount_amount=0,dubtotal=25}";
		StringToList(str);
//		str = "";
//		StringToKV(str);
	}
}
