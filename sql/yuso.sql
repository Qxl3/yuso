
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


-- 插入20条模拟数据
INSERT INTO user (userAccount, userPassword, unionId, mpOpenId, userName, userAvatar, userProfile, userRole, createTime, updateTime, isDelete)
VALUES
    ('xiaoming001', 'password001', 'unionId001', 'mpOpenId001', '小明', 'avatar_url_001', '这是小明的简介', 'user', NOW(), NOW(), 0),
    ('xiaohong002', 'password002', 'unionId002', 'mpOpenId002', '小红', 'avatar_url_002', '这是小红的简介', 'user', NOW(), NOW(), 0),
    ('xiaoli003', 'password003', 'unionId003', 'mpOpenId003', '小丽', 'avatar_url_003', '这是小丽的简介', 'user', NOW(), NOW(), 0),
    ('xiaozhang004', 'password004', 'unionId004', 'mpOpenId004', '小张', 'avatar_url_004', '这是小张的简介', 'user', NOW(), NOW(), 0),
    ('xiaoxiao005', 'password005', 'unionId005', 'mpOpenId005', '小小', 'avatar_url_005', '这是小小的简介', 'user', NOW(), NOW(), 0),
    ('xiaobai006', 'password006', 'unionId006', 'mpOpenId006', '小白', 'avatar_url_006', '这是小白的简介', 'user', NOW(), NOW(), 0),
    ('xiaolan007', 'password007', 'unionId007', 'mpOpenId007', '小兰', 'avatar_url_007', '这是小兰的简介', 'user', NOW(), NOW(), 0),
    ('xiaohan008', 'password008', 'unionId008', 'mpOpenId008', '小涵', 'avatar_url_008', '这是小涵的简介', 'user', NOW(), NOW(), 0),
    ('xiaoyang009', 'password009', 'unionId009', 'mpOpenId009', '小阳', 'avatar_url_009', '这是小阳的简介', 'user', NOW(), NOW(), 0),
    ('xiaochen010', 'password010', 'unionId010', 'mpOpenId010', '小晨', 'avatar_url_010', '这是小晨的简介', 'user', NOW(), NOW(), 0),
    ('xiaowu011', 'password011', 'unionId011', 'mpOpenId011', '小吴', 'avatar_url_011', '这是小吴的简介', 'user', NOW(), NOW(), 0),
    ('xiaoxu012', 'password012', 'unionId012', 'mpOpenId012', '小许', 'avatar_url_012', '这是小许的简介', 'user', NOW(), NOW(), 0),
    ('xiaoyan013', 'password013', 'unionId013', 'mpOpenId013', '小燕', 'avatar_url_013', '这是小燕的简介', 'user', NOW(), NOW(), 0),
    ('xiaochang014', 'password014', 'unionId014', 'mpOpenId014', '小常', 'avatar_url_014', '这是小常的简介', 'user', NOW(), NOW(), 0),
    ('xiaohua015', 'password015', 'unionId015', 'mpOpenId015', '小华', 'avatar_url_015', '这是小华的简介', 'user', NOW(), NOW(), 0),
    ('xiaoyao016', 'password016', 'unionId016', 'mpOpenId016', '小姚', 'avatar_url_016', '这是小姚的简介', 'user', NOW(), NOW(), 0),
    ('xiaoxu017', 'password017', 'unionId017', 'mpOpenId017', '小许', 'avatar_url_017', '这是小许的简介', 'user', NOW(), NOW(), 0),
    ('xiaohuo018', 'password018', 'unionId018', 'mpOpenId018', '小霍', 'avatar_url_018', '这是小霍的简介', 'user', NOW(), NOW(), 0),
    ('xiaozhao019', 'password019', 'unionId019', 'mpOpenId019', '小赵', 'avatar_url_019', '这是小赵的简介', 'user', NOW(), NOW(), 0),
    ('xiaoyu020', 'password020', 'unionId020', 'mpOpenId020', '小于', 'avatar_url_020', '这是小于的简介', 'user', NOW(), NOW(), 0);
