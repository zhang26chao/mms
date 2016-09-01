
<%@ page import="blog.Trade" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'trade.label', default: 'Trade')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-trade" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-trade" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list trade">
			
				<g:if test="${tradeInstance?.type}">
				<li class="fieldcontain">
					<span id="type-label" class="property-label"><g:message code="trade.type.label" default="Type" /></span>
					
						<span class="property-value" aria-labelledby="type-label"><g:fieldValue bean="${tradeInstance}" field="type"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${tradeInstance?.money}">
				<li class="fieldcontain">
					<span id="money-label" class="property-label"><g:message code="trade.money.label" default="Money" /></span>
					
						<span class="property-value" aria-labelledby="money-label"><g:fieldValue bean="${tradeInstance}" field="money"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${tradeInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="trade.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${tradeInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${tradeInstance?.member}">
				<li class="fieldcontain">
					<span id="member-label" class="property-label"><g:message code="trade.member.label" default="Member" /></span>
					
						<span class="property-value" aria-labelledby="member-label"><g:link controller="member" action="show" id="${tradeInstance?.member?.id}">${tradeInstance?.member?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${tradeInstance?.id}" />
					<g:link class="edit" action="edit" id="${tradeInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
