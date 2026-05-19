<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty friend ? '添加友链' : '编辑友链'}</title>
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
            <li><a href="${pageContext.request.contextPath}/admin/friend" class="active"><i class="bi bi-link-45deg"></i> 友链管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/oidc/setting"><i class="bi bi-shield-lock"></i> OIDC 设置</a></li>
        </ul>
        <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/admin/logout"><i class="bi bi-box-arrow-left"></i> 退出</a></div>
    </nav>
    <main class="admin-content">
        <div class="content-header">
            <h4><i class="bi bi-link-45deg"></i> ${empty friend ? '添加友链' : '编辑友链'}</h4>
            <a href="${pageContext.request.contextPath}/admin/friend" class="btn btn-outline-light btn-sm"><i class="bi bi-arrow-left"></i> 返回</a>
        </div>
        <div class="glass-card">
            <form action="${pageContext.request.contextPath}/admin/friend" method="post">
                <input type="hidden" name="action" value="${empty friend ? 'save' : 'update'}">
                <c:if test="${not empty friend}"><input type="hidden" name="id" value="${friend.id}"></c:if>
                <div class="mb-3"><label class="form-label">名称</label><input type="text" class="form-control glass-input" name="name" value="${friend.name}" required></div>
                <div class="mb-3"><label class="form-label">URL</label><input type="url" class="form-control glass-input" name="url" value="${friend.url}" required></div>
                <div class="mb-3"><label class="form-label">Logo URL</label><input type="text" class="form-control glass-input" name="logo" value="${friend.logo}"></div>
                <div class="mb-3"><label class="form-label">描述</label><input type="text" class="form-control glass-input" name="description" value="${friend.description}"></div>
                <div class="mb-3"><label class="form-label">排序</label><input type="number" class="form-control glass-input" name="sortOrder" value="${friend.sortOrder}" style="width:120px"></div>
                <button type="submit" class="btn btn-primary"><i class="bi bi-check-lg"></i> 保存</button>
                <a href="${pageContext.request.contextPath}/admin/friend" class="btn btn-outline-light">取消</a>
            </form>
        </div>
    </main>
</div>
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js?v=1779187447"></script>
<script src="${pageContext.request.contextPath}/js/admin.js?v=1779187447"></script>
</body>
</html>
