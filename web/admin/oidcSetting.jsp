<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OIDC 设置</title>
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
    <nav class="admin-sidebar glass-sidebar">
        <div class="sidebar-header"><i class="bi bi-journal-richtext"></i> 博客管理</div>
        <ul class="sidebar-nav">
            <li><a href="${pageContext.request.contextPath}/admin/index.jsp"><i class="bi bi-speedometer2"></i> 仪表盘</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/article"><i class="bi bi-file-earmark-text"></i> 文章管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/category"><i class="bi bi-folder"></i> 分类管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/comment"><i class="bi bi-chat"></i> 评论管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/message"><i class="bi bi-envelope"></i> 留言管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/photo"><i class="bi bi-images"></i> 相册管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/friend"><i class="bi bi-link-45deg"></i> 友链管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/oidc/setting" class="active"><i class="bi bi-shield-lock"></i> OIDC 设置</a></li>
        </ul>
        <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/admin/logout"><i class="bi bi-box-arrow-left"></i> 退出</a></div>
    </nav>
    <main class="admin-content">
        <div class="content-header"><h4><i class="bi bi-shield-lock"></i> OIDC 设置</h4></div>

        <c:if test="${param.success != null}">
            <div class="alert alert-success alert-dismissible fade show"><i class="bi bi-check-circle"></i> 保存成功！<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show"><c:out value="${error}"/><button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
        </c:if>

        <div class="glass-card">
            <form action="${pageContext.request.contextPath}/admin/oidc/setting" method="post">
                <c:if test="${not empty setting}"><input type="hidden" name="id" value="${setting.id}"></c:if>
                <div class="mb-3"><label class="form-label">Provider 名称</label><input type="text" class="form-control glass-input" name="providerName" value="${setting.providerName}" placeholder="如: Auth0, Keycloak, Google"></div>
                <div class="mb-3"><label class="form-label">Issuer URL</label><input type="url" class="form-control glass-input" name="issuerUrl" value="${setting.issuerUrl}" placeholder="如: https://your-domain.auth0.com" required></div>
                <div class="mb-3"><label class="form-label">Client ID</label><input type="text" class="form-control glass-input" name="clientId" value="${setting.clientId}" required></div>
                <div class="mb-3"><label class="form-label">Client Secret</label><input type="password" class="form-control glass-input" name="clientSecret" value="${setting.clientSecret}" required></div>
                <div class="mb-3"><label class="form-label">Redirect URI</label><input type="url" class="form-control glass-input" name="redirectUri" value="${setting.redirectUri}" placeholder="如: http://localhost:8080/jsp_blog_system/admin/oidc/callback" required></div>
                <div class="mb-3"><label class="form-label">Scope</label><input type="text" class="form-control glass-input" name="scope" value="${not empty setting.scope ? setting.scope : 'openid profile email'}"></div>
                <div class="mb-3">
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" name="enabled" ${setting.enabled == 1 ? 'checked' : ''}>
                        <label class="form-check-label">启用 OIDC 登录</label>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary"><i class="bi bi-check-lg"></i> 保存</button>
            </form>
        </div>
    </main>
</div>
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js?v=1779187447"></script>
<script src="${pageContext.request.contextPath}/js/admin.js?v=1779187447"></script>
</body>
</html>
