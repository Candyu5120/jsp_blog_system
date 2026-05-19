<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty article ? '写新文章' : '编辑文章'}</title>
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
            <li><a href="${pageContext.request.contextPath}/admin/article" class="active"><i class="bi bi-file-earmark-text"></i> 文章管理</a></li>
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
        <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/admin/logout"><i class="bi bi-box-arrow-left"></i> 退出</a></div>
    </nav>
    <main class="admin-content">
        <div class="content-header">
            <h4><i class="bi bi-pencil-square"></i> ${empty article ? '写新文章' : '编辑文章'}</h4>
            <a href="${pageContext.request.contextPath}/admin/article" class="btn btn-outline-light btn-sm"><i class="bi bi-arrow-left"></i> 返回列表</a>
        </div>
        <div class="glass-card">
            <form action="${pageContext.request.contextPath}/admin/article" method="post">
                <input type="hidden" name="action" value="${empty article ? 'save' : 'update'}">
                <c:if test="${not empty article}"><input type="hidden" name="id" value="${article.id}"></c:if>
                <div class="mb-3">
                    <label class="form-label">文章标题</label>
                    <input type="text" class="form-control glass-input" name="title" value="${article.title}" required>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">文章分类</label>
                        <select class="form-select glass-input" name="categoryId" required>
                            <c:forEach items="${categories}" var="cat">
                                <option value="${cat.id}" ${cat.id == article.categoryId ? 'selected' : ''}>${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">&nbsp;</label>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="status" ${article.status == 1 || empty article ? 'checked' : ''}>
                            <label class="form-check-label">发布</label>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">&nbsp;</label>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="isTop" ${article.isTop == 1 ? 'checked' : ''}>
                            <label class="form-check-label">置顶</label>
                        </div>
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">文章摘要</label>
                    <textarea class="form-control glass-input" name="summary" rows="2">${article.summary}</textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label">文章内容 (支持HTML)</label>
                    <textarea class="form-control glass-input font-monospace" name="content" rows="15" required>${article.content}</textarea>
                </div>
                <button type="submit" class="btn btn-primary"><i class="bi bi-check-lg"></i> 保存</button>
                <a href="${pageContext.request.contextPath}/admin/article" class="btn btn-outline-light">取消</a>
            </form>
        </div>
    </main>
</div>
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js?v=1779187447"></script>
<script src="${pageContext.request.contextPath}/js/admin.js?v=1779187447"></script>
</body>
</html>
