<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/common/header.jsp"><jsp:param name="title" value="搜索"/></jsp:include>
<jsp:include page="/common/nav.jsp"/>

<main class="container main-content">
    <div class="row">
        <div class="col-lg-8">
            <div class="glass-card mb-4">
                <h4><i class="bi bi-search"></i> 搜索结果</h4>
                <p class="text-muted">关键词：<strong><c:out value="${keyword}"/></strong>，共找到 ${totalCount} 篇文章</p>
            </div>
            <c:forEach items="${articles}" var="a">
                <article class="glass-card article-card mb-4">
                    <div class="article-meta">
                        <span class="badge bg-primary">${a.categoryName}</span>
                        <span class="meta-item"><i class="bi bi-calendar"></i> <fmt:formatDate value="${a.createdAt}" pattern="yyyy-MM-dd"/></span>
                    </div>
                    <h3 class="article-title"><a href="${pageContext.request.contextPath}/article?id=${a.id}">${a.title}</a></h3>
                    <p class="article-summary">${a.summary}</p>
                    <a href="${pageContext.request.contextPath}/article?id=${a.id}" class="read-more">阅读全文 <i class="bi bi-arrow-right"></i></a>
                </article>
            </c:forEach>
            <c:if test="${empty articles}">
                <div class="glass-card text-center py-5">
                    <i class="bi bi-search display-1 text-muted"></i>
                    <p class="mt-3 text-muted">未找到相关文章</p>
                </div>
            </c:if>
            <c:if test="${totalPages > 1}">
                <nav class="glass-pagination">
                    <ul class="pagination justify-content-center mb-0">
                        <li class="page-item ${pageNum <= 1 ? 'disabled' : ''}"><a class="page-link" href="?keyword=${keyword}&pageNum=${pageNum-1}">&laquo;</a></li>
                        <c:forEach begin="1" end="${totalPages}" var="i"><li class="page-item ${i == pageNum ? 'active' : ''}"><a class="page-link" href="?keyword=${keyword}&pageNum=${i}">${i}</a></li></c:forEach>
                        <li class="page-item ${pageNum >= totalPages ? 'disabled' : ''}"><a class="page-link" href="?keyword=${keyword}&pageNum=${pageNum+1}">&raquo;</a></li>
                    </ul>
                </nav>
            </c:if>
        </div>
        <div class="col-lg-4"><jsp:include page="/common/sidebar.jsp"/></div>
    </div>
</main>
<jsp:include page="/common/footer.jsp"/>
