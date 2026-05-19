<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty article ? '写新文章' : '编辑文章'}</title>
    <!-- Google Fonts: Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" type="text/css">
    
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/bootstrap-icons.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/admin.css" rel="stylesheet" type="text/css">
    <link href="https://unpkg.com/vditor@3.10.9/dist/index.css" rel="stylesheet" type="text/css">
</head>
<body class="admin-bg">
<div class="admin-wrapper article-editor-mode">
    <nav class="admin-sidebar glass-sidebar">
        <div class="sidebar-header"><i class="bi bi-journal-richtext"></i> 博客管理</div>
        <ul class="sidebar-nav">
            <li><a href="${pageContext.request.contextPath}/admin/index.jsp"><i class="bi bi-speedometer2"></i> 仪表盘</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/article" class="active"><i class="bi bi-file-earmark-text"></i> 文章管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/category"><i class="bi bi-folder"></i> 分类管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/comment"><i class="bi bi-chat"></i> 评论管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/message"><i class="bi bi-envelope"></i> 留言管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/photo"><i class="bi bi-images"></i> 相册管理</a></li>
            <li class="nav-divider"></li>
            <li><a href="${pageContext.request.contextPath}/admin/friend"><i class="bi bi-people"></i> 好友管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/chat"><i class="bi bi-chat-dots"></i> 私信管理</a></li>
            <c:if test="${sessionScope.loginUser.role == 'admin'}">
            <li class="nav-divider"></li>
            <li><a href="${pageContext.request.contextPath}/admin/friendLink"><i class="bi bi-link-45deg"></i> 友链管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/user"><i class="bi bi-people-fill"></i> 用户管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/oidc/setting"><i class="bi bi-shield-lock"></i> OIDC 设置</a></li>
            </c:if>
        </ul>

        <div class="sidebar-footer">
            <div class="dropdown dropup">
                <button class="sidebar-user-btn dropdown-toggle" data-bs-toggle="dropdown">
                    <div class="sidebar-user-avatar">${sessionScope.loginUser.nickname.substring(0,1)}</div>
                    <div class="sidebar-user-info">
                        <div class="sidebar-user-name">${sessionScope.loginUser.nickname}</div>
                        <div class="sidebar-user-username">@${sessionScope.loginUser.username}</div>
                    </div>
                </button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/settings"><i class="bi bi-gear"></i> 个人设置</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/index"><i class="bi bi-house"></i> 返回首页</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/admin/logout"><i class="bi bi-box-arrow-left"></i> 退出登录</a></li>
                </ul>
            </div>
        </div>


    </nav>
    <main class="admin-content article-editor-page">
        <form action="${pageContext.request.contextPath}/admin/article" method="post" class="article-editor-form">
            <input type="hidden" name="action" value="${empty article ? 'save' : 'update'}">
            <c:if test="${not empty article}"><input type="hidden" name="id" value="${article.id}"></c:if>

            <!-- Top bar: title + actions -->
            <div class="editor-topbar">
                <input type="text" class="editor-title-input" name="title" value="${article.title}" placeholder="输入文章标题..." required>
                <div class="editor-topbar-actions">
                    <a href="${pageContext.request.contextPath}/admin/article" class="btn btn-outline-light btn-sm"><i class="bi bi-arrow-left"></i> 返回</a>
                    <button type="submit" class="btn btn-primary btn-sm"><i class="bi bi-check-lg"></i> 保存</button>
                </div>
            </div>

            <!-- Meta bar: category, status, summary toggle -->
            <div class="editor-meta-bar">
                <div class="editor-meta-left">
                    <select class="editor-meta-select" name="categoryId" required>
                        <c:forEach items="${categories}" var="cat">
                            <option value="${cat.id}" ${cat.id == article.categoryId ? 'selected' : ''}>${cat.name}</option>
                        </c:forEach>
                    </select>
                    <label class="editor-meta-check">
                        <input type="checkbox" name="status" ${article.status == 1 || empty article ? 'checked' : ''}> 发布
                    </label>
                    <label class="editor-meta-check">
                        <input type="checkbox" name="isTop" ${article.isTop == 1 ? 'checked' : ''}> 置顶
                    </label>
                </div>
                <div class="editor-meta-right">
                    <button type="button" class="btn btn-sm editor-toggle-summary" onclick="toggleSummary()">
                        <i class="bi bi-card-text"></i> 摘要
                    </button>
                </div>
            </div>

            <!-- Collapsible summary -->
            <div id="summaryPanel" class="editor-summary-panel" style="display:none">
                <textarea class="editor-summary-input" name="summary" rows="2" placeholder="文章摘要（可选，留空则自动截取）...">${article.summary}</textarea>
            </div>

            <!-- Editor: takes all remaining space -->
            <div class="editor-body">
                <div id="vditor-container" class="vditor-wrapper"></div>
                <textarea id="contentOriginal" style="display:none">${article.content}</textarea>
                <input type="hidden" name="content" id="contentHidden" required>
            </div>
        </form>
    </main>
</div>
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/admin.js"></script>
<script src="https://unpkg.com/vditor@3.10.9/dist/index.min.js"></script>
<script>
function toggleSummary() {
    var panel = document.getElementById('summaryPanel');
    panel.style.display = panel.style.display === 'none' ? 'block' : 'none';
    // Vditor recalculate after summary toggle
    setTimeout(function() { window.dispatchEvent(new Event('resize')); }, 50);
}

(function() {
    var vditor = null;
    var originalContent = document.getElementById('contentOriginal').value;

    vditor = new Vditor('vditor-container', {
        mode: 'sv',
        height: '100%',
        placeholder: '在此输入 Markdown 内容...',
        theme: 'classic',
        toolbar: [
            'emoji', 'headings', 'bold', 'italic', 'strike', '|',
            'line', 'quote', 'list', 'ordered-list', 'check', '|',
            'code', 'inline-code', 'table', '|',
            'link', 'upload', '|',
            'undo', 'redo', '|',
            'edit-mode', 'fullscreen', 'preview', 'outline', '|',
            'help'
        ],
        outline: { enable: true, position: 'right' },
        cache: { enable: false },
        after: function() {
            if (originalContent && originalContent.trim()) {
                vditor.setValue(Vditor.html2md(originalContent));
            }
            document.getElementById('contentHidden').value = vditor.getHTML();
        },
        input: function() {
            document.getElementById('contentHidden').value = vditor.getHTML();
        }
    });

    document.querySelector('form').addEventListener('submit', function(e) {
        if (vditor) {
            var html = vditor.getHTML();
            if (!html || !html.trim()) {
                e.preventDefault();
                alert('请输入文章内容');
                return;
            }
            document.getElementById('contentHidden').value = html;
        }
    });
})();
</script>
</body>
</html>
