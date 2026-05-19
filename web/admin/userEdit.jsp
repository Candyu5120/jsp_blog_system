<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty editUser ? '新增用户' : '编辑用户'}</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/bootstrap-icons.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/admin.css" rel="stylesheet" type="text/css">
</head>
<body class="admin-bg">
<div class="admin-wrapper">
    <nav class="admin-sidebar glass-sidebar">
        <div class="sidebar-header"><i class="bi bi-journal-richtext"></i> 博客管理</div>
        <ul class="sidebar-nav">
            <li><a href="${pageContext.request.contextPath}/admin/index.jsp"><i class="bi bi-speedometer2"></i> 仪表盘</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/article"><i class="bi bi-file-earmark-text"></i> 文章管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/category"><i class="bi bi-folder"></i> 分类管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/comment"><i class="bi bi-chat"></i> 评论管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/message"><i class="bi bi-envelope"></i> 留言管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/photo"><i class="bi bi-images"></i> 相册管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/music"><i class="bi bi-music-note-beamed"></i> 音乐管理</a></li>
            <li class="nav-divider"></li>
            <li><a href="${pageContext.request.contextPath}/admin/friend"><i class="bi bi-people"></i> 好友管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/chat"><i class="bi bi-chat-dots"></i> 私信管理</a></li>
            <c:if test="${sessionScope.loginUser.role == 'admin'}">
            <li class="nav-divider"></li>
            <li><a href="${pageContext.request.contextPath}/admin/friendLink"><i class="bi bi-link-45deg"></i> 友链管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/user" class="active"><i class="bi bi-people-fill"></i> 用户管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/oidc/setting"><i class="bi bi-shield-lock"></i> OIDC 设置</a></li>
            </c:if>
        </ul>

        <div class="sidebar-footer">
            <div class="dropdown dropup">
                <button class="sidebar-user-btn dropdown-toggle" data-bs-toggle="dropdown">
                    <div class="sidebar-user-avatar">${sessionScope.loginUser.nickname.substring(0,1)}</div>
                    <div class="sidebar-user-info">
                        <div class="sidebar-user-name">${sessionScope.loginUser.nickname}</div>
                        <div class="sidebar-user-username">@${sessionScope.loginUser.username}</div>
                    </div>
                </button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/settings"><i class="bi bi-gear"></i> 个人设置</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/index"><i class="bi bi-house"></i> 返回首页</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/admin/logout"><i class="bi bi-box-arrow-left"></i> 退出登录</a></li>
                </ul>
            </div>
        </div>


    </nav>
    <main class="admin-content">
        <div class="content-header">
            <h4><i class="bi bi-pencil"></i> ${empty editUser ? '新增用户' : '编辑用户'}</h4>
            <a href="${pageContext.request.contextPath}/admin/user" class="btn btn-outline-light btn-sm"><i class="bi bi-arrow-left"></i> 返回列表</a>
        </div>
        <div class="glass-card">
            <form action="${pageContext.request.contextPath}/admin/user" method="post">
                <c:choose>
                    <c:when test="${empty editUser}">
                        <input type="hidden" name="action" value="save">
                    </c:when>
                    <c:otherwise>
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="${editUser.id}">
                    </c:otherwise>
                </c:choose>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">用户名</label>
                        <input type="text" name="username" class="form-control glass-input" value="${editUser.username}" ${empty editUser ? '' : 'readonly'} required>
                    </div>
                    <c:if test="${empty editUser}">
                    <div class="col-md-6">
                        <label class="form-label">密码</label>
                        <input type="password" name="password" class="form-control glass-input" required>
                    </div>
                    </c:if>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">昵称</label>
                        <input type="text" name="nickname" class="form-control glass-input" value="${editUser.nickname}" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">邮箱</label>
                        <input type="email" name="email" class="form-control glass-input" value="${editUser.email}">
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">简介</label>
                    <textarea name="bio" class="form-control glass-input" rows="3" style="height:auto">${editUser.bio}</textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">角色</label>
                    <select name="role" class="form-select glass-input">
                        <option value="editor" ${editUser.role == 'editor' ? 'selected' : ''}>编辑</option>
                        <option value="admin" ${editUser.role == 'admin' ? 'selected' : ''}>管理员</option>
                    </select>
                </div>

                <div class="d-flex gap-3">
                    <button type="submit" class="btn btn-primary"><i class="bi bi-check-circle"></i> ${empty editUser ? '创建用户' : '保存修改'}</button>
                    <a href="${pageContext.request.contextPath}/admin/user" class="btn btn-outline-light">取消</a>
                </div>
            </form>

            <c:if test="${not empty editUser}">
            <hr class="my-4" style="border-color: rgba(212,134,156,0.08)">
            <form action="${pageContext.request.contextPath}/admin/user" method="post">
                <input type="hidden" name="action" value="changePassword">
                <input type="hidden" name="id" value="${editUser.id}">
                <h5 class="mb-3"><i class="bi bi-key"></i> 修改密码</h5>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">新密码</label>
                        <input type="password" name="newPassword" class="form-control glass-input" required>
                    </div>
                </div>
                <button type="submit" class="btn btn-warning"><i class="bi bi-key"></i> 修改密码</button>
            </form>
            </c:if>
        </div>
    </main>
</div>
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/admin.js"></script>
</body>
</html>
