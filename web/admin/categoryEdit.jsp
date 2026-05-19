<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty category ? '添加分类' : '编辑分类'}</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css?v=1779187447" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap-icons.min.css?v=1779187447" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/admin.css?v=1779187447" rel="stylesheet">
</head>
<body class="admin-bg">
<div class="admin-wrapper">
    <nav class="admin-sidebar glass-sidebar">
        <div class="sidebar-header"><i class="bi bi-journal-richtext"></i> 博客管理</div>
        <ul class="sidebar-nav">
            <li><a href="${pageContext.request.contextPath}/admin/index.jsp"><i class="bi bi-speedometer2"></i> 仪表盘</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/article"><i class="bi bi-file-earmark-text"></i> 文章管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/category" class="active"><i class="bi bi-folder"></i> 分类管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/comment"><i class="bi bi-chat"></i> 评论管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/message"><i class="bi bi-envelope"></i> 留言管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/photo"><i class="bi bi-images"></i> 相册管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/friend"><i class="bi bi-link-45deg"></i> 友链管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/oidc/setting"><i class="bi bi-shield-lock"></i> OIDC 设置</a></li>
        </ul>
        <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/admin/logout"><i class="bi bi-box-arrow-left"></i> 退出</a></div>
    </nav>
    <main class="admin-content">
        <div class="content-header">
            <h4><i class="bi bi-folder-plus"></i> ${empty category ? '添加分类' : '编辑分类'}</h4>
            <a href="${pageContext.request.contextPath}/admin/category" class="btn btn-outline-light btn-sm"><i class="bi bi-arrow-left"></i> 返回</a>
        </div>
        <div class="glass-card">
            <form action="${pageContext.request.contextPath}/admin/category" method="post">
                <input type="hidden" name="action" value="${empty category ? 'save' : 'update'}">
                <c:if test="${not empty category}"><input type="hidden" name="id" value="${category.id}"></c:if>
                <div class="mb-3"><label class="form-label">分类名称</label><input type="text" class="form-control glass-input" name="name" value="${category.name}" required></div>
                <div class="mb-3"><label class="form-label">描述</label><textarea class="form-control glass-input" name="description" rows="3">${category.description}</textarea></div>
                <div class="mb-3"><label class="form-label">排序</label><input type="number" class="form-control glass-input" name="sortOrder" value="${category.sortOrder}" style="width:120px"></div>
                <button type="submit" class="btn btn-primary"><i class="bi bi-check-lg"></i> 保存</button>
                <a href="${pageContext.request.contextPath}/admin/category" class="btn btn-outline-light">取消</a>
            </form>
        </div>
    </main>
</div>
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js?v=1779187447"></script>
<script src="${pageContext.request.contextPath}/js/admin.js?v=1779187447"></script>
</body>
</html>
