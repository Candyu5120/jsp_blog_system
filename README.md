# 个人博客系统 (JSP Blog System)

一个基于 JSP + Servlet + MySQL 的个人博客系统，采用毛玻璃（Glassmorphism）设计风格，支持 OIDC 第三方登录。

## 功能特性

### 博主后台（管理面板）
- **登录系统**：传统账号密码登录 + OIDC 第三方登录
- **文章管理**：发布、编辑、删除文章，支持置顶和草稿状态
- **分类管理**：添加、编辑、删除文章分类
- **评论管理**：查看、删除访客评论
- **留言管理**：查看、删除访客留言
- **相册管理**：上传、浏览、删除照片，支持相册分组
- **友链管理**：添加、编辑、删除友情链接
- **OIDC 设置**：配置 OpenID Connect 第三方登录（支持 Auth0、Keycloak 等）

### 访客前台
- **浏览文章**：文章列表分页展示，支持按分类筛选
- **文章详情**：查看完整文章内容和评论
- **发表评论**：在文章下方发表评论
- **留言板**：发表留言
- **相册浏览**：查看博主照片，支持相册筛选
- **日志检索**：按关键词搜索文章

## 技术栈

| 技术 | 版本 | 说明 |
|------|------|------|
| JDK | 24 | Java 开发工具包 |
| Tomcat | 11.0 | Web 应用服务器 |
| MySQL | 9.4 | 数据库 |
| Jakarta Servlet | 6.0 | 服务器端技术 |
| JSP | 3.1 | 动态页面技术 |
| JSTL | 3.0 | JSP 标准标签库 |
| Bootstrap | 5.3 | 前端 UI 框架（CDN） |
| Bootstrap Icons | 1.11 | 图标库（CDN） |
| Auth0 java-jwt | 4.4 | OIDC ID Token 解析 |

## 项目结构

```
jsp_blog_system/
├── pom.xml                          # Maven 配置
├── README.md                        # 项目说明
├── src/main/
│   ├── java/com/blog/
│   │   ├── model/                   # 实体类 (8个)
│   │   ├── dao/                     # 数据访问层 (9个)
│   │   ├── servlet/
│   │   │   ├── admin/               # 后台 Servlet (11个)
│   │   │   └── front/               # 前台 Servlet (7个)
│   │   ├── filter/                  # 过滤器 (2个)
│   │   └── util/                    # 工具类 (2个)
│   └── resources/
│       ├── db.properties            # 数据库配置
│       └── sql/init.sql             # 数据库初始化脚本
└── web/
    ├── index.jsp                    # 博客首页
    ├── article.jsp                  # 文章详情
    ├── search.jsp                   # 搜索结果
    ├── photoAlbum.jsp               # 公开相册
    ├── guestbook.jsp                # 留言板
    ├── about.jsp                    # 关于页面
    ├── common/                      # 公共 JSP 片段
    ├── admin/                       # 后台管理页面 (13个)
    ├── css/                         # 样式文件 (毛玻璃风格)
    ├── js/                          # JavaScript 文件
    ├── images/                      # 图片资源
    └── error/                       # 错误页面
```

## 数据库设计

| 表名 | 说明 |
|------|------|
| `t_user` | 博主账号 |
| `t_category` | 文章分类 |
| `t_article` | 文章内容 |
| `t_comment` | 文章评论 |
| `t_message` | 留言板留言 |
| `t_photo` | 相册照片 |
| `t_friend` | 友情链接 |
| `t_oidc_setting` | OIDC 登录配置 |

## 部署步骤

### 环境要求
- JDK 24
- Apache Tomcat 11.0
- MySQL 9.4
- Maven 3.8+

### 1. 初始化数据库
```bash
mysql -u root -p < src/main/resources/sql/init.sql
```

### 2. 修改数据库配置
编辑 `src/main/resources/db.properties`，修改数据库连接信息：
```properties
jdbc.url=jdbc:mysql://localhost:3306/jsp_blog?useSSL=false&serverTimezone=Asia/Shanghai&characterEncoding=utf8mb4&allowPublicKeyRetrieval=true
jdbc.username=你的用户名
jdbc.password=你的密码
```

### 3. 构建项目
```bash
mvn clean package
```

### 4. 部署到 Tomcat
将 `target/jsp_blog_system.war` 复制到 Tomcat 的 `webapps/` 目录，启动 Tomcat。

### 5. 访问系统
- 博客首页：`http://localhost:8080/jsp_blog_system/`
- 管理后台：`http://localhost:8080/jsp_blog_system/admin/login`

## 默认账号

| 用户名 | 密码 |
|--------|------|
| admin | admin123 |

## 设计风格

本项目采用 **毛玻璃（Glassmorphism）** 设计风格：
- 前台：紫色渐变背景 + 半透明模糊卡片
- 后台：深色渐变背景 + 毛玻璃面板
- 响应式布局，支持移动端访问
- Bootstrap 5 + Bootstrap Icons（CDN 引入）

## License

本项目仅用于学习和课程设计目的。
