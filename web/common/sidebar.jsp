<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<aside class="sidebar">
    <!-- Categories -->
    <div class="glass-card sidebar-section">
        <h5 class="sidebar-title"><i class="bi bi-folder"></i> 文章分类</h5>
        <ul class="list-unstyled">
            <c:forEach items="${categories}" var="cat">
                <li class="sidebar-item">
                    <a href="${pageContext.request.contextPath}/index?categoryId=${cat.id}">
                        <span>${cat.name}</span>
                        <span class="badge bg-primary rounded-pill">${cat.articleCount}</span>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>

    <!-- Recent Articles -->
    <div class="glass-card sidebar-section">
        <h5 class="sidebar-title"><i class="bi bi-clock-history"></i> 最近文章</h5>
        <ul class="list-unstyled">
            <c:forEach items="${recentArticles}" var="art">
                <li class="sidebar-item">
                    <a href="${pageContext.request.contextPath}/article?id=${art.id}">
                        <i class="bi bi-file-text"></i> ${art.title}
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>

    <!-- Friend Links -->
    <div class="glass-card sidebar-section">
        <h5 class="sidebar-title"><i class="bi bi-link-45deg"></i> 友情链接</h5>
        <ul class="list-unstyled">
            <c:forEach items="${friends}" var="friend">
                <li class="sidebar-item">
                    <a href="${friend.url}" target="_blank" rel="noopener">
                        <i class="bi bi-globe"></i> ${friend.name}
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>
</aside>
