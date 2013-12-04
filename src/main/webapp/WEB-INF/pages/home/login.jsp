<%--
  Created by IntelliJ IDEA.
  User: Polak
  Date: 11/25/13
  Time: 9:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../pagefrags/imports.jsp"/>
    <style>.error { color: red; }</style>
</head>
<body>
<div class="container">

    <div id='login'>
        <c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
            <div class="error">
                Your login attempt was not successful, try again.<br/>
                Reason: ${SPRING_SECURITY_LAST_EXCEPTION.message}
            </div>
        </c:if>

        <h1>Enter your NetId:</h1>
        <br>
        <br>
            <p>
                <input type='text' class='form-control' name='username' id='username' autofocus="autofocus" placeholder="NetId" required/>
            </p>
            <p>
                <button type='button' class="btn btn-primary fat tall" id="submit">Continue</button>
            </p>
    </div>

   <div class="pics">

   </div>

    <jsp:include page="../pagefrags/footer.jsp"/>
</div>

<script>

    $("#submit").click(function(){
        $('html,body').animate({
            scrollTop: $(".pics").offset().top
        }, 500);
            //  $(".wrapper").removeClass("hidden");
        //$(".Collage").html("<img class='darkencss' src='http://i.imgur.com/ir4Ii.jpg'><img class='darkencss' src='http://i.imgur.com/ir4Ii.jpg'><img class='darkencss' src='http://i.imgur.com/ir4Ii.jpg'><img class='darkencss' src='http://i.imgur.com/ir4Ii.jpg'><img class='darkencss' src='http://i.imgur.com/ir4Ii.jpg'>")
        $(".pics").load("/login2", $("#username"));

    })
</script>
</body>
</html>