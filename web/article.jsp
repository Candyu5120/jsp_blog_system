<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/common/header.jsp"><jsp:param name="title" value="${article.title}"/></jsp:include>
<jsp:include page="/common/nav.jsp"/>

<main class="container main-content">
    <div class="row">
        <div class="col-lg-8">
            <article class="glass-card article-detail mb-4">
                <h1 class="article-detail-title">${article.title}</h1>
                <div class="article-meta mb-3">
                    <span class="badge bg-primary"><i class="bi bi-folder"></i> ${article.categoryName}</span>
                    <span class="meta-item"><i class="bi bi-person"></i> ${article.authorName}</span>
                    <span class="meta-item"><i class="bi bi-calendar"></i> <fmt:formatDate value="${article.createdAt}" pattern="yyyy-MM-dd HH:mm"/></span>
                    <span class="meta-item"><i class="bi bi-eye"></i> ${article.viewCount} 次阅读</span>
                </div>
                <div class="article-content">${article.content}</div>
            </article>

            <!-- Comments Section -->
            <div class="glass-card mb-4" id="comments">
                <h5 class="mb-3"><i class="bi bi-chat-dots"></i> 评论 (${commentCount})</h5>
                <c:forEach items="${comments}" var="c">
                    <div class="comment-item">
                        <div class="comment-header">
                            <strong><i class="bi bi-person-circle"></i> <c:out value="${c.visitorName}"/></strong>
                            <small class="text-muted"><fmt:formatDate value="${c.createdAt}" pattern="yyyy-MM-dd HH:mm"/></small>
                        </div>
                        <div class="comment-body"><c:out value="${c.content}"/></div>
                    </div>
                </c:forEach>
                <c:if test="${empty comments}">
                    <p class="text-muted text-center py-3">暂无评论，快来抢沙发吧！</p>
                </c:if>

                <hr class="my-4">
                <h5 class="mb-3"><i class="bi bi-pencil"></i> 发表评论</h5>
                <form action="${pageContext.request.contextPath}/comment" method="post">
                    <input type="hidden" name="articleId" value="${article.id}">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <input type="text" class="form-control" name="visitorName" placeholder="你的昵称 *" required>
                        </div>
                        <div class="col-md-6">
                            <input type="email" class="form-control" name="visitorEmail" placeholder="邮箱（可选）">
                        </div>
                    </div>
                    <div class="mb-3">
                        <textarea class="form-control" name="content" rows="4" placeholder="写下你的评论... *" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary"><i class="bi bi-send"></i> 提交评论</button>
                </form>
            </div>
        </div>
        <div class="col-lg-4">
            <jsp:include page="/common/sidebar.jsp"/>
        </div>
    </div>
</main>

<jsp:include page="/common/footer.jsp"/>
