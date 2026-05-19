<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>评论管理</title>
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
            <li><a href="${pageContext.request.contextPath}/admin/comment" class="active"><i class="bi bi-chat"></i> 评论管理</a></li>
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
        <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/admin/logout"><i class="bi bi-box-arrow-left"></i> 退出</a></div>
    </nav>
    <main class="admin-content">
        <div class="content-header"><h4><i class="bi bi-chat"></i> 评论管理</h4></div>
        <div class="glass-card">
            <table class="table table-dark table-hover mb-0">
                <thead><tr><th>ID</th><th>文章</th><th>访客</th><th>内容</th><th>时间</th><th>操作</th></tr></thead>
                <tbody>
                <c:forEach items="${comments}" var="c">
                    <tr>
                        <td>${c.id}</td><td>${c.articleTitle}</td><td>${c.visitorName}</td>
                        <td><c:out value="${c.content}" /></td>
                        <td><fmt:formatDate value="${c.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/admin/comment" method="post" style="display:inline" onsubmit="return confirm('确定删除此评论？')">
                                <input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="${c.id}">
                                <button type="submit" class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i></button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <c:if test="${totalPages > 1}">
                <nav class="mt-3"><ul class="pagination pagination-sm justify-content-center mb-0">
                    <li class="page-item ${pageNum <= 1 ? 'disabled' : ''}"><a class="page-link" href="?pageNum=${pageNum-1}">&laquo;</a></li>
                    <c:forEach begin="1" end="${totalPages}" var="i"><li class="page-item ${i == pageNum ? 'active' : ''}"><a class="page-link" href="?pageNum=${i}">${i}</a></li></c:forEach>
                    <li class="page-item ${pageNum >= totalPages ? 'disabled' : ''}"><a class="page-link" href="?pageNum=${pageNum+1}">&raquo;</a></li>
                </ul></nav>
            </c:if>
        </div>
    </main>
</div>
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js?v=1779187447"></script>
<script src="${pageContext.request.contextPath}/js/admin.js?v=1779187447"></script>
</body>
</html>
