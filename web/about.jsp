<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/common/header.jsp"><jsp:param name="title" value="关于"/></jsp:include>
<jsp:include page="/common/nav.jsp"/>

<main class="container main-content">
    <div class="row">
        <div class="col-lg-8 mx-auto">
            <div class="glass-card">
                <h4 class="mb-3"><i class="bi bi-person"></i> 关于博主</h4>
                <p>欢迎来到我的个人博客！</p>
                <p>这是一个使用 JSP 技术构建的个人博客系统，支持文章管理、相册、留言板、友链等功能。</p>
                <p>如果你有任何问题或建议，欢迎通过留言板与我交流。</p>
            </div>
        </div>
    </div>
</main>
<jsp:include page="/common/footer.jsp"/>
