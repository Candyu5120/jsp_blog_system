<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.title != null ? param.title : '个人博客'} - My Blog</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css?v=2" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/bootstrap-icons.min.css?v=2" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/style.css?v=4" rel="stylesheet" type="text/css">
</head>
<body class="blog-bg">
