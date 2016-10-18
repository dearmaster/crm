<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();
%>
<html>
<head>
    <title>This is index page</title>

    <link rel="stylesheet" href="<%= ctx%>/css/bootstrap.css">
    <link rel="stylesheet" href="<%= ctx%>/css/crm.css">
    <script src="<%= ctx%>/js/jquery-2.1.1.js"></script>
    <script src="<%= ctx%>/js/bootstrap.js"></script>

</head>
<body>
<div>
    <form class="form-inline" role="form" method="post" action="<%= ctx%>/user/register.do">
        <label>
            用户名&#12288;<input type="text" class="form-control" name="credential.username">
        </label>
        <br>
        <label>
            密&#12288;码&#12288;<input type="password" class="form-control" name="credential.password">
        </label>
        <br>
        <label>
            性&#12288;别&#12288;&#12288;&#12288;
            <input type="radio" name="user.gender" value="男">男&#12288;&#12288;
            <input type="radio" name="user.gender" value="女" checked>女
        </label>
        <br>
        <label>
            住&#12288;址&#12288;<input type="text" class="form-control" name="user.address">
        </label>
        <br>
        <label>
            邮&#12288;箱&#12288;<input type="text" class="form-control" name="user.mail">
        </label>
        <br>
        <label>
            电&#12288;话&#12288;<input type="text" class="form-control" name="user.phone">
        </label>
        <br>
        <label>
            生&#12288;日&#12288;<input type="text" class="form-control" name="user.birthday">
        </label>
        <br>
        &#12288;&#12288;&#12288;&#12288;
        <button type="reset">重置</button>&#12288;&#12288;&#12288;
        <button type="submit">注册</button>
    </form>
</div>
</body>
</html>