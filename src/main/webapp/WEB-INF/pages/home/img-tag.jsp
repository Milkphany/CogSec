<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../pagefrags/imports.jsp"/>
    <link rel="stylesheet" type="text/css" href="/css/tag.css"/>
    <title>Tag Images</title>
</head>
<body>
<div class="container">

    <c:if test="${editable eq true}">
        <div class="status panel panel-primary"><h4><b>Status:</b></h4></div>
    </c:if>

    <jsp:include page="../pagefrags/nav.jsp"/>

    <div class="maincontent">

        <form class="panel panel-default panel-body" method="GET">
            <h4>Display images with less than: </h4>
            <input id="tagReqVal" name="tagReq" class="form-inline form-horizontal" type="text" value="${param.tagReq}"/>
            <input type="submit" class="btn btn-default" id="tagReq" value="Update"/>
        </form>

        <div class="row">

            <c:forEach items="${coglets}" var="coglet">
                <div class="img-tag col-md-3 col-sm-3 col-lg-3 panel-default panel"
                     id="${coglet.path}">
                    <img height="160" src="${coglet.path}"/>
                    <c:set var="size" value="${fn:length(coglet.tags)}"/>
                    <c:forEach items="${coglet.tags}" var="tag" varStatus="counter">
                        <label type="text" class="form-control">${tag.tagName}</label>
                        <c:if test="${editable eq false and counter.count eq size and size < 7}">
                            <c:forEach var="i" begin="0" end="${6 - size}" step="1">
                                <label type="text" class="form-control"></label>
                            </c:forEach>
                        </c:if>
                        <c:if test="${editable eq true and counter.count eq size and size < 7}">
                            <c:forEach var="i" begin="0" end="${6 - size}" step="1">
                                <input type="text" class="form-control" id="tags"/>
                            </c:forEach>
                            <%--<button type="button" class="fat btn btn-default">Add Another</button>--%>
                            <button type="button" class="add-tags fat btn btn-primary">Submit</button>
                        </c:if>
                    </c:forEach>
                </div>
            </c:forEach>
        </div>
    </div>
    <jsp:include page="../pagefrags/footer.jsp"/>
</div>


</body>

<script type="text/javascript">

    $(".add-tags").click(function () {
        var parent = $(this).parent();
        var input = $(parent).children("input");
        var tags = new Array();
        for (var i = 0; i < 4; i++){
             tags.push($(input).val());
            input = $(input).next();
        }

        $.ajax({
            url: "/ajax",
            type: "POST",
            dataType: "html",
            traditional: true,
            data: {
                cogId: $(parent).attr("id"),
                tags: tags
            },
            success: function(sess) {
                var statImg = $(document).find('.status');
                statImg.html(sess).css('color', 'green').css('z-index', '2000');
                setTimeout(function() { statImg.css('z-index', '999');}, 4500);
            }
        });
    })
</script>
</html>