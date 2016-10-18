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
    <jsp:include page="header.jsp"/>
</body>
</html>
