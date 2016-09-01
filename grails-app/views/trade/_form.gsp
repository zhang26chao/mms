<%@ page import="blog.Trade" %>



<div class="fieldcontain ${hasErrors(bean: tradeInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="trade.type.label" default="Type" />
		
	</label>
	<g:select name="type" from="${tradeInstance.constraints.type.inList}" value="${tradeInstance?.type}" valueMessagePrefix="trade.type" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: tradeInstance, field: 'money', 'error')} required">
	<label for="money">
		<g:message code="trade.money.label" default="Money" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="money" min="1" required="" value="${fieldValue(bean: tradeInstance, field: 'money')}"/>
</div>

