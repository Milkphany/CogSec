<%--
  Created by IntelliJ IDEA.
  User: Milky
  Date: 12/8/13
  Time: 8:58 PM
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../pagefrags/imports.jsp"/>
</head>
<body>
<div class="container">
    <jsp:include page="../pagefrags/nav.jsp"/>

    <div class="row maincontent">
        There was an error with this page. Issue has been reported to the administrator!</br>
        Please return to the <a href="/">home</a> page. Thank you.
    </div>
    
    <jsp:include page="../pagefrags/footer.jsp"/>
</div>
</body>
</html>