<%@ page import="blog.Member" %>
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
        <li><g:link class="list" action="list">会员列表</g:link></li>
        <li><g:link class="export" action="exportGift" id="${params.id}">导出</g:link></li>
    </ul>
</div>

<div id="list-gift" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table>
        <thead>
        <tr>

            <g:sortableColumn property="member.cardNo" title="会员卡号"/>

            <g:sortableColumn property="gift.cardNo" title="礼品卡号"/>

            <g:sortableColumn property="num" title="兑换数量"/>

        </tr>
        </thead>
        <tbody>
        <g:each in="${memberGiftInstanceList}" status="i" var="memberGiftInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link controller="member" action="show"
                            id="${memberGiftInstance.member.id}">${fieldValue(bean: memberGiftInstance.member, field: "cardNo")}</g:link></td>

                <td><g:link controller="gift" action="show"
                            id="${memberGiftInstance.gift.id}">${fieldValue(bean: memberGiftInstance.gift, field: "no")}</g:link></td>

                <td>${fieldValue(bean: memberGiftInstance, field: "num")}</td>

            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${memberGiftInstanceTotal}" params="${params}"/>
    </div>
</div>
</body>
</html>
