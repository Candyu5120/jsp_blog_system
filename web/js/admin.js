// Admin Panel JavaScript

function confirmDelete(url) {
    if (confirm('确定要删除吗？此操作不可撤销。')) {
        window.location.href = url;
    }
}

function confirmDeleteForm(form) {
    if (confirm('确定要删除吗？此操作不可撤销。')) {
        form.submit();
    }
    return false;
}
