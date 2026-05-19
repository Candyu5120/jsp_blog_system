<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/common/header.jsp"><jsp:param name="title" value="友情链接"/></jsp:include>
<jsp:include page="/common/nav.jsp"/>

<main class="container main-content">
    <div class="row">
        <div class="col-lg-8 mx-auto">
            <div class="glass-card">
                <h4 class="mb-3"><i class="bi bi-link-45deg"></i> 友情链接</h4>
                <div class="row g-3">
                    <c:forEach items="${friends}" var="f">
                        <div class="col-md-6">
                            <a href="${f.url}" target="_blank" rel="noopener" class="text-decoration-none">
                                <div class="glass-card-inner p-3 d-flex align-items-center gap-3">
                                    <i class="bi bi-globe fs-3" style="color:#d4869c"></i>
                                    <div>
                                        <strong style="color:#4a4a5a">${f.name}</strong>
                                        <c:if test="${not empty f.description}"><br><small class="text-muted">${f.description}</small></c:if>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>
                <c:if test="${empty friends}">
                    <p class="text-center text-muted py-4">暂无友情链接</p>
                </c:if>
            </div>
        </div>
    </div>
</main>
<jsp:include page="/common/footer.jsp"/>
