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

        <h1 id="login-heading">Enter your NetId:</h1>
        <br>
        <br>
            <p id="username-section">
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

    function collage(){
        $('.Collage').removeWhitespace().collagePlus({
            'targetHeight': 160,
            'allowPartialLastRow': true,
            'direction': 'vertical'
        });
    }

    function recollage() {
        collage();
        // This is just for the case that the browser window is resized
        var resizeTimer = null;
        $(window).bind('resize', function () {
            // hide all the images until we resize them
            $('.Collage .Image_Wrapper').css("opacity", 0);
            // set a timer to re-apply the plugin
            if (resizeTimer) clearTimeout(resizeTimer);
            resizeTimer = setTimeout(collage, 200);
        });

    }

    $("#submit").click(function(event){
        $('#submit').text('Change Username');
        $('#submit').removeClass('btn-primary').addClass('btn-default');
        $('#login').css('padding', '0px 20px').css('max-width', '1080px').css('margin-left', '0px');
        $('#login-heading').hide();

        $('html,body').animate({
            scrollTop: $(".pics").offset().top
        }, 500);
            //  $(".wrapper").removeClass("hidden");
        //$(".Collage").html("<img class='darkencss' src='http://i.imgur.com/ir4Ii.jpg'><img class='darkencss' src='http://i.imgur.com/ir4Ii.jpg'><img class='darkencss' src='http://i.imgur.com/ir4Ii.jpg'><img class='darkencss' src='http://i.imgur.com/ir4Ii.jpg'><img class='darkencss' src='http://i.imgur.com/ir4Ii.jpg'>")
        $(".pics").load("/login2", $("#username"), function() {

            setTimeout(recollage, 50);
        });

    })
</script>
</body>
</html>