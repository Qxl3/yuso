
-- 创建库
create database if not exists yuso;

-- 切换库
use yuso;

-- 用户表
create table if not exists user
(
    id           bigint auto_increment comment 'id' primary key,
    userAccount  varchar(256)                           not null comment '账号',
    userPassword varchar(512)                           not null comment '密码',
    unionId      varchar(256)                           null comment '微信开放平台id',
    mpOpenId     varchar(256)                           null comment '公众号openId',
    userName     varchar(256)                           null comment '用户昵称',
    userAvatar   varchar(1024)                          null comment '用户头像',
    userProfile  varchar(512)                           null comment '用户简介',
    userRole     varchar(256) default 'user'            not null comment '用户角色：user/admin/ban',
    createTime   datetime     default CURRENT_TIMESTAMP not null comment '创建时间',
    updateTime   datetime     default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    isDelete     tinyint      default 0                 not null comment '是否删除',
    index idx_unionId (unionId)
) comment '用户' collate = utf8mb4_unicode_ci;

-- 帖子表
create table if not exists post
(
    id         bigint auto_increment comment 'id' primary key,
    title      varchar(512)                       null comment '标题',
    content    text                               null comment '内容',
    tags       varchar(1024)                      null comment '标签列表（json 数组）',
    thumbNum   int      default 0                 not null comment '点赞数',
    favourNum  int      default 0                 not null comment '收藏数',
    userId     bigint                             not null comment '创建用户 id',
    createTime datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    updateTime datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    isDelete   tinyint  default 0                 not null comment '是否删除',
    index idx_userId (userId)
) comment '帖子' collate = utf8mb4_unicode_ci;

-- 帖子点赞表（硬删除）
create table if not exists post_thumb
(
    id         bigint auto_increment comment 'id' primary key,
    postId     bigint                             not null comment '帖子 id',
    userId     bigint                             not null comment '创建用户 id',
    createTime datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    updateTime datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    index idx_postId (postId),
    index idx_userId (userId)
) comment '帖子点赞';

-- https://t.zsxq.com/0emozsIJh

-- 帖子收藏表（硬删除）
create table if not exists post_favour
(
    id         bigint auto_increment comment 'id' primary key,
    postId     bigint                             not null comment '帖子 id',
    userId     bigint                             not null comment '创建用户 id',
    createTime datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    updateTime datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    index idx_postId (postId),
    index idx_userId (userId)
) comment '帖子收藏';

INSERT INTO post (title, content, tags, thumbNum, favourNum, userId, createTime, updateTime, isDelete)
VALUES
    ('如何学习编程', '学习编程的步骤和建议', '["编程", "学习"]', 10, 5, 1, NOW(), NOW(), 0),
    ('美食分享：最爱的披萨店', '分享我最喜欢的披萨店，强烈推荐！', '["美食", "披萨"]', 15, 8, 2, NOW(), NOW(), 0),
    ('读书笔记：《时间简史》', '对霍金的《时间简史》进行了精彩的读后感', '["读书", "科普"]', 20, 12, 3, NOW(), NOW(), 0),
    ('最近追剧推荐', '分享最近追的几部好剧，有没有人一起讨论一下？', '["影视", "剧集"]', 8, 6, 4, NOW(), NOW(), 0),
    ('我的旅行日记', '最近去了一个美丽的地方，分享我的旅行日记和照片', '["旅行", "日记"]', 25, 18, 5, NOW(), NOW(), 0),
    ('新手程序员常见问题汇总', '分享一些新手程序员经常遇到的问题及解决方案', '["编程", "问题"]', 15, 8, 6, NOW(), NOW(), 0),
    ('摄影技巧分享', '分享一些摄影的基本技巧，希望能够帮助到摄影爱好者', '["摄影", "技巧"]', 12, 10, 7, NOW(), NOW(), 0),
    ('电影推荐：经典科幻电影', '列举一些经典的科幻电影，喜欢科幻的朋友可以一起讨论', '["影视", "科幻"]', 18, 15, 8, NOW(), NOW(), 0),
    ('学生党兼职经验分享', '分享一些学生党在学习之余的兼职经验和心得', '["兼职", "学生"]', 9, 7, 9, NOW(), NOW(), 0),
    ('最爱的运动鞋推荐', '推荐一些舒适耐穿的运动鞋品牌和款式', '["时尚", "运动鞋"]', 20, 12, 10, NOW(), NOW(), 0),
    ('编程书籍推荐', '分享一些值得一读的编程相关书籍', '["编程", "读书"]', 25, 20, 11, NOW(), NOW(), 0);