<%@ page import="blog.Trade" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'trade.label', default: 'Trade')}"/>
    <r:require module="datepicker"/>
    <r:script>
        $(function () {
            $("#beginDate,#endDate").datepicker();
        });
    </r:script>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<a href="#list-trade" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                            default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
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
                <td><label for="type">
                    <g:message code="trade.type.label" default="type"/>
                </label><g:select name="type" from="${['充值','消费']}" value="${params.type}"
                                  keys="${['充值','消费']}"
                                  noSelection="${['':'']}" id="type" style="margin-left: 4px;"/></td>
                <td>
                    <label for="cardNo">
                        <g:message code="member.cardNo.label" default="cardNo"/>
                    </label>
                    <g:textField name="cardNo" value="${params.cardNo}"/>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="beginDate">
                        开始日期
                    </label>
                    <g:textField name="beginDate" value="${params.beginDate}"/>
                </td>
                <td>
                    <label for="endDate">
                        结束日期
                    </label>
                    <g:textField name="endDate" value="${params.endDate}"/>
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

<div id="list-trade" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table>
        <thead>
        <tr>

            <g:sortableColumn property="type" title="${message(code: 'trade.type.label', default: 'Type')}"/>

            <g:sortableColumn property="money" title="${message(code: 'trade.money.label', default: 'Money')}"/>

            <g:sortableColumn property="dateCreated"
                              title="${message(code: 'trade.dateCreated.label', default: 'Date Created')}"/>

            <g:sortableColumn property="member.cardNo"
                              title="${message(code: 'member.cardNo.label', default: 'cardNo')}"/>

        </tr>
        </thead>
        <tbody>
        <g:each in="${tradeInstanceList}" status="i" var="tradeInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td>${fieldValue(bean: tradeInstance, field: "type")}</td>

                <td>${fieldValue(bean: tradeInstance, field: "money")}</td>

                <td><g:formatDate date="${tradeInstance.dateCreated}" format="yyyy-MM-dd HH:mm:ss"/></td>

                <td><g:link controller="member" action="show"
                            id="${tradeInstance.member.id}">${fieldValue(bean: tradeInstance.member, field: "cardNo")}</g:link></td>

            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${tradeInstanceTotal}" params="${params}"/>
    </div>
</div>
</body>
</html>
