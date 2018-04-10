package com.ifox.util;

import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @Author:zhongchao
 * @Organization: ifox
 * @Description:
 * @Date:Created in16:10 2018/4/10
 * @Modified By:    list中的日期类型转化为JsonObject输出到页面
 */
public class JsonDateValueProcessor implements JsonValueProcessor {
    // 定义转换日期类型的输出格式
    private String format = "yyyy-MM-dd";

    public JsonDateValueProcessor() {

    }

    public JsonDateValueProcessor(String format) {
        this.format = format;
    }

    public Object processArrayValue(Object o, JsonConfig jsonConfig) {
        return o;
    }

    public Object processObjectValue(String s, Object o, JsonConfig jsonConfig) {
        if (o instanceof java.util.Date) {
            String str = new SimpleDateFormat(format).format((Date) o);
            return str;
        }
        if (null != o) {
            return o.toString();
        }
        return "";
    }
}
