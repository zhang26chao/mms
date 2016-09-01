<%@ page import="blog.Member" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'member.label', default: 'Member')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<a href="#list-member" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                             default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label"
                                                              args="[entityName]"/></g:link></li>
        <li><g:link class="export" action="import">批量导入</g:link></li>
    </ul>
</div>

<div style="padding: 10px;text-align: right;">
    <g:form action="list">
        <style>
        table.search {
            border: 1px solid #cccccc;
            margin-bottom: 0;
        }

        table.search tr:hover {
            background: none;
        }
        </style>
        <table class="search">
            <tr>
                <td>
                    <label for="cardNo">
                        <g:message code="member.cardNo.label" default="cardNo"/>
                    </label>
                    <g:textField name="cardNo" value="${params.cardNo}"/>
                </td>
                <td>
                    <label for="name">
                        会员名称
                    </label>
                    <g:textField name="name" value="${params.name}"/>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: right">
                    <input name="operator" type="submit" value="查询"/>
                    <input style="margin-left: 10px" name="operator" type="submit" value="导出"/>
                </td>
            </tr>
        </table>
    </g:form>
</div>

<div id="list-member" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table>
        <thead>
        <tr>

            <g:sortableColumn property="cardNo" title="${message(code: 'member.cardNo.label', default: 'Card No')}"/>

            <g:sortableColumn property="name" title="${message(code: 'member.name.label', default: 'Name')}"/>

            <g:sortableColumn property="birthDay"
                              title="${message(code: 'member.birthDay.label', default: 'Birth Day')}"/>

            <g:sortableColumn property="phoneNumber"
                              title="${message(code: 'member.phoneNumber.label', default: 'Phone Number')}"/>

            <g:sortableColumn property="balance" title="${message(code: 'member.balance.label', default: 'Balance')}"/>

            <g:sortableColumn property="grade" title="${message(code: 'member.grade.label', default: 'Grade')}"/>

            <th>操作</th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${memberInstanceList}" status="i" var="memberInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${memberInstance.id}">${fieldValue(bean: memberInstance, field: "cardNo")}</g:link></td>

                <td>${fieldValue(bean: memberInstance, field: "name")}</td>

                <td><g:formatDate date="${memberInstance.birthDay}" format="yyyy-MM-dd"/></td>

                <td>${fieldValue(bean: memberInstance, field: "phoneNumber")}</td>

                <td>${fieldValue(bean: memberInstance, field: "balance")}</td>
                <g:if test="${memberInstance.grade > 0}">
                    <td><g:link controller="gift" action="list"
                                title="兑换礼品">${fieldValue(bean: memberInstance, field: "grade")}</g:link></td>
                </g:if>
                <g:if test="${memberInstance.grade == 0}">
                    <td>${fieldValue(bean: memberInstance, field: "grade")}</td>
                </g:if>
                <td>
                    <g:link action="recharge" id="${memberInstance.id}">充值</g:link>
                    |
                    <g:link action="consume" id="${memberInstance.id}">消费</g:link>
                    |
                    <g:link action="exchangeList" id="${memberInstance.id}">积分兑换记录</g:link>
                </td>

            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${memberInstanceTotal}"/>
    </div>
</div>
</body>
</html>
