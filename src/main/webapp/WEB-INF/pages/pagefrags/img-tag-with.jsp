<%--
  Created by IntelliJ IDEA.
  User: Milky
  Date: 12/12/13
  Time: 12:48 AM
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="row">

    <c:forEach items="${coglets}" var="coglet">
        <div class="img-tag col-md-2 col-sm-2 col-lg-2"
             id="${coglet.path}">
            <img height="140" src="${coglet.path}"/>
            <c:set var="size" value="${fn:length(coglet.tags)}"/>
            <c:forEach items="${coglet.tags}" var="tag" varStatus="counter">
                <label type="text" class="form-control">${tag.tagName}</label>
                <c:if test="${counter.count eq size and size < 5}">
                    <c:forEach var="i" begin="0" end="${4 - size}" step="1">
                        <label type="text" class="form-control"></label>
                    </c:forEach>
                </c:if>
            </c:forEach>
        </div>
    </c:forEach>
</div>