<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Milky
  Date: 10/18/13
  Time: 1:10 AM
--%>
<nav class="navbar navbar-default" role="navigation">
    <div class="navbar-header">
        <a class="navbar-brand" href="/">Home</a>
    </div>
    <div class="collapse navbar-collapse">
        <sec:authorize access="hasRole('ROLE_ADMIN')">
            <ul class="nav navbar-nav">
                <li><a href="/tag">Tag Images</a></li>
                <li><a href="/tagged">Tagged Images</a></li>
            </ul>
        </sec:authorize>
        <ul class="nav navbar-nav navbar-right">
            <sec:authorize access="isAuthenticated()">
                <li><a href="/">${currentUser}</a></li>
                <li><a href="/logout">Logout</a></li>
            </sec:authorize>
            <sec:authorize access="isAnonymous()">
                <li><a href="/login">Login</a></li>
            </sec:authorize>
        </ul>
    </div>
</nav>