<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%-- Redirect to IndexServlet if accessed directly (e.g. via welcome-file) without data --%>
<c:if test="${empty articles}">
    <c:redirect url="/index"/>
</c:if>
<jsp:include page="/common/header.jsp"><jsp:param name="title" value="首页"/></jsp:include>
<jsp:include page="/common/nav.jsp"><jsp:param name="active" value="home"/></jsp:include>

<main class="container main-content">
    <div class="row">
        <div class="col-lg-8">
            <c:forEach items="${articles}" var="a">
                <article class="glass-card article-card mb-4">
                    <div class="article-meta">
                        <span class="badge bg-primary"><i class="bi bi-folder"></i> ${a.categoryName}</span>
                        <span class="meta-item"><i class="bi bi-person"></i> ${a.authorName}</span>
                        <span class="meta-item"><i class="bi bi-calendar"></i> <fmt:formatDate value="${a.createdAt}" pattern="yyyy-MM-dd"/></span>
                        <span class="meta-item"><i class="bi bi-eye"></i> ${a.viewCount}</span>
                        <c:if test="${a.isTop == 1}"><span class="badge bg-warning text-dark"><i class="bi bi-pin"></i> 置顶</span></c:if>
                    </div>
                    <h3 class="article-title">
                        <a href="${pageContext.request.contextPath}/article?id=${a.id}">${a.title}</a>
                    </h3>
                    <p class="article-summary">${a.summary}</p>
                    <a href="${pageContext.request.contextPath}/article?id=${a.id}" class="read-more">阅读全文 <i class="bi bi-arrow-right"></i></a>
                </article>
            </c:forEach>
            <c:if test="${empty articles}">
                <div class="glass-card text-center py-5">
                    <i class="bi bi-inbox display-1 text-muted"></i>
                    <p class="mt-3 text-muted">暂无文章</p>
                </div>
            </c:if>
            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <nav class="glass-pagination">
                    <ul class="pagination justify-content-center mb-0">
                        <li class="page-item ${pageNum <= 1 ? 'disabled' : ''}">
                            <a class="page-link" href="?pageNum=${pageNum-1}">&laquo; 上一页</a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${i == pageNum ? 'active' : ''}">
                                <a class="page-link" href="?pageNum=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${pageNum >= totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="?pageNum=${pageNum+1}">下一页 &raquo;</a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </div>
        <div class="col-lg-4">
            <jsp:include page="/common/sidebar.jsp"/>
        </div>
    </div>
</main>

<jsp:include page="/common/footer.jsp"/>
