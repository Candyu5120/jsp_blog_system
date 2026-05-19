<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>与 ${otherUser.nickname} 的对话</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/bootstrap-icons.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/admin.css?v=3" rel="stylesheet" type="text/css">
    <style>
        .chat-container { display: flex; flex-direction: column; height: calc(100vh - 140px); }
        .chat-messages { flex: 1; overflow-y: auto; padding: 20px; display: flex; flex-direction: column-reverse; }
        .chat-message { display: flex; margin-bottom: 16px; }
        .chat-message.sent { justify-content: flex-end; }
        .chat-message.received { justify-content: flex-start; }
        .chat-bubble { max-width: 60%; padding: 10px 16px; border-radius: 18px; font-size: 0.9rem; line-height: 1.5; word-break: break-word; }
        .chat-message.sent .chat-bubble { background: linear-gradient(135deg, #d4869c, #e8a0b4); color: #fff; border-bottom-right-radius: 4px; }
        .chat-message.received .chat-bubble { background: rgba(212,134,156,0.06); color: #4a4a5a; border-bottom-left-radius: 4px; }
        .chat-time { font-size: 0.7rem; color: rgba(74,74,90,0.35); margin-top: 4px; }
        .chat-message.sent .chat-time { text-align: right; }
        .chat-input-area { padding: 16px 20px; border-top: 1px solid rgba(212,134,156,0.1); }
        .chat-input-area form { display: flex; gap: 12px; }
        .chat-input-area textarea { resize: none; height: 42px; }
    </style>
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
            <h4>
                <a href="${pageContext.request.contextPath}/admin/chat" class="me-2" style="color:#d4869c"><i class="bi bi-arrow-left"></i></a>
                <i class="bi bi-chat-dots"></i> ${otherUser.nickname}
                <small class="text-muted">@${otherUser.username}</small>
            </h4>
        </div>

        <div class="glass-card chat-container">
            <div class="chat-messages" id="chatMessages">
                <c:forEach items="${messages}" var="msg">
                    <div class="chat-message ${msg.senderId == sessionScope.loginUser.id ? 'sent' : 'received'}">
                        <div>
                            <div class="chat-bubble"><c:out value="${msg.content}" /></div>
                            <div class="chat-time"><fmt:formatDate value="${msg.createdAt}" pattern="MM-dd HH:mm"/></div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div class="chat-input-area">
                <form action="${pageContext.request.contextPath}/admin/chat" method="post">
                    <input type="hidden" name="action" value="send">
                    <input type="hidden" name="receiverId" value="${otherUser.id}">
                    <textarea name="content" class="form-control glass-input" placeholder="输入消息..." required onkeydown="if(event.key==='Enter'&&!event.shiftKey){event.preventDefault();this.form.submit();}"></textarea>
                    <button type="submit" class="btn btn-primary"><i class="bi bi-send"></i></button>
                </form>
            </div>
        </div>

        <c:if test="${totalPages > 1}">
            <nav class="mt-3"><ul class="pagination pagination-sm justify-content-center mb-0">
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${i == pageNum ? 'active' : ''}"><a class="page-link" href="?action=conversation&userId=${otherUser.id}&pageNum=${i}">${i}</a></li>
                </c:forEach>
            </ul></nav>
        </c:if>
    </main>
</div>
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/admin.js"></script>
<script>
    var el = document.getElementById('chatMessages');
    if (el) el.scrollTop = 0;
</script>
</body>
</html>
