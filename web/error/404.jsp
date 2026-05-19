<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - 页面未找到</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css?v=1779187447" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap-icons.min.css?v=1779187447" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css?v=1779187447" rel="stylesheet">
</head>
<body class="blog-bg d-flex align-items-center justify-content-center" style="min-height:100vh">
<div class="glass-card text-center" style="max-width:500px">
    <i class="bi bi-emoji-frown display-1" style="background:linear-gradient(135deg,#667eea,#764ba2);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text"></i>
    <h1 class="mt-3" style="font-size:4rem;font-weight:800;background:linear-gradient(135deg,#667eea,#764ba2);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text">404</h1>
    <p class="text-muted mb-4">抱歉，您访问的页面不存在</p>
    <a href="${pageContext.request.contextPath}/index" class="btn btn-primary"><i class="bi bi-house"></i> 返回首页</a>
</div>
</body>
</html>
