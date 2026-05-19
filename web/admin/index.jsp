<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理后台 - 仪表盘</title>
    <!-- Google Fonts: Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" type="text/css">
    
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/bootstrap-icons.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/admin.css" rel="stylesheet" type="text/css">
</head>
<body class="admin-bg">
<div class="admin-wrapper">
    <!-- Sidebar -->
    <nav class="admin-sidebar glass-sidebar">
        <div class="sidebar-header">
            <i class="bi bi-journal-richtext"></i> 博客管理
        </div>
        <ul class="sidebar-nav">
            <li><a href="${pageContext.request.contextPath}/admin/index.jsp" class="active"><i class="bi bi-speedometer2"></i> 仪表盘</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/article"><i class="bi bi-file-earmark-text"></i> 文章管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/category"><i class="bi bi-folder"></i> 分类管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/comment"><i class="bi bi-chat"></i> 评论管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/message"><i class="bi bi-envelope"></i> 留言管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/photo"><i class="bi bi-images"></i> 相册管理</a></li>
            <li class="nav-divider"></li>
            <li><a href="${pageContext.request.contextPath}/admin/friend"><i class="bi bi-people"></i> 好友管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/chat"><i class="bi bi-chat-dots"></i> 私信管理</a></li>
            <c:if test="${sessionScope.loginUser.role == 'admin'}">
            <li class="nav-divider"></li>
            <li><a href="${pageContext.request.contextPath}/admin/friendLink"><i class="bi bi-link-45deg"></i> 友链管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/user"><i class="bi bi-people-fill"></i> 用户管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/oidc/setting"><i class="bi bi-shield-lock"></i> OIDC 设置</a></li>
            </c:if>
        </ul>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/admin/logout"><i class="bi bi-box-arrow-left"></i> 退出登录</a>
            <a href="${pageContext.request.contextPath}/index" target="_blank"><i class="bi bi-eye"></i> 查看博客</a>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="admin-content">
        <div class="content-header">
            <h4><i class="bi bi-speedometer2"></i> 仪表盘</h4>
            <span class="text-muted">欢迎回来，${sessionScope.loginUser.nickname}</span>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/admin/article" class="text-decoration-none">
                    <div class="glass-card stat-card">
                        <div class="stat-icon bg-primary"><i class="bi bi-file-earmark-text"></i></div>
                        <div class="stat-info">
                            <h3>文章管理</h3>
                            <p>管理所有文章</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/admin/comment" class="text-decoration-none">
                    <div class="glass-card stat-card">
                        <div class="stat-icon bg-success"><i class="bi bi-chat"></i></div>
                        <div class="stat-info">
                            <h3>评论管理</h3>
                            <p>管理访客评论</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/admin/message" class="text-decoration-none">
                    <div class="glass-card stat-card">
                        <div class="stat-icon bg-warning"><i class="bi bi-envelope"></i></div>
                        <div class="stat-info">
                            <h3>留言管理</h3>
                            <p>管理访客留言</p>
                        </div>
                    </div>
                </a>
            </div>
            <c:if test="${sessionScope.loginUser.role == 'admin'}">
            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/admin/user" class="text-decoration-none">
                    <div class="glass-card stat-card">
                        <div class="stat-icon" style="background: linear-gradient(135deg, #667eea, #764ba2);"><i class="bi bi-people-fill"></i></div>
                        <div class="stat-info">
                            <h3>用户管理</h3>
                            <p>管理系统用户</p>
                        </div>
                    </div>
                </a>
            </div>
            </c:if>
            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/admin/chat" class="text-decoration-none">
                    <div class="glass-card stat-card">
                        <div class="stat-icon" style="background: linear-gradient(135deg, #f093fb, #f5576c);"><i class="bi bi-chat-dots"></i></div>
                        <div class="stat-info">
                            <h3>私信管理</h3>
                            <p>查看私信消息</p>
                        </div>
                    </div>
                </a>
            </div>
        </div>

        <div class="glass-card">
            <h5 class="mb-3">快速操作</h5>
            <div class="d-flex gap-3 flex-wrap">
                <a href="${pageContext.request.contextPath}/admin/article?action=add" class="btn btn-primary">
                    <i class="bi bi-plus-circle"></i> 写新文章
                </a>
                <a href="${pageContext.request.contextPath}/admin/category?action=add" class="btn btn-outline-light">
                    <i class="bi bi-folder-plus"></i> 添加分类
                </a>
                <a href="${pageContext.request.contextPath}/admin/photo?action=upload" class="btn btn-outline-light">
                    <i class="bi bi-upload"></i> 上传照片
                </a>
                <a href="${pageContext.request.contextPath}/admin/friend?action=search" class="btn btn-outline-light">
                    <i class="bi bi-person-plus"></i> 添加好友
                </a>
                <c:if test="${sessionScope.loginUser.role == 'admin'}">
                <a href="${pageContext.request.contextPath}/admin/friendLink?action=add" class="btn btn-outline-light">
                    <i class="bi bi-link-45deg"></i> 添加友链
                </a>
                <a href="${pageContext.request.contextPath}/admin/user?action=add" class="btn btn-outline-light">
                    <i class="bi bi-person-plus-fill"></i> 新增用户
                </a>
                </c:if>
            </div>
        </div>
    </main>
</div>
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js?v=1779187447"></script>
<script src="${pageContext.request.contextPath}/js/admin.js?v=1779187447"></script>
</body>
</html>
