package com.yupi.yuso.esdao;

import cn.hutool.http.HttpRequest;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.yupi.yuso.model.entity.Picture;
import com.yupi.yuso.model.entity.Post;
import com.yupi.yuso.model.entity.User;
import com.yupi.yuso.service.PostService;
import com.yupi.yuso.service.UserService;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class test {
    @Resource
    private static PostService postService;

    @Resource
    private static UserService userService;

    public static void main(String[] args) throws IOException {
        // 1. 获取数据
        String json = "{\"current\":1,\"pageSize\":8,\"sortField\":\"createTime\",\"sortOrder\":\"descend\",\"category\":\"文章\",\"reviewStatus\":1}";
        String url = "https://www.code-nav.cn/api/post/search/page/vo";
        String result = HttpRequest
                .post(url)
                .body(json)
                .execute()
                .body();
        // 2. json 转对象
        Map<String, Object> map = JSONUtil.toBean(result, Map.class);
        JSONObject data = (JSONObject) map.get("data");
        JSONArray records = (JSONArray) data.get("records");
        List<Post> postList = new ArrayList<>();
        for (Object record : records) {
            JSONObject tempRecord = (JSONObject) record;
            Post post = new Post();
            post.setTitle(tempRecord.getStr("title"));
            post.setContent(tempRecord.getStr("content"));
            JSONArray tags = (JSONArray) tempRecord.get("tags");
            List<String> tagList = tags.toList(String.class);
            post.setTags(JSONUtil.toJsonStr(tagList));
            post.setUserId(tempRecord.getLong("userId"));
            post.setId(tempRecord.getLong("id"));
            postService.saveOrUpdate(post);

            User user = new User();
            user.setId(tempRecord.getLong("userId"));
            user.setUserPassword("000000");
            user.setUserName(tempRecord.getStr("userId"));
            user.setUserAvatar(tempRecord.getStr("cover"));
            userService.saveOrUpdate(user);
            postList.add(post);
        }
    }

}
