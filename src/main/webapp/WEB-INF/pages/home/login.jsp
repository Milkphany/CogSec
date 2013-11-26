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


</head>
<body>
<div class="container">

    <div id='login'>

        <h1>Enter your NetId:</h1>
        <br>
        <br>


            <p>
                <input type='text' class='form-control' name='username' id='username' autofocus="autofocus" placeholder="NetId" required/>
            </p>

                    <p>
                <input type='submit' class="btn btn-primary fat tall" id="submit" value='Continue'  href="/login2"/>
            </p>

    </div>


    <jsp:include page="../pagefrags/footer.jsp"/>
</div>



</body>
</html>