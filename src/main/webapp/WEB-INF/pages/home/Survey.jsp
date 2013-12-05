<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../pagefrags/imports.jsp"/>
    <title>Survey</title>
</head>
<body>
<div class="container">

    <div class="collagewrap">

        <h1>Survey</h1>

        <p class="instructions"><span class="h4">Please complete this short questionnaire.</span> <br/>

        <sec:authorize access="isAuthenticated()">
            <h2>Thank you for your participation!</h2>
        </sec:authorize>
        <sec:authorize access="isAnonymous()">
            <h2>You're not logged in!</h2>
        </sec:authorize>
        <form method="POST">
            <ol class="survey">
                <li>Did you encounter any difficulties while trying to create your PIN? If so, what were they?
                    <textarea required name="difficulties-creating" class="form-control" rows="3"></textarea>
                </li>
                <li>Did you encounter any difficulties while trying to log in with your new PIN? If so, what were they?
                    <textarea required name="difficulties-login" class="form-control" rows="3"></textarea>
                </li>
                <li>
                    How old are you?
                    <select required name="age" class="form-inline">
                        <c:forEach var="i" begin="16" end="40" step="1">
                            <option value="${i}">${i}</option>
                        </c:forEach>
                    </select>
                </li>
                <li>
                    What is your major?
                    <input type="text" class="form-control" required name="major"/>
                </li>

                <li>
                    How many credits are you currently taking?
                    <select required name="credits" class="form-inline">
                        <c:forEach var="i" begin="1" end="24" step="1">
                            <option value="${i}">${i}</option>
                        </c:forEach>
                    </select>
                </li>

                <li>
                    On average, about how many hours a day do you spend in class?
                    <select required name="class-hours" class="form-inline">
                        <option value="0-4">Between 0 and 4 hours</option>
                        <option value="5-8">Between 5 and 8 hours</option>
                        <option value="9">9 or more hours</option>
                    </select>
                </li>

                <li>
                    On average, about how many hours a day do you spend commuting to work or school?
                    <select required name="commute-hours" class="form-inline">
                        <option value="0-.5">Less than 1 hour</option>
                        <option value="1">1 hour</option>
                        <option value="2">Between 1 and 2 hours</option>
                        <option value="3">3 or more hours</option>
                    </select>
                </li>

                <li>
                    On average, about how many hours a day do you spend on the computer?
                    <select required name="computer-hours" class="form-inline">
                        <option value="0-4">Between 0 and 4 hours</option>
                        <option value="5-8">Between 5 and 8 hours</option>
                        <option value="9-12">Between 9 and 12 hours</option>
                        <option value="13">13 or more hours</option>
                    </select>
                </li>

            </ol>
            <input type="submit" class="login btn btn-primary fat" value="Submit"/>
        </form>

        </p>


    </div>


    <jsp:include page="../pagefrags/footer.jsp"/>
</div>


</body>
</html>