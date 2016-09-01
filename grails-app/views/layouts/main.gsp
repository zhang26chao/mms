<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="Grails"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
    <g:layoutHead/>
    <r:layoutResources/>
</head>

<body>
<div id="grailsLogo" role="banner">
    <a href="${createLink(uri: '/')}"
       style="font-size: 20px;font-weight: bold;text-decoration: none;color: #ffffff;margin: 15px;">会员管理系统</a>
    <style>
    ul.bar {
        list-style: none;
        float: right;
        margin-right: 15px;
    }

    ul.bar > li {
        display: inline-block;
        line-height: 53px;
    }

    .bar > li > a {
        margin: 0 !important;
        cursor: pointer;
    }

    ul.dropdown-menu {
        position: absolute;
        top: 40px;
        min-width: 96px;
        z-index: 1000;
        display: none;
        list-style: none;
        background-color: #ffffff;
        border: 1px solid #abbf78;
    }

    ul.dropdown-menu > li {
        padding: 5px;
    }

    .dropdown-menu > li > a {
        text-decoration: none;
        margin: 0!important;
        display: block!important;
    }

    .dropdown-menu > li > a:hover {
        color: #000;
    }


    .dropdown-menu .divider {
        overflow: hidden;
        padding: 0px;
        height: 1px;
        background-color: #e5e5e5;
        border-bottom: 1px solid #ffffff;
    }
    </style>
    <ul class="bar"  onmousemove="document.getElementById('menu').style.display = 'block';" onmouseout="document.getElementById('menu').style.display = 'none';">
        <li><a>欢迎你,<sec:username/></a></li>
        <ul class="dropdown-menu" id="menu">
            <li><g:link controller="global" action="password">修改密码</g:link></li>
            <li class="divider"></li>
            <li><g:link
                    controller="logout"
                    onclick="return window.confirm('您确定要退出系统吗？');">退出系统</g:link></li>
        </ul>
    </ul>
</div>
<g:layoutBody/>
<div class="footer" role="contentinfo"></div>

<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
<g:javascript library="application"/>
<r:layoutResources/>
</body>
</html>
<script>
    function displayMenu() {
        var menu = document.getElementById('menu');
        if (menu.style.display == 'none' || menu.style.display == '') {
            menu.style.display = 'block';
        } else {
            menu.style.display = 'none';
        }
    }
    document.documentElement.onclick = function(e) {
        var e = e || window.event;
        var target = e.srcElement || e.target;
        if (target.id && target.id == 'menuBtn') {
            return;
        }
        var menu = document.getElementById('menu');
        if (menu.style.display == 'block') {
            document.getElementById('menu').style.display = 'none';
        }
    }
</script>