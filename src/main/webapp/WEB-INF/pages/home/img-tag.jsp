<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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

    <jsp:include page="../pagefrags/nav.jsp"/>

    <div class="maincontent">

        <div class="status"><h4>Status:</h4></div>

        <div class="row status-top">

            <c:forEach items="${coglets}" var="coglet">
                <div class="img-tag col-md-3 col-sm-3 col-lg-3 panel-default panel"
                     id="${coglet.path}">
                    <img height="160" src="${coglet.path}"/>
                    <c:forEach items="${coglet.tags}" var="tag" varStatus="counter">
                        <label type="text" class="form-control">${tag.tagName}</label>
                        <c:if test="${counter eq coglet.tags.size - 1 and coglet.tags.size < 6}">
                            <c:forEach var="i" begin="0" end="${counter - coglet.tags.size}" step="1">
                                <label type="text" class="form-control"></label>
                            </c:forEach>
                        </c:if>
                    </c:forEach>

                    <c:if test="${editable eq true}">
                        <input type="text" class="form-control" id="tags"/>
                        <input type="text" class="form-control" id="tags"/>
                        <input type="text" class="form-control" id="tags"/>
                        <%--<button type="button" class="fat btn btn-default">Add Another</button>--%>
                        <button type="button" class="add-tags fat btn btn-primary">Submit</button>
                    </c:if>
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
        for (var i = 0; i < 3; i++){
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
                $(document).find('.status').html(sess).css('color', 'green');
            }
        });
    })
</script>
</html>