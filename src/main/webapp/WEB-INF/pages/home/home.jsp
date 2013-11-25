<%--
  User: milky
  Date: 11/25/13
  Time: 11:49 AM
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
        <c:if test="${not empty newuser}">
            <p>Made a user, his name is: ${newuser.username}</p>
        </c:if>
        <h2>Registration form</h2>
        <div id="Registration">
            <form:form commandName="user" action="/new">
                <table>
                    <tr>
                        <td>NetID:</td>
                        <td><form:input path="username" /></td>
                    </tr>
                </table>
                <input type="submit" value="Register" />
            </form:form>
        </div>
        <h2>All users</h2>
        <div>
            <table>
                <tr><th>Name</th></tr>
                <c:if test="${not empty users}">
                    <c:forEach var="useracc" items="${users}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${useracc.username}</td>
                        </tr>
                    </c:forEach>
                </c:if>
            </table>
        </div>
    </div>

    <jsp:include page="../pagefrags/footer.jsp"/>
</div>

</div>
</body>
</html>