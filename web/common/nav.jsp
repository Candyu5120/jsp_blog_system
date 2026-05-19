<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav class="navbar navbar-expand-lg glass-navbar fixed-top">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/index">
            <i class="bi bi-journal-richtext"></i> My Blog
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link ${param.active == 'home' ? 'active' : ''}" href="${pageContext.request.contextPath}/index">
                        <i class="bi bi-house"></i> 首页
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${param.active == 'album' ? 'active' : ''}" href="${pageContext.request.contextPath}/album">
                        <i class="bi bi-images"></i> 相册
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${param.active == 'guestbook' ? 'active' : ''}" href="${pageContext.request.contextPath}/message">
                        <i class="bi bi-chat-dots"></i> 留言板
                    </a>
                </li>
            </ul>
            <form class="d-flex" action="${pageContext.request.contextPath}/search" method="get">
                <div class="input-group">
                    <input type="text" class="form-control glass-input" name="keyword" placeholder="搜索文章..." value="${keyword}">
                    <button class="btn btn-outline-light" type="submit"><i class="bi bi-search"></i></button>
                </div>
            </form>
            <a class="nav-link ms-3" href="${pageContext.request.contextPath}/admin/login" title="管理后台">
                <i class="bi bi-gear"></i>
            </a>
        </div>
    </div>
</nav>
