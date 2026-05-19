// Common JavaScript for Blog Frontend

// Debug CSS loading
(function() {
    var sheets = document.styleSheets;
    console.log('[DEBUG] total stylesheets:', sheets.length);
    for (var i = 0; i < sheets.length; i++) {
        try {
            console.log('[DEBUG] sheet[' + i + '] href:', sheets[i].href, 'rules:', sheets[i].cssRules.length);
        } catch(e) {
            console.log('[DEBUG] sheet[' + i + '] href:', sheets[i].href, 'PARSE ERROR:', e.message);
        }
    }

    // Fetch CSS headers to check Content-Type
    var testUrl = sheets[2] ? sheets[2].href : '/jsp_blog_system/css/style.css';
    fetch(testUrl, { method: 'HEAD' }).then(function(r) {
        console.log('[DEBUG] style.css status:', r.status);
        console.log('[DEBUG] style.css Content-Type:', r.headers.get('content-type'));
        console.log('[DEBUG] style.css Content-Length:', r.headers.get('content-length'));
    });

    fetch(sheets[0] ? sheets[0].href : '', { method: 'HEAD' }).then(function(r) {
        console.log('[DEBUG] bootstrap.css status:', r.status);
        console.log('[DEBUG] bootstrap.css Content-Type:', r.headers.get('content-type'));
    });

    var body = document.body;
    var bodyStyle = getComputedStyle(body);
    console.log('[DEBUG] body bg:', bodyStyle.background.substring(0, 80));
    console.log('[DEBUG] body paddingTop:', bodyStyle.paddingTop);
    console.log('[DEBUG] body color:', bodyStyle.color);
})();

function confirmDelete(url) {
    if (confirm('确定要删除吗？此操作不可撤销。')) {
        window.location.href = url;
    }
}

// Form validation
function validateForm(form) {
    var inputs = form.querySelectorAll('[required]');
    for (var i = 0; i < inputs.length; i++) {
        if (!inputs[i].value.trim()) {
            inputs[i].focus();
            alert('请填写所有必填项');
            return false;
        }
    }
    return true;
}
