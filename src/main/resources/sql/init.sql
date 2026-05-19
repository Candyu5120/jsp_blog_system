-- 创建数据库
CREATE DATABASE IF NOT EXISTS jsp_blog DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE jsp_blog;

-- 用户账号表
CREATE TABLE IF NOT EXISTS t_user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    nickname VARCHAR(50) NOT NULL,
    avatar VARCHAR(255) DEFAULT NULL,
    email VARCHAR(100) DEFAULT NULL,
    bio TEXT DEFAULT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'editor' COMMENT 'admin=管理员, editor=编辑',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 文章分类表
CREATE TABLE IF NOT EXISTS t_category (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(200) DEFAULT NULL,
    sort_order INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 文章表
CREATE TABLE IF NOT EXISTS t_article (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    content LONGTEXT NOT NULL,
    summary VARCHAR(500) DEFAULT NULL,
    category_id INT DEFAULT NULL,
    author_id INT DEFAULT NULL,
    view_count INT DEFAULT 0,
    is_top TINYINT DEFAULT 0,
    status TINYINT DEFAULT 1 COMMENT '1=已发布, 0=草稿',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_category_id (category_id),
    INDEX idx_created_at (created_at),
    FOREIGN KEY (category_id) REFERENCES t_category(id) ON DELETE SET NULL,
    FOREIGN KEY (author_id) REFERENCES t_user(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 评论表
CREATE TABLE IF NOT EXISTS t_comment (
    id INT PRIMARY KEY AUTO_INCREMENT,
    article_id INT NOT NULL,
    visitor_name VARCHAR(50) NOT NULL,
    visitor_email VARCHAR(100) DEFAULT NULL,
    content TEXT NOT NULL,
    ip_address VARCHAR(50) DEFAULT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_article_id (article_id),
    FOREIGN KEY (article_id) REFERENCES t_article(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 留言表
CREATE TABLE IF NOT EXISTS t_message (
    id INT PRIMARY KEY AUTO_INCREMENT,
    visitor_name VARCHAR(50) NOT NULL,
    visitor_email VARCHAR(100) DEFAULT NULL,
    content TEXT NOT NULL,
    ip_address VARCHAR(50) DEFAULT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 相册照片表
CREATE TABLE IF NOT EXISTS t_photo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    album_name VARCHAR(100) DEFAULT '默认相册',
    photo_path VARCHAR(255) NOT NULL,
    description VARCHAR(200) DEFAULT NULL,
    upload_time DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 友情链接表
CREATE TABLE IF NOT EXISTS t_friend (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    url VARCHAR(255) NOT NULL,
    logo VARCHAR(255) DEFAULT NULL,
    description VARCHAR(200) DEFAULT NULL,
    sort_order INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- OIDC 配置表
CREATE TABLE IF NOT EXISTS t_oidc_setting (
    id INT PRIMARY KEY AUTO_INCREMENT,
    provider_name VARCHAR(100) NOT NULL,
    issuer_url VARCHAR(500) NOT NULL,
    client_id VARCHAR(200) NOT NULL,
    client_secret VARCHAR(500) NOT NULL,
    redirect_uri VARCHAR(500) NOT NULL,
    scope VARCHAR(200) DEFAULT 'openid profile email',
    enabled TINYINT DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 默认管理员账号 (密码: admin123 的 SHA-256 哈希)
INSERT INTO t_user (username, password, nickname, email, bio, role)
VALUES ('admin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', '博主', 'admin@blog.com', '这是一个热爱技术的博主', 'admin');

-- 默认分类
INSERT INTO t_category (name, description, sort_order) VALUES
('技术笔记', '编程技术相关文章', 1),
('生活随笔', '日常生活感悟', 2),
('项目实战', '项目开发经验分享', 3);

-- 示例文章
INSERT INTO t_article (title, content, summary, category_id, author_id, status) VALUES
('欢迎来到我的博客', '<p>这是我的第一篇博客文章，欢迎访问！</p><p>在这里，我将分享我的技术学习笔记、项目经验和生活感悟。</p>', '这是我的第一篇博客文章，欢迎访问！', 1, 1, 1),
('JSP 入门指南', '<p>JSP（JavaServer Pages）是一种基于 Java 的服务器端技术，用于创建动态网页。</p><p>本文将介绍 JSP 的基本概念和使用方法。</p>', 'JSP 基本概念和使用方法介绍', 1, 1, 1);

-- 好友关系表
CREATE TABLE IF NOT EXISTS t_user_friend (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    friend_id INT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'pending' COMMENT 'pending=待接受, accepted=已接受',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_user_friend (user_id, friend_id),
    FOREIGN KEY (user_id) REFERENCES t_user(id) ON DELETE CASCADE,
    FOREIGN KEY (friend_id) REFERENCES t_user(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 私信表
CREATE TABLE IF NOT EXISTS t_chat_message (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    content TEXT NOT NULL,
    is_read TINYINT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES t_user(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES t_user(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
