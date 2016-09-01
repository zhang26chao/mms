<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
<head>
<meta name="layout" content="main"/>
<title>修改密码</title>
<script type="text/javascript">
   function checkPwd() {
        var oldPwd = document.getElementById('oldPwd').value ;
        var newPwd = document.getElementById('newPwd').value ;
        var reNewPwd = document.getElementById('reNewPwd').value ;
        if (!oldPwd) {
            alert('请输入旧密码。');
            return false;
        }
        if (!newPwd) {
            alert('请输入新密码。');
            return false;
        }
        if (!reNewPwd) {
            alert('请输入新密码确认。');
            return false;
        }
        if (newPwd != reNewPwd) {
            alert('两次填写不一致，请重新填写。');
            return false;
        }
        return true;
   }
</script>
</head>

<body>

<div id="create-member" class="content scaffold-create" role="main">
<g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
</g:if>
<g:form action="modifyPwd" onsubmit="return checkPwd();">
    <h1>修改密码</h1>
    <fieldset class="form">
        <div class="fieldcontain ${hasErrors(bean: memberInstance, field: 'cardNo', 'error')} required">
            <label for="oldPwd">
                <g:message code="oldPwd.label" default="旧密码"/>
                <span class="required-indicator">*</span>
            </label>
            <g:passwordField name="oldPwd" required=""/>
        </div>

        <div class="fieldcontain ${hasErrors(bean: memberInstance, field: 'cardNo', 'error')} required">
            <label for="newPwd">
                <g:message code="password.label" default="新密码"/>
                <span class="required-indicator">*</span>
            </label>
            <g:passwordField name="newPwd" required=""/>
        </div>

        <div class="fieldcontain ${hasErrors(bean: memberInstance, field: 'name', 'error')} required">
            <label for="reNewPwd">
                <g:message code="password.confirm.label" default="确认新密码"/>
                <span class="required-indicator">*</span>
            </label>
            <g:passwordField name="reNewPwd" required=""/>
        </div>
    </fieldset>

    <fieldset class="buttons">
        <g:submitButton name="create" class="save"
                        value="${message(code: 'default.button.create.label', default: 'Create')}"/>
    </fieldset>
</g:form>
</div>
</body>
</html>