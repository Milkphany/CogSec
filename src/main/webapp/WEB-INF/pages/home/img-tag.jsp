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

        <h2 id="potato"></h2>


        <div class="row">

            <c:forEach items="${coglets}" var="coglet">
                <div class="img-tag col-md-3 col-sm-3 col-lg-3 panel-default panel"
                     id="${coglet.path}">
                    <img height="160" src="http://wontoncode.com${coglet.path}"/>
                    <c:forEach items="${coglet.tags}" var="tag">
                        <input type="text" value="${tag.tagName}" class="form-control"/>
                    </c:forEach>
                    <input type="text" class="form-control" name="tag1"/>
                    <input type="text" class="form-control tag2"/>
                    <input type="text" class="form-control tag3"/>
                    <input type="text" class="form-control tag4"/>
                    <button type="button" class="fat btn btn-default">Add Another</button>
                    <button type="button" class="add-tags fat btn btn-primary">Submit</button>
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
        for (var i = 0; i < 5; i++){
             tags.push($(input).val());
            input = $(input).next();
        }

        var request = $.ajax({
            url: "/ajax",
            type: "GET",
            data: { cogId: $(parent).attr("id") }
        });

        request.done(function(msg) {
            console.log("DATA SENT TO SERVERRRRRR");

            $("#potato").text("bark") ;
        });


    })
</script>
</html>