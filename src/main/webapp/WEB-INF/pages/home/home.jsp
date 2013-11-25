<%--
  User: milky
  Date: 11/25/13
  Time: 11:49 AM
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../pagefrags/imports.jsp"/>
</head>
<body>
<div class="container">

    <jsp:include page="../pagefrags/nav.jsp"/>

    <div class="maincontent">
        <h2><a href="/new">Insert a person!</a></h2>
        <c:if test="${not empty useraccount}">
            <p>Made a user, his name is: ${useraccount.username}</p>
        </c:if>

    </div>

    <jsp:include page="../pagefrags/footer.jsp"/>
</div>

</div>
</body>
</html>