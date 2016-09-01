
<%@ page import="blog.Member" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'member.label', default: 'Member')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-member" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-member" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list member">
			
				<g:if test="${memberInstance?.cardNo}">
				<li class="fieldcontain">
					<span id="cardNo-label" class="property-label"><g:message code="member.cardNo.label" default="Card No" /></span>
					
						<span class="property-value" aria-labelledby="cardNo-label"><g:fieldValue bean="${memberInstance}" field="cardNo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${memberInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="member.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${memberInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${memberInstance?.sex}">
				<li class="fieldcontain">
					<span id="sex-label" class="property-label"><g:message code="member.sex.label" default="Sex" /></span>
					
						<span class="property-value" aria-labelledby="sex-label"><g:fieldValue bean="${memberInstance}" field="sex"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${memberInstance?.birthDay}">
				<li class="fieldcontain">
					<span id="birthDay-label" class="property-label"><g:message code="member.birthDay.label" default="Birth Day" /></span>
					
						<span class="property-value" aria-labelledby="birthDay-label"><g:formatDate date="${memberInstance?.birthDay}" format="yyyy-MM-dd" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${memberInstance?.phoneNumber}">
				<li class="fieldcontain">
					<span id="phoneNumber-label" class="property-label"><g:message code="member.phoneNumber.label" default="Phone Number" /></span>
					
						<span class="property-value" aria-labelledby="phoneNumber-label"><g:fieldValue bean="${memberInstance}" field="phoneNumber"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${memberInstance?.balance}">
				<li class="fieldcontain">
					<span id="balance-label" class="property-label"><g:message code="member.balance.label" default="Balance" /></span>
					
						<span class="property-value" aria-labelledby="balance-label"><g:fieldValue bean="${memberInstance}" field="balance"/></span>
					
				</li>
				</g:if>

                <li class="fieldcontain">
                    <span id="grade-label" class="property-label"><g:message code="member.grade.label" default="Grade" /></span>

                    <span class="property-value" aria-labelledby="grade-label"><g:fieldValue bean="${memberInstance}" field="grade"/></span>

                </li>
			
				<g:if test="${memberInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="member.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${memberInstance?.dateCreated}" format="yyyy-MM-dd HH:mm:ss" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${memberInstance?.id}" />
					<g:link class="edit" action="edit" id="${memberInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
