<%--
  User: milky
  Date: 11/25/13
  Time: 11:49 AM
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
        <sec:authorize access="isAnonymous()">
            <div id="Registration" class="panel panel-default">
                <div class="collagewrap panel-body">
                    <%--<h1>Cognometric Analysis</h1>
                    <p class="instructions">Cognometric passwords are passwords using non text authentication.</br>
                        This is a study of recognizability and communicability of image passwords.</br>
                        Please start the registration process by entering your netId, or alternatively login at the top right.</p>


                    <p class="instructions">
                        <span class="h4">1. Enter your NetId: <input type="text" class="input-lg form-control half" id="username"
                                                                     autofocus="autofocus" placeholder="NetId"/></span></br></br>
                        <span class="h4">2. Enter your email address:
                            <input type="email" class="input-lg form-control half" id="email" placeholder="Email Address"></span>
                        <button class="btn btn-lg btn-default" type="button" id="continue">Continue</button><br/>
                    </p>

                    <h4 class="instructions">3. Click the images below to create your PIN. Your PIN must consist of 4 non-repeating images.</h4>--%>

                        <h4><p class="instructions">Part 1 of experiment is unfortunately over! You will no longer be able to make an account.</p></h4>
                        <h4><p class="instructions">Part 2 of the experiment entails attempting to log in. Please try as many times as allowed to login.</p></h4>
                    <jsp:include page="login.jsp" />

                </div>
                <%--<div class="pics panel-body">
                </div>--%>
            </div>
        </sec:authorize>

        <sec:authorize access="hasRole('ROLE_USER')">
            <div class="panel panel-default">
                <div class="panel-body">
                    <c:choose>
                        <c:when test="${logUser.survey == null}">
                            <h2>Please fill out the survey below</h2>

                            <div id="survey">
                                <script>
                                    $('#survey').load('/surveys .collagewrap')
                                </script>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <h1>Your survey response:</h1>

                            <p></p>
                            <table class="table table-bordered">
                                <tr>
                                    <th>NetID</th>
                                    <th>Age</th>
                                    <th>Major</th>
                                    <th>Difficulties Creating Account</th>
                                </tr>
                                <tr>
                                    <td>${logUser.username}</td>
                                    <td>${logUser.survey.age}</td>
                                    <td>${logUser.survey.major}</td>
                                    <td>${logUser.survey.difficultyCreate}</td>
                                </tr>
                            </table>
                            <h1>Survey Agreement</h1>

                            <div>
                                <jsp:include page="informed-consent.jsp"/>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </sec:authorize>

        <sec:authorize access="hasRole('ROLE_ADMIN')">
            <div class="panel panel-default">
                <div class="panel-body">
                    <h2>All users</h2>

                    <div>
                        <table>
                            <tr>
                                <th>Name</th>
                            </tr>
                            <c:if test="${not empty users}">
                                <c:forEach var="useracc" items="${users}" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td>${useracc.username}</td>
                                        <td>
                                            <ul style="list-style-type: none">
                                                <c:forEach var="userpass" items="${useracc.password}">
                                                    <li style="display: inline-block"><img class="user-pass" src="${userpass.path}"/></li>
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
                            <tr>
                                <th>Image Path</th>
                            </tr>
                            <c:if test="${not empty coglets}">
                                <c:forEach var="coglet" items="${coglets}" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td>${coglet.path}</td>
                                        <td>
                                            <c:forEach var="cogtag" items="${coglet.tags}">
                                                ${cogtag.tagName}
                                            </c:forEach>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </table>
                    </div>
                </div>
            </div>
        </sec:authorize>
    </div>

    <jsp:include page="../pagefrags/footer.jsp"/>
</div>

</div>
<script>
    $(document).ready(function() {
        $('#login').css('padding-top', '0px');
    });
</script>

<%--<script>
    function collage(){
        $('.Collage').removeWhitespace().collagePlus({
            'targetHeight': 160,
            'allowPartialLastRow': true,
            'direction': 'vertical'
        });
    }

    function recollage() {
        collage();

        var resizeTimer = null;
        $(window).bind('resize', function () {
            // hide all the images until we resize them
            $('.Collage .Image_Wrapper').css("opacity", 0);
            // set a timer to re-apply the plugin
            if (resizeTimer) clearTimeout(resizeTimer);
            resizeTimer = setTimeout(collage, 200);
        });
    }

    $("#continue").click(function () {
        $('html,body').animate({
            scrollTop: $(".pics").offset().top
        }, 500);

        $(".pics").load("/register-photos?username="+$('#username').val(), function () {
            setTimeout(recollage, 50);
            $("#hidden-uname").val($("#username").val())
            $("#hidden-email").val($("#email").val())
        });
    })
</script>--%>
</body>
</html>