<%@ page import="blog.Gift" %>



<div class="fieldcontain ${hasErrors(bean: giftInstance, field: 'no', 'error')} required">
	<label for="no">
		<g:message code="gift.no.label" default="No" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="no" required="" value="${giftInstance?.no}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: giftInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="gift.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${giftInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: giftInstance, field: 'total', 'error')} required">
	<label for="total">
		<g:message code="gift.total.label" default="Total" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="total" required="" value="${fieldValue(bean: giftInstance, field: 'total')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: giftInstance, field: 'grade', 'error')} required">
	<label for="grade">
		<g:message code="gift.grade.label" default="Grade" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="grade" required="" value="${giftInstance.grade}"/>
</div>

