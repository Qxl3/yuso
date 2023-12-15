
## 项目简介
对用户来说，使用该平台，可以在同一个页面集中搜索出不同来源、不同类型的内容，提升用户的检索效率和搜索体验。

对企业来说，当企业内部有多个项目的数据都存在搜索需求时，无需针对每个项目单独开发搜索功能，可以直接将各项目的数据源接入搜索中台，从而提升开发效率、降低系统维护成本。

聚合搜索页面 - 搜文章：

![](https://yupi-picture-1256524210.cos.ap-shanghai.myqcloud.com/1/1680425753446-db21e8a2-0fd2-496d-8539-b5e3c1f35758.png)

聚合搜索页面 - 搜图片：

![](https://yupi-picture-1256524210.cos.ap-shanghai.myqcloud.com/1/1680425525242-a6c69abb-1bae-489e-a509-6ddfda0d2c48-20230402170832730.png)

聚合搜索页面 - 搜用户：

![](https://yupi-picture-1256524210.cos.ap-shanghai.myqcloud.com/1/1680425678150-91c35525-a9d4-47e5-9c09-06548c84f7c4-20230402170853604.png)

Elastic Stack - Kibana 数据看板：

![](https://yupi-picture-1256524210.cos.ap-shanghai.myqcloud.com/1/1680425981611-18e62334-1243-4741-9013-124494249fcb.png)



项目架构图：

![](https://yupi-picture-1256524210.cos.ap-shanghai.myqcloud.com/1/image-20230402105911365.png)









#### 后端

- Spring Boot 2.7 框架 + springboot-init 脚手架
- MySQL 数据库（8.x 版本）
- Elastic Stack
    - Elasticsearch 搜索引擎（重点）
    - Logstash 数据管道
    - Kibana 数据可视化
- 数据抓取（jsoup、HttpClient 爬虫）
    - 离线
    - 实时
- 设计模式
    - 门面模式
    - 适配器模式
    - 注册器模式
- 数据同步（4 种同步方式）
    - 定时
    - 双写
    - Logstash
    - Canal
- JMeter 压力测试



## 项目大纲

1. 项目介绍和计划
2. 需求分析
3. 技术选型、业务流程、系统架构介绍
4. 前端项目初始化
    1. 前端脚手架使用
    2. 框架、组件库、请求库整合
5. 后端项目初始化
    1. Spring Boot 万用模板介绍和使用

6. 前端聚合搜索页面开发
7. 前后端联调
8. 多数据源获取（包含几种爬虫方式的讲解和实践）
    1. JSoup 离线抓取
    2. HttpClient 实时抓取

9. 聚合搜索业务场景分析
10. 聚合搜索接口开发
    1. 门面模式讲解
    2. 性能测试

11. 搜索接口优化
    1. 统一标准
    2. 适配器模式
    3. 注册器模式

12. 前端搜索接口调用优化
13. 从 0 开始学习 Elastic Stack
    1. Elasticsearch 概念及倒排索引原理
    2. Elasticsearch / Kibana 安装
    3. Elasticsearch + Kibana Dev Tools 入门实践
    4. Elasticsearch 调用方式讲解

14. ES 搜索引擎实战
    1. 几种 Java 客户端操作方式讲解
    2. ES 标准开发流程实战
    3. 动静分离

15. 数据同步（4 种同步方式）
    1. 定时
    2. 双写
    3. Logstash
    4. Canal

16. Kibana 搭建看板
17. JMeter 接口性能测试
18. 项目扩展点





