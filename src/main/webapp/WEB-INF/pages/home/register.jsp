<%--
  Created by IntelliJ IDEA.
  User: Polak
  Date: 11/25/13
  Time: 9:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../pagefrags/imports.jsp"/>
    <style>.error {
        color: red;
    }</style>
</head>
<body>
<div class="container">

    <div class="collagewrap">

        <h1>Registration</h1>

        <p class="instructions"><span class="h4">1. Enter your NetId: <input type="text" class="input-lg form-control half" id="username"
                                                                             placeholder="NetId"/>    </span> <br/>
        </p>

        <h4 class="instructions">2. Click the images below to create your PIN. Your PIN must consist of 4 non-repeating images.</h4>

    </div>


    <div class="pics">

    </div>

    <jsp:include page="../pagefrags/footer.jsp"/>
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