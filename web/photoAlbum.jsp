<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/common/header.jsp"><jsp:param name="title" value="相册"/></jsp:include>
<jsp:include page="/common/nav.jsp"><jsp:param name="active" value="album"/></jsp:include>

<main class="container main-content">
    <div class="row">
        <div class="col-lg-10 mx-auto">
            <div class="glass-card mb-4">
                <h4><i class="bi bi-images"></i> 相册</h4>
                <!-- Album filter -->
                <div class="d-flex gap-2 flex-wrap mt-3">
                    <a href="${pageContext.request.contextPath}/album" class="btn ${empty currentAlbum ? 'btn-primary' : 'btn-outline-secondary'} btn-sm">全部</a>
                    <c:forEach items="${albums}" var="al">
                        <a href="${pageContext.request.contextPath}/album?album=${al}" class="btn ${al == currentAlbum ? 'btn-primary' : 'btn-outline-secondary'} btn-sm">${al}</a>
                    </c:forEach>
                </div>
            </div>

            <div class="row g-4">
                <c:forEach items="${photos}" var="p">
                    <div class="col-md-4 col-sm-6">
                        <div class="glass-card photo-grid-card">
                            <img src="${pageContext.request.contextPath}/${p.photoPath}" class="img-fluid rounded" alt="${p.description}">
                            <div class="mt-2">
                                <c:if test="${not empty p.description}"><p class="mb-1">${p.description}</p></c:if>
                                <small class="text-muted"><i class="bi bi-folder"></i> ${p.albumName} &middot; <fmt:formatDate value="${p.uploadTime}" pattern="yyyy-MM-dd"/></small>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <c:if test="${empty photos}">
                <div class="glass-card text-center py-5">
                    <i class="bi bi-images display-1 text-muted"></i>
                    <p class="mt-3 text-muted">暂无照片</p>
                </div>
            </c:if>
        </div>
    </div>
</main>
<jsp:include page="/common/footer.jsp"/>
