<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/common/header.jsp"><jsp:param name="title" value="留言板"/></jsp:include>
<jsp:include page="/common/nav.jsp"><jsp:param name="active" value="guestbook"/></jsp:include>

<main class="container main-content">
    <div class="row">
        <div class="col-lg-8 mx-auto">
            <!-- Message Form -->
            <div class="glass-card mb-4">
                <h4 class="mb-3"><i class="bi bi-pencil"></i> 留言</h4>
                <form action="${pageContext.request.contextPath}/message" method="post">
                    <div class="row mb-3">
                        <div class="col-md-6"><input type="text" class="form-control" name="visitorName" placeholder="你的昵称 *" required></div>
                        <div class="col-md-6"><input type="email" class="form-control" name="visitorEmail" placeholder="邮箱（可选）"></div>
                    </div>
                    <div class="mb-3"><textarea class="form-control" name="content" rows="4" placeholder="写下你的留言... *" required></textarea></div>
                    <button type="submit" class="btn btn-primary"><i class="bi bi-send"></i> 发表留言</button>
                </form>
            </div>

            <!-- Messages List -->
            <c:forEach items="${messages}" var="m">
                <div class="glass-card message-item mb-3">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <strong><i class="bi bi-person-circle"></i> <c:out value="${m.visitorName}"/></strong>
                        <small class="text-muted"><fmt:formatDate value="${m.createdAt}" pattern="yyyy-MM-dd HH:mm"/></small>
                    </div>
                    <p class="mb-0"><c:out value="${m.content}"/></p>
                </div>
            </c:forEach>
            <c:if test="${empty messages}">
                <div class="glass-card text-center py-5">
                    <i class="bi bi-chat-dots display-1 text-muted"></i>
                    <p class="mt-3 text-muted">暂无留言，快来第一个留言吧！</p>
                </div>
            </c:if>
            <c:if test="${totalPages > 1}">
                <nav class="glass-pagination">
                    <ul class="pagination justify-content-center mb-0">
                        <li class="page-item ${pageNum <= 1 ? 'disabled' : ''}"><a class="page-link" href="?pageNum=${pageNum-1}">&laquo;</a></li>
                        <c:forEach begin="1" end="${totalPages}" var="i"><li class="page-item ${i == pageNum ? 'active' : ''}"><a class="page-link" href="?pageNum=${i}">${i}</a></li></c:forEach>
                        <li class="page-item ${pageNum >= totalPages ? 'disabled' : ''}"><a class="page-link" href="?pageNum=${pageNum+1}">&raquo;</a></li>
                    </ul>
                </nav>
            </c:if>
        </div>
    </div>
</main>
<jsp:include page="/common/footer.jsp"/>
