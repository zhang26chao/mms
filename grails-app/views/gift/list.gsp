<%@ page import="blog.Gift" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'gift.label', default: 'Gift')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<a href="#list-gift" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                           default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label"
                                                              args="[entityName]"/></g:link></li>
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
                    <label for="no">
                        <g:message code="gift.no.label" default="no"/>
                    </label>
                    <g:textField name="no" value="${params.no}"/>
                </td>
                <td>
                    <label for="name">
                        <g:message code="gift.name.label" default="name"/>
                    </label>
                    <g:textField name="name" value="${params.name}"/>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="grade">
                        积分
                    </label>
                    <g:select name="grade" from="${['0-100','100-500','500-1000','1000-5000','5000以上']}"
                              value="${params.grade}" keys="${[0,1,2,3,4]}"
                              noSelection="${['':'选择积分']}" id="grade"/>
                </td>
                <td>
                    <label for="status">
                        状态
                    </label>
                    <g:select name="status" from="${['有货','无货']}" value="${params.status}" keys="${[1,0]}"
                              noSelection="${['':'全部']}" id="status"/>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: right">
                    <input name="operator" type="submit" value="查询"/>
                </td>
            </tr>
        </table>
    </g:form>
</div>

<div id="list-gift" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table>
        <thead>
        <tr>

            <g:sortableColumn property="no" title="${message(code: 'gift.no.label', default: 'No')}"/>

            <g:sortableColumn property="name" title="${message(code: 'gift.name.label', default: 'Name')}"/>

            <g:sortableColumn property="total" title="${message(code: 'gift.total.label', default: 'Total')}"/>

            <g:sortableColumn property="grade" title="${message(code: 'gift.grade.label', default: 'Grade')}"/>

            <th>操作</th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${giftInstanceList}" status="i" var="giftInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${giftInstance.id}">${fieldValue(bean: giftInstance, field: "no")}</g:link></td>

                <td>${fieldValue(bean: giftInstance, field: "name")}</td>

                <td>${fieldValue(bean: giftInstance, field: "total")}</td>

                <td>${fieldValue(bean: giftInstance, field: "grade")}</td>

                <td>
                    <g:link action="exchangeList" id="${giftInstance.id}">查看兑换记录</g:link>
                    <g:if test="${giftInstance.total >0}">
                        |
                        <g:link action="exchange" id="${giftInstance.id}">兑换</g:link>
                    </g:if>
                </td>

            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${giftInstanceTotal}" params="${params}"/>
    </div>
</div>
</body>
</html>
