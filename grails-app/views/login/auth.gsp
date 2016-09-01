<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <title><g:message code="springSecurity.login.title"/></title>
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'login', file: 'style_log.css')}">
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'login', file: 'style.css')}">
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'login', file: 'userpanel.css')}">

</head>

<body class="login" mycollectionplug="bind">
<div class="login_m">
    <g:if test='${flash.message}'>
        <div class='login_logo' style="color: red;">${flash.message}</div>
    </g:if>
    <div class="login_boder">
        <form action='${postUrl}' method='POST' id='loginForm' class='cssform' autocomplete='off'>
        <div class="login_padding" id="login_model">

            <h2>用户名</h2>
            <label>
                <input type="text" id="username" name="j_username" class="txt_input txt_input2" placeholder="用户名">
            </label>

            <h2>密码</h2>
            <label>
                <input type="password" name="j_password" id="userpwd" class="txt_input" placeholder="密码">
            </label>


            <div class="rem_sub">
                <div class="rem_sub_l">
                    <input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>
                    <label for='remember_me'><g:message code="springSecurity.login.remember.me.label"/></label>
                </div>
                <label>
                    <input type="submit" class="sub_button" name="button" id="button" value="登录"
                           style="opacity: 0.7;">
                </label>
            </div>
        </div>
        </form>






        <!--login_padding  Sign up end-->
    </div><!--login_boder end-->
</div><!--login_m end-->
<br> <br>

</body></html>