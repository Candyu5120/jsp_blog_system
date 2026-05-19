<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理后台 - 登录</title>
    <!-- Google Fonts: Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet" type="text/css">
    
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/bootstrap-icons.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/admin.css" rel="stylesheet" type="text/css">
</head>
<body class="admin-login-bg">
<div class="login-container">
    <div class="glass-card-dark login-card">
        <div class="text-center mb-4">
            <i class="bi bi-journal-richtext login-logo"></i>
            <h3 class="mt-2">博客管理后台</h3>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${param.error != null}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${param.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/login" method="post">
            <div class="mb-3">
                <label class="form-label">用户名</label>
                <div class="input-group">
                    <span class="input-group-text glass-input-addon"><i class="bi bi-person"></i></span>
                    <input type="text" class="form-control glass-input" name="username" required placeholder="请输入用户名">
                </div>
            </div>
            <div class="mb-4">
                <label class="form-label">密码</label>
                <div class="input-group">
                    <span class="input-group-text glass-input-addon"><i class="bi bi-lock"></i></span>
                    <input type="password" class="form-control glass-input" name="password" required placeholder="请输入密码">
                </div>
            </div>
            <button type="submit" class="btn btn-primary w-100 mb-3">
                <i class="bi bi-box-arrow-in-right"></i> 登录
            </button>
        </form>

        <c:if test="${oidcEnabled}">
            <div class="divider-text my-3">或</div>
            <a href="${pageContext.request.contextPath}/admin/oidc/login" class="btn btn-outline-light w-100">
                <i class="bi bi-shield-lock"></i> 使用 ${oidcProviderName} 登录
            </a>
        </c:if>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>
