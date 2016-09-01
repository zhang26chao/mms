<%@ page import="blog.Member" %>



<div class="fieldcontain ${hasErrors(bean: memberInstance, field: 'cardNo', 'error')} required">
	<label for="cardNo">
		<g:message code="member.cardNo.label" default="Card No" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="cardNo" required="" value="${memberInstance?.cardNo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: memberInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="member.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${memberInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: memberInstance, field: 'sex', 'error')} ">
	<label for="sex">
		<g:message code="member.sex.label" default="Sex" />
		
	</label>
	<g:select name="sex" from="${memberInstance.constraints.sex.inList}" value="${memberInstance?.sex}" valueMessagePrefix="member.sex" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: memberInstance, field: 'birthDay', 'error')} ">
	<label for="birthDay">
		<g:message code="member.birthDay.label" default="Birth Day" />
		
	</label>
	<g:datePicker name="birthDay" precision="day"  value="${memberInstance?.birthDay}" default="none" noSelection="['': '']" relativeYears="[-80..0]" />
</div>

<div class="fieldcontain ${hasErrors(bean: memberInstance, field: 'phoneNumber', 'error')} ">
	<label for="phoneNumber">
		<g:message code="member.phoneNumber.label" default="Phone Number" />
		
	</label>
	<g:textField name="phoneNumber" value="${memberInstance?.phoneNumber}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: memberInstance, field: 'balance', 'error')} required">
	<label for="balance">
		<g:message code="member.balance.label" default="Balance" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="balance" required="" value="${memberInstance.balance}"/>
</div>

