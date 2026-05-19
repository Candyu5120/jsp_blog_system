-- 迁移脚本 v2: 用户管理 + 好友系统 + 分级权限
-- 在现有数据库上执行，无需重建

-- 1. 用户表添加角色字段
ALTER TABLE t_user ADD COLUMN role VARCHAR(20) NOT NULL DEFAULT 'editor' COMMENT 'admin=管理员, editor=编辑' AFTER bio;

-- 2. 将现有用户设为管理员
UPDATE t_user SET role = 'admin' WHERE role = 'editor' LIMIT 1;

-- 3. 好友关系表
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

-- 4. 私信表
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
