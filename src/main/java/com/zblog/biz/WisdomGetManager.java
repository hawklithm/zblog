package com.zblog.biz;

import com.zblog.core.util.CharsetUtils;
import com.zblog.core.util.HttpClientUtils;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Random;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by hawky on 15/12/6.
 */
@Service
public class WisdomGetManager {

    private Random rand = new Random();

    public static String urlTemplate = "https://sp0.baidu.com/8aQDcjqpAAV3otqbppnN2DJv/api.php?from_mid=1&format=json&ie=utf-8&oe=utf-8&subtitle=格言&query=格言&rn=1&pn=%d&resource_id=6844&cb=jQuery11020303711956878313_%d&_=%d";

    public String getWisdom(){
        Date now = new Date();
        String url = String.format(urlTemplate,rand.nextInt(500),now.getTime(),now.getTime());
        String responseStr = HttpClientUtils.sendGet(url,null);
        responseStr = CharsetUtils.decodeUnicode(responseStr);
        System.out.println(responseStr);
        return parse(responseStr);
    }

    private String parse(String origStr){
        Pattern pattern = Pattern.compile("jQuery[0-9]*_[0-9]*.(.+?).;$");
        Matcher matcher = pattern.matcher(origStr);
        if (matcher.find()){
            return matcher.group(1);
        }else{
            return "";
        }
    }
    public static void main(String args[]){
        Pattern pattern = Pattern.compile("jQuery[0-9]*_[0-9]*.(.+?).;$");
        Matcher matcher = pattern.matcher("/**/jQuery11020303711956878313_1449386246764({\\\"status\\\":\\\"0\\\",\\\"t\\\":\\\"\\\",\\\"set_cache_time\\\":\\\"\\\",\\\"data\\\":[{\\\"version\\\":2,\\\"status\\\":1,\\\"resNum\\\":1,\\\"hilight\\\":\\\"%01%B8%F1%D1%D4%01%00%00\\\",\\\"dispNum\\\":4103,\\\"listNum\\\":760,\\\"queryparser\\\":[{\\\"type\\\":\\\"格言\\\"}],\\\"OtherInfo\\\":{\\\"stat0\\\":[{\\\"sa\\\":\\\"人生\\\",\\\"su\\\":408,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"事业\\\",\\\"su\\\":328,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"生活\\\",\\\"su\\\":313,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"真理\\\",\\\"su\\\":271,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"时间\\\",\\\"su\\\":248,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"爱情\\\",\\\"su\\\":240,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"思想\\\",\\\"su\\\":231,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"友情\\\",\\\"su\\\":204,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"科学\\\",\\\"su\\\":203,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"智慧\\\",\\\"su\\\":199,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"成功\\\",\\\"su\\\":156,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"劳动\\\",\\\"su\\\":156,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"社会\\\",\\\"su\\\":140,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"青年\\\",\\\"su\\\":132,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"青春\\\",\\\"su\\\":127,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"道德\\\",\\\"su\\\":124,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"教育\\\",\\\"su\\\":114,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"学习\\\",\\\"su\\\":106,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"读书\\\",\\\"su\\\":103,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"天才\\\",\\\"su\\\":102,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"自由\\\",\\\"su\\\":96,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"理想\\\",\\\"su\\\":96,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"国家\\\",\\\"su\\\":75,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"失败\\\",\\\"su\\\":66,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"人才\\\",\\\"su\\\":62,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"儿童\\\",\\\"su\\\":44,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"勤奋\\\",\\\"su\\\":39,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"信仰\\\",\\\"su\\\":37,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"民族\\\",\\\"su\\\":36,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"集体\\\",\\\"su\\\":25,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"愿望\\\",\\\"su\\\":23,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"人格\\\",\\\"su\\\":20,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"修养\\\",\\\"su\\\":18,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"心理\\\",\\\"su\\\":18,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"奉献\\\",\\\"su\\\":18,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"数学\\\",\\\"su\\\":18,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"谦虚\\\",\\\"su\\\":17,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"企业\\\",\\\"su\\\":16,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"骄傲\\\",\\\"su\\\":15,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"团结\\\",\\\"su\\\":13,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"自信\\\",\\\"su\\\":13,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"妇女\\\",\\\"su\\\":11,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"励志\\\",\\\"su\\\":11,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"节约\\\",\\\"su\\\":5,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"民主\\\",\\\"su\\\":2,\\\"hasSubCate\\\":0},{\\\"sa\\\":\\\"乡愁\\\",\\\"su\\\":1,\\\"hasSubCate\\\":0}]},\\\"disp_data\\\":[{\\\"StdStg\\\":6844,\\\"StdStl\\\":8,\\\"_update_time\\\":\\\"1442654699\\\",\\\"loc\\\":\\\"http:\\\\/\\\\/www.baidu.com\\\\/geyan\\\\/cce52b21dcc5271c9e9a029e4fd174eb\\\",\\\"lastmod\\\":\\\"2014-06-10\\\",\\\"changefreq\\\":\\\"always\\\",\\\"priority\\\":\\\"1.0\\\",\\\"type\\\":\\\"格言\\\",\\\"brief0\\\":\\\"理想,梦想\\\",\\\"term0\\\":\\\"德莱赛\\\",\\\"term\\\":\\\"德莱赛\\\",\\\"ename\\\":\\\"理想是人生的太阳。\\\",\\\"stat0\\\":\\\"理想\\\",\\\"statctl\\\":\\\"stat0\\\",\\\"statlst\\\":\\\"类别\\\",\\\"author\\\":\\\"德莱赛\\\",\\\"pv\\\":\\\"28\\\",\\\"SiteId\\\":2003651}]}]});");
        if(matcher.find())
            System.out.println(matcher.group(1));
    }
}
