<%@ page import="blog.MemberGift" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'gift.label', default: 'Member')}"/>
    <title>礼品兑换</title>
</head>

<body>
<a href="#create-member" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                               default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" controller="gift" action="list"><g:message code="default.list.label"
                                                                            args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="create-member" class="content scaffold-create" role="main">
    <h1>礼品兑换</h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${memberGift}">
        <ul class="errors" role="alert">
            <g:eachError bean="${memberGift}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form controller="gift" action="doExchange">
        <g:hiddenField name="id" value="${memberGift.gift.id}"/>
        <fieldset class="form">
            <div class="fieldcontain required">
                <label for="cardNo">
                    会员卡号
                    <span class="required-indicator">*</span>
                </label>
                <g:textField name="cardNo" value="${params.cardNo}" required=""/>
            </div>

            <div class="fieldcontain required">
                <label for="num">
                    兑换数量
                    <span class="required-indicator">*</span>
                </label>
                <g:field type="number" name="num" value="${params.num}" required=""/>
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
