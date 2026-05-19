<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>文章管理</title>
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
            <li><a href="${pageContext.request.contextPath}/admin/article" class="active"><i class="bi bi-file-earmark-text"></i> 文章管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/category"><i class="bi bi-folder"></i> 分类管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/comment"><i class="bi bi-chat"></i> 评论管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/message"><i class="bi bi-envelope"></i> 留言管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/photo"><i class="bi bi-images"></i> 相册管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/friend"><i class="bi bi-link-45deg"></i> 友链管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/oidc/setting"><i class="bi bi-shield-lock"></i> OIDC 设置</a></li>
        </ul>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/admin/logout"><i class="bi bi-box-arrow-left"></i> 退出</a>
        </div>
    </nav>
    <main class="admin-content">
        <div class="content-header">
            <h4><i class="bi bi-file-earmark-text"></i> 文章管理</h4>
            <a href="${pageContext.request.contextPath}/admin/article?action=add" class="btn btn-primary btn-sm"><i class="bi bi-plus"></i> 写新文章</a>
        </div>
        <div class="glass-card">
            <table class="table table-dark table-hover mb-0">
                <thead><tr><th>ID</th><th>标题</th><th>分类</th><th>浏览量</th><th>状态</th><th>创建时间</th><th>操作</th></tr></thead>
                <tbody>
                <c:forEach items="${articles}" var="a">
                    <tr>
                        <td>${a.id}</td>
                        <td>${a.title}</td>
                        <td><span class="badge bg-primary">${a.categoryName}</span></td>
                        <td>${a.viewCount}</td>
                        <td>
                            <c:choose>
                                <c:when test="${a.status == 1}"><span class="badge bg-success">已发布</span></c:when>
                                <c:otherwise><span class="badge bg-secondary">草稿</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td><fmt:formatDate value="${a.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/article?action=edit&id=${a.id}" class="btn btn-sm btn-outline-light"><i class="bi bi-pencil"></i></a>
                            <form action="${pageContext.request.contextPath}/admin/article" method="post" style="display:inline" onsubmit="return confirm('确定删除此文章？')">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${a.id}">
                                <button type="submit" class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i></button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <nav class="mt-3">
                    <ul class="pagination pagination-sm justify-content-center mb-0">
                        <li class="page-item ${pageNum <= 1 ? 'disabled' : ''}">
                            <a class="page-link" href="?pageNum=${pageNum-1}">&laquo;</a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${i == pageNum ? 'active' : ''}">
                                <a class="page-link" href="?pageNum=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${pageNum >= totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="?pageNum=${pageNum+1}">&raquo;</a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </div>
    </main>
</div>
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js?v=1779187447"></script>
<script src="${pageContext.request.contextPath}/js/admin.js?v=1779187447"></script>
</body>
</html>
