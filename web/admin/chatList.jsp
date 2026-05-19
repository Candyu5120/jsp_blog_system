<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>私信管理</title>
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
            <li class="nav-divider"></li>
            <li><a href="${pageContext.request.contextPath}/admin/friend"><i class="bi bi-people"></i> 好友管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/chat" class="active"><i class="bi bi-chat-dots"></i> 私信管理</a></li>
            <c:if test="${sessionScope.loginUser.role == 'admin'}">
            <li class="nav-divider"></li>
            <li><a href="${pageContext.request.contextPath}/admin/friendLink"><i class="bi bi-link-45deg"></i> 友链管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/user"><i class="bi bi-people-fill"></i> 用户管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/oidc/setting"><i class="bi bi-shield-lock"></i> OIDC 设置</a></li>
            </c:if>
        </ul>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/admin/logout"><i class="bi bi-box-arrow-left"></i> 退出</a>
            <a href="${pageContext.request.contextPath}/index" target="_blank"><i class="bi bi-eye"></i> 查看博客</a>
        </div>
    </nav>
    <main class="admin-content">
        <div class="content-header">
            <h4><i class="bi bi-chat-dots"></i> 私信管理
                <c:if test="${totalUnread > 0}"><span class="badge bg-danger ms-2">${totalUnread} 条未读</span></c:if>
            </h4>
        </div>

        <c:choose>
            <c:when test="${empty conversations}">
                <div class="glass-card text-center text-muted py-5">
                    <i class="bi bi-chat-dots" style="font-size: 3rem;"></i>
                    <p class="mt-3">暂无私信</p>
                    <a href="${pageContext.request.contextPath}/admin/friend" class="btn btn-primary btn-sm"><i class="bi bi-people"></i> 去找好友聊天</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="glass-card">
                    <c:forEach items="${conversations}" var="conv">
                        <c:set var="otherId" value="${conv.senderId == sessionScope.loginUser.id ? conv.receiverId : conv.senderId}" />
                        <c:set var="otherName" value="${conv.senderId == sessionScope.loginUser.id ? conv.receiverNickname : conv.senderNickname}" />
                        <a href="${pageContext.request.contextPath}/admin/chat?action=conversation&userId=${otherId}" class="text-decoration-none">
                            <div class="d-flex align-items-center gap-3 py-3 px-2" style="border-bottom: 1px solid rgba(255,255,255,0.05)">
                                <div class="rounded-circle bg-primary d-flex align-items-center justify-content-center flex-shrink-0" style="width:48px;height:48px;font-size:1.2rem;color:#fff">
                                    ${otherName.substring(0,1)}
                                </div>
                                <div class="flex-grow-1 overflow-hidden">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="fw-bold text-white">${otherName}</span>
                                        <small class="text-muted"><fmt:formatDate value="${conv.createdAt}" pattern="MM-dd HH:mm"/></small>
                                    </div>
                                    <div class="text-truncate" style="color: rgba(255,255,255,0.5)">
                                        <c:if test="${conv.senderId == sessionScope.loginUser.id}">我: </c:if>${conv.content}
                                    </div>
                                </div>
                                <c:if test="${conv.isRead > 0}">
                                    <span class="badge bg-danger rounded-pill">${conv.isRead}</span>
                                </c:if>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </main>
</div>
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/admin.js"></script>
</body>
</html>
