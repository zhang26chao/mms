<%@ page import="blog.Member" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'member.label', default: 'Member')}"/>
    <title>会员消费</title>
</head>

<body>
<a href="#create-member" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                               default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="create-member" class="content scaffold-create" role="main">
    <h1>会员消费</h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${tradeInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${tradeInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form action="trade">
        <g:hiddenField name="member.id" value="${tradeInstance?.member?.id}" />
        <g:hiddenField name="type" value="${tradeInstance?.type}" />
        <fieldset class="form">
            <div class="fieldcontain ${hasErrors(bean: tradeInstance, field: 'money', 'error')} required">
                <label for="money">
                    金额(元)
                    <span class="required-indicator">*</span>
                </label>
                <g:field type="number" name="money" required=""
                         value="${fieldValue(bean: tradeInstance, field: 'money')}"/>
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
