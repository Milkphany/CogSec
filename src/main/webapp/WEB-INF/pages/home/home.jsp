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
        <c:if test="${not empty error}">
            <h3 class="form-error">${error}</h3>
        </c:if>
        <div id="Registration">
            <%--<form:form commandName="user" action="/new">
                <table>
                    <tr>
                        <td>NetID:</td>
                        <td><form:input path="username" /></td>
                    </tr>
                </table>
                <input type="submit" value="Register" />
            </form:form>--%>

            <div class="collagewrap">
                <h1>Registration</h1>
                <p class="instructions">
                    <span class="h4">1. Enter your NetId: <input type="text" class="input-lg form-control half" id="username" placeholder="NetId"/></span> <br/>
                </p>

                <h4 class="instructions">2. Click the images below to create your PIN. Your PIN must consist of 4 non-repeating images.</h4>
                <c:forEach var="choice" items="${specific}">
                    ${choice.path}
                </c:forEach>
            </div>

            <div class="pics">

            </div>
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
                            <td>
                                <ul style="list-style-type: none">
                                    <c:forEach var="userpass" items="${useracc.password}">
                                        <li style="display: inline-block"><img src="${userpass.path}"/></li>
                                    </c:forEach>
                                </ul>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
            </table>
        </div>
        <h2>All images</h2>
        <div>
            <table>
                <tr><th>Image Path</th></tr>
                <c:if test="${not empty coglets}">
                    <c:forEach var="coglet" items="${coglets}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${coglet.path}</td>
                            <td>
                                <c:forEach var="cogtag" items="${coglet.tags}" >
                                    ${cogtag.tagName}
                                </c:forEach>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
            </table>
        </div>
    </div>

    <jsp:include page="../pagefrags/footer.jsp"/>
</div>

</div>

<script>
    $(".pics").load("/register-photos");

    $(".potato").click(function () {
        $('html,body').animate({
            scrollTop: $(".pics").offset().top
        }, 500);
        //  $(".wrapper").removeClass("hidden");
        //$(".Collage").html("<img class='darkencss' src='http://i.imgur.com/ir4Ii.jpg'><img class='darkencss' src='http://i.imgur.com/ir4Ii.jpg'><img class='darkencss' src='http://i.imgur.com/ir4Ii.jpg'><img class='darkencss' src='http://i.imgur.com/ir4Ii.jpg'><img class='darkencss' src='http://i.imgur.com/ir4Ii.jpg'>")
        $(".pics").load("/login2");
        var username = $("#username").val();
        $("input[id=img" + i + "]").val(username);

    })

    $("img").click(function () {
        console.log("MEOWW");
    })

    $("#submit").click(function () {
        var username = $("#username").val();
        $("input[id=img" + i + "]").val(username);
    });
</script>
</body>
</html>