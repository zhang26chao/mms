<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 13-8-10
  Time: 下午8:10
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>JQuery Example</title>
    <r:require module="jquery"/>
    <r:script disposition="head">
        alert(1);
    </r:script>
    <!--jquery的disposition=head，所以这里会引入jquery-->
    <!--r:script的disposition="head"，所以脚本片段会在这里输出-->
    <r:layoutResources/>
</head>

<body>
hello,jquery!
</body>
<r:require module="application"/>
<r:script>
    alert(2);
</r:script>
<!--application的disposition=defer，所以这里会引入application.js-->
<!--r:script的disposition默认是defer，所以这里脚本片段会输出 -->
<r:layoutResources/>
</html>