<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();
%>
<html>
<head>
    <title>This is index page</title>

    <link rel="stylesheet" href="<%= ctx%>/css/bootstrap.css">
    <link rel="stylesheet" href="<%= ctx%>/css/bootstrap-datetimepicker.css">
    <link rel="stylesheet" href="<%= ctx%>/css/crm.css">
    <script src="<%= ctx%>/js/jquery-2.1.1.js"></script>
    <script src="<%= ctx%>/js/bootstrap.js"></script>
    <script src="<%= ctx%>/js/bootstrap-datetimepicker.js"></script>
    <script src="<%= ctx%>/js/bootstrap-datetimepicker.zh-CN.js"></script>

    <script type="text/javascript">
        $(function () {
            $(".form_datetime").datetimepicker({
                format: "yyyy-mm-dd",
                autoclose: true,
                todayBtn: true,
                todayHighlight: true,
                showMeridian: true,
                pickerPosition: "bottom-left",
                language: 'zh-CN',//中文，需要引用zh-CN.js包
                startView: 2,//月视图
                minView: 2//日期时间选择器所能够提供的最精确的时间选择视图
            });
        });
    </script>
</head>
<body>
<div>
    <form class="form-inline" role="form" method="post" action="<%= ctx%>/user/register.do">
        用户名&#12288;<input type="text" class="form-control" name="credential.username">
        <br>
        密&#12288;码&#12288;<input type="password" class="form-control" name="credential.password">
        <br>
        性&#12288;别&#12288;&#12288;&#12288;
        <input type="radio" name="user.gender" value="男">男&#12288;&#12288;
        <input type="radio" name="user.gender" value="女" checked>女
        <br>
        住&#12288;址&#12288;<input type="text" class="form-control" name="user.address">
        <br>
        邮&#12288;箱&#12288;<input type="text" class="form-control" name="user.mail">
        <br>
        电&#12288;话&#12288;<input type="text" class="form-control" name="user.phone">
        <br>
        生&#12288;日&#12288;<input class="form_datetime form-control" type="text" name="user.birthday" value="2016-03-07" readonly>
        <br>
        &#12288;&#12288;&#12288;&#12288;
        <button type="reset">重置</button>&#12288;&#12288;&#12288;
        <button type="submit">注册</button>
    </form>
</div>
</body>
</html>