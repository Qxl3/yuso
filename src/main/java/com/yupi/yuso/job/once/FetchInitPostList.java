package com.yupi.yuso.job.once;

import cn.hutool.http.HttpRequest;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.yupi.yuso.esdao.PostEsDao;
import com.yupi.yuso.model.dto.post.PostEsDTO;
import com.yupi.yuso.model.entity.Post;
import com.yupi.yuso.model.entity.User;
import com.yupi.yuso.service.PostService;
import com.yupi.yuso.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.elasticsearch.Assertions;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 获取初始帖子列表
 *
 */
@Component
@Slf4j
public class FetchInitPostList implements CommandLineRunner {
    @Resource
    private PostService postService;
    @Resource
    private  UserService userService;

    @Override
    public void run(String... args) {
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
        List<User> userList = new ArrayList<>();
        boolean savePostResult=false;
       // boolean saveUserresult=false;
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
            savePostResult = postService.saveOrUpdate(post);

//            User user = new User();
//            user.setId(tempRecord.getLong("userId"));
//            user.setUserPassword("000000");
//            user.setUserAccount(tempRecord.getStr("userId"));
//            user.setUserAvatar(tempRecord.getStr("cover"));
//            saveUserresult = userService.saveOrUpdate(user);

            postList.add(post);
           // userList.add(user);
        }
        // 3. 数据入库
        if (savePostResult) {
            log.info("获取初始化帖子列表成功，条数 = {}", postList.size());
        } else {
            log.error("获取初始化帖子列表失败");
        }
//        if (saveUserresult) {
//            log.info("添加用户成功，条数 = {}", userList.size());
//        } else {
//            log.error("未获得新用户");
//        }
    }
}
