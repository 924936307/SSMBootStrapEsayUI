package com.ifox.util;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:11 2018/4/10
 * @Modified By:
 */
public class RandomUtil {
    /**
     * 获得随机数
     *
     * @param length
     */
    public static String getRadom(int length) {
        //获取一个随机数
        double rand = Math.random();
        //将随机数转换为字符串
        String str = String.valueOf(rand).replace("0.", "");
        //截取字符串
        String newStr = str.substring(0, length);
        System.out.println(newStr);
        return newStr;
    }


}
