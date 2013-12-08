<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../pagefrags/imports.jsp"/>
    <title>Tag Images</title>
</head>
<body>
<div class="container">

    <div class="maincontent">

        <h1>Image Tagging</h1>



        <div class="row">
            <c:forEach items="${coglets}" var="coglet">
            <div class="img-tag col-md-3 panel-default panel">
                <img height="170" src="http://wontoncode.com${coglet.path}"/>
                <c:forEach items="${coglet.tags}" var="tag">
                    <input type="text" value="${tag.tagName}" class="form-control" />
                </c:forEach>
                <input type="text" class="form-control" />
                <input type="text" class="form-control" />
                <input type="text" class="form-control" />
                <button type="button" class="fat btn btn-default">Add Another</button>
                <button type="button" class="fat btn btn-primary">Submit</button>
            </div>
            </c:forEach>

    </div>
    <jsp:include page="../pagefrags/footer.jsp"/>
</div>


</body>
</html>