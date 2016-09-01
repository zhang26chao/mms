<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'report.label', default: 'Report')}"/>
    <r:require module="datepicker"/>
    <title>${noticeInstance.title}</title>
</head>

<body>
<a href="#list-trade" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                            default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
    </ul>
</div>

<div id="list-trade" class="content scaffold-list" role="main" style="padding: 0 10px;">
    <h2 style="text-align: center;margin:10px 0;">${noticeInstance.title}</h2>
    <div style="border-top: 1px solid #DFDFDF;border-bottom: 1px solid #DFDFDF;padding: 10px;">
        ${noticeInstance.content}
    </div>
    <div style="text-align: right;margin:10px 0;"><g:formatDate date="${noticeInstance.dateCreated}"
                                                 format="yyyy-MM-dd HH:mm:ss"/></div>
</div>
</body>
</html>