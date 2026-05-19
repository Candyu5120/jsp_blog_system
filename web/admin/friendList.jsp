<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>好友管理</title>
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
            <li><a href="${pageContext.request.contextPath}/admin/friend" class="active"><i class="bi bi-people"></i> 好友管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/chat"><i class="bi bi-chat-dots"></i> 私信管理</a></li>
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
            <h4><i class="bi bi-people"></i> 好友管理</h4>
        </div>

        <ul class="nav nav-tabs mb-4" style="border-color: rgba(255,255,255,0.1)">
            <li class="nav-item">
                <a class="nav-link ${activeTab == 'friends' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/friend" style="color: ${activeTab == 'friends' ? '#fff' : 'rgba(255,255,255,0.5)'}; background: ${activeTab == 'friends' ? 'rgba(255,255,255,0.05)' : 'transparent'}; border-color: ${activeTab == 'friends' ? 'rgba(255,255,255,0.1)' : 'transparent'}">
                    <i class="bi bi-people"></i> 我的好友
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${activeTab == 'requests' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/friend?action=requests" style="color: ${activeTab == 'requests' ? '#fff' : 'rgba(255,255,255,0.5)'}; background: ${activeTab == 'requests' ? 'rgba(255,255,255,0.05)' : 'transparent'}; border-color: ${activeTab == 'requests' ? 'rgba(255,255,255,0.1)' : 'transparent'}">
                    <i class="bi bi-person-plus"></i> 好友请求
                    <c:if test="${not empty requests}"><span class="badge bg-danger ms-1">${requests.size()}</span></c:if>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${activeTab == 'search' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/friend?action=search" style="color: ${activeTab == 'search' ? '#fff' : 'rgba(255,255,255,0.5)'}; background: ${activeTab == 'search' ? 'rgba(255,255,255,0.05)' : 'transparent'}; border-color: ${activeTab == 'search' ? 'rgba(255,255,255,0.1)' : 'transparent'}">
                    <i class="bi bi-search"></i> 添加好友
                </a>
            </li>
        </ul>

        <c:if test="${activeTab == 'friends'}">
            <c:choose>
                <c:when test="${empty friends}">
                    <div class="glass-card text-center text-muted py-5">
                        <i class="bi bi-people" style="font-size: 3rem;"></i>
                        <p class="mt-3">还没有好友，去搜索添加吧</p>
                        <a href="${pageContext.request.contextPath}/admin/friend?action=search" class="btn btn-primary btn-sm"><i class="bi bi-search"></i> 搜索好友</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row g-3">
                        <c:forEach items="${friends}" var="f">
                            <div class="col-md-4">
                                <div class="glass-card d-flex align-items-center gap-3">
                                    <div class="rounded-circle bg-primary d-flex align-items-center justify-content-center" style="width:48px;height:48px;font-size:1.2rem;color:#fff">
                                        ${f.friendNickname.substring(0,1)}
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="fw-bold">${f.friendNickname}</div>
                                        <small class="text-muted">@${f.friendUsername}</small>
                                    </div>
                                    <div class="d-flex gap-1">
                                        <a href="${pageContext.request.contextPath}/admin/chat?action=conversation&userId=${f.friendId}" class="btn btn-sm btn-outline-light" title="发私信"><i class="bi bi-chat-dots"></i></a>
                                        <form action="${pageContext.request.contextPath}/admin/friend" method="post" style="display:inline" onsubmit="return confirm('确定删除该好友？')">
                                            <input type="hidden" name="action" value="delete"><input type="hidden" name="friendId" value="${f.friendId}">
                                            <button type="submit" class="btn btn-sm btn-outline-danger" title="删除好友"><i class="bi bi-trash"></i></button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>

        <c:if test="${activeTab == 'requests'}">
            <c:choose>
                <c:when test="${empty requests}">
                    <div class="glass-card text-center text-muted py-5">
                        <i class="bi bi-person-check" style="font-size: 3rem;"></i>
                        <p class="mt-3">暂无待处理的好友请求</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row g-3">
                        <c:forEach items="${requests}" var="r">
                            <div class="col-md-4">
                                <div class="glass-card d-flex align-items-center gap-3">
                                    <div class="rounded-circle bg-warning d-flex align-items-center justify-content-center" style="width:48px;height:48px;font-size:1.2rem;color:#fff">
                                        ${r.friendNickname.substring(0,1)}
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="fw-bold">${r.friendNickname}</div>
                                        <small class="text-muted">@${r.friendUsername}</small>
                                        <br><small class="text-muted"><fmt:formatDate value="${r.createdAt}" pattern="yyyy-MM-dd HH:mm"/></small>
                                    </div>
                                    <div class="d-flex gap-1">
                                        <form action="${pageContext.request.contextPath}/admin/friend" method="post" style="display:inline">
                                            <input type="hidden" name="action" value="accept"><input type="hidden" name="id" value="${r.id}"><input type="hidden" name="userId" value="${r.userId}">
                                            <button type="submit" class="btn btn-sm btn-success"><i class="bi bi-check"></i></button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/admin/friend" method="post" style="display:inline">
                                            <input type="hidden" name="action" value="reject"><input type="hidden" name="id" value="${r.id}">
                                            <button type="submit" class="btn btn-sm btn-outline-danger"><i class="bi bi-x"></i></button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>

        <c:if test="${activeTab == 'search'}">
            <div class="glass-card mb-4">
                <form action="${pageContext.request.contextPath}/admin/friend" method="get" class="d-flex gap-3">
                    <input type="hidden" name="action" value="search">
                    <input type="text" name="keyword" class="form-control glass-input" placeholder="输入用户名搜索..." value="${keyword}" style="height:42px">
                    <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i> 搜索</button>
                </form>
            </div>
            <c:if test="${not empty searchResults}">
                <div class="row g-3">
                    <c:forEach items="${searchResults}" var="u">
                        <div class="col-md-4">
                            <div class="glass-card d-flex align-items-center gap-3">
                                <div class="rounded-circle bg-success d-flex align-items-center justify-content-center" style="width:48px;height:48px;font-size:1.2rem;color:#fff">
                                    ${u.nickname.substring(0,1)}
                                </div>
                                <div class="flex-grow-1">
                                    <div class="fw-bold">${u.nickname}</div>
                                    <small class="text-muted">@${u.username}</small>
                                </div>
                                <form action="${pageContext.request.contextPath}/admin/friend" method="post" style="display:inline">
                                    <input type="hidden" name="action" value="sendRequest"><input type="hidden" name="friendId" value="${u.id}">
                                    <button type="submit" class="btn btn-sm btn-primary"><i class="bi bi-person-plus"></i> 添加</button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            <c:if test="${not empty keyword && empty searchResults}">
                <div class="glass-card text-center text-muted py-5">
                    <i class="bi bi-search" style="font-size: 3rem;"></i>
                    <p class="mt-3">未找到匹配的用户</p>
                </div>
            </c:if>
        </c:if>
    </main>
</div>
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/admin.js"></script>
</body>
</html>
