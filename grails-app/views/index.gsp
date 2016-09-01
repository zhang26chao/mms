<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>欢迎使用会员管理系统</title>
    <style type="text/css" media="screen">
    #status {
        background-color: #eee;
        border: .2em solid #fff;
        margin: 2em 2em 1em;
        padding: 1em;
        width: 12em;
        float: left;
        -moz-box-shadow: 0px 0px 1.25em #ccc;
        -webkit-box-shadow: 0px 0px 1.25em #ccc;
        box-shadow: 0px 0px 1.25em #ccc;
        -moz-border-radius: 0.6em;
        -webkit-border-radius: 0.6em;
        border-radius: 0.6em;
    }

    .ie6 #status {
        display: inline; /* float double margin fix http://www.positioniseverything.net/explorer/doubled-margin.html */
    }

    #status ul {
        font-size: 0.9em;
        list-style-type: none;
        margin-bottom: 0.6em;
        padding: 0;
    }

    #status ul li{
        font-size: 1em;
        padding: 5px 0;
    }

    #status ul li a{
        text-decoration: none;
    }

    #status h1 {
        text-transform: uppercase;
        font-size: 1.1em;
        margin: 0 0 0.3em;
    }

    #page-body {
        margin: 2em 1em 1.25em 18em;
    }

    h2 {
        margin-top: 1em;
        margin-bottom: 0.3em;
        font-size: 1em;
    }

    p {
        margin: 0.25em 0;
    }

    #controller-list ul {
        list-style-position: inside;
    }

    #controller-list li {
        list-style-position: inside;
        margin: 0.25em 0;
    }

    @media screen and (max-width: 480px) {
        #status {
            display: none;
        }

        #page-body {
            margin: 0 1em 1em;
        }

        #page-body h1 {
            margin-top: 0;
        }
    }
    </style>
</head>

<body>
<a href="#page-body" class="skip"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

<div id="status" role="complementary" style="box-shadow:0 0 0 #fff;border-radius:0;border: 0;height: 353px;">
    <h1>系统功能</h1>
    <ul>
        <li class="controller"><g:link controller="member">会员管理</g:link></li>
        <li class="controller"><g:link controller="gift">礼品管理</g:link></li>
        <li class="controller"><g:link controller="trade">交易管理</g:link></li>
        <li class="controller"><g:link controller="notice">公告管理</g:link></li>
        <li class="controller"><g:link controller="report">交易报表</g:link></li>
        <li class="controller"><g:link controller="report" action="member">会员报表</g:link></li>
        <sec:ifAllGranted roles="ROLE_ADMIN">
            <li class="controller"><g:link controller="user">用户管理</g:link></li>
        </sec:ifAllGranted>
    </ul>
</div>

<div id="page-body" role="main">

    <div id="controller-list" role="navigation">
        <h2>公告栏</h2>
        <table style="width: 99%;font-size: 0.9em">
            <g:each in="${noticeInstanceList}" status="i" var="noticeInstance">
                <tr style="border-top: 1px dashed #DFDFDF;">
                    <td style="text-align: left;padding-left: 0em;"><g:link
                            controller="global" action="detail" id="${noticeInstance.id}"
                            style="text-decoration: none">${noticeInstance.title}</g:link></td>

                    <td style="text-align: right;padding-right: 0em;"><g:formatDate date="${noticeInstance.dateCreated}"
                                                                                    format="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
            </g:each>
        </table>
    </div>
</div>
</body>
</html>
