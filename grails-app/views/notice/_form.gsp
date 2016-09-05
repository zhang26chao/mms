<%@ page import="blog.Notice" %>



<div class="fieldcontain ${hasErrors(bean: noticeInstance, field: 'title', 'error')} required">
    <label for="title">
        <g:message code="notice.title.label" default="Title"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="title" required="" value="${noticeInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: noticeInstance, field: 'content', 'error')} required">
    <label for="content">
        <g:message code="notice.content.label" default="Content"/>
        <span class="required-indicator">*</span>
    </label>
    <style>
    table.cke_editor tr:hover {
        background: none;
    }
    </style>

    <div style="float: right">
        <ckeditor:editor name="content" height="200px" width="627px">
            ${noticeInstance?.content}
        </ckeditor:editor>
    </div>
</div>

