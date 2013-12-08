<jsp:include page="../pagefrags/imports.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript" src="/js/jquery.removeWhitespace.js"></script>
<script type="text/javascript" src="/js/collage.js"></script>

<div class="collagewrap">
    <div class="Collage effect-parent">
        <c:forEach var="choice" items="${specific}">
            <img class="darkencss" src="${choice.path}">
        </c:forEach>
    </div>
</div>
<br/>


<div class="wrapper">
    <div class="entered-pw maincontent" style="width: 1110px">
        <h3 class="info">You've entered:</h3>

        <form:form commandName="user" method="POST" action="/">
            <form:input path="email" type="hidden" id="hidden-email" value=""/>
            <form:input path="username" type="hidden" id="hidden-uname" value=""/>
            <input type="hidden" name="password" id="img0" value=""/>
            <input type="hidden" name="password" id="img1" value=""/>
            <input type="hidden" name="password" id="img2" value=""/>
            <input type="hidden" name="password" id="img3" value=""/>
            <span class="images"></span>

            <div style="float: right; margin: 0px 15px 0px 15px">
                <button type="button" class="undo btn btn-warning supertall">Undo</button>
                <input type="submit" class="login btn btn-primary supertall" value="Continue"/>
            </div>
        </form:form>
    </div>
</div>

<script type="text/javascript">


    var pw = new Array();

    $(".undo").attr("disabled", pw.length == 0);
    $(".login").attr("disabled", pw.length != 4);
    $(".info").toggleClass("hidden", pw.length == 0);

    $(".Collage img").click(function () {
        // alert($(this).attr("src"));

        var src = $(this).attr("src");

        if (pw.length < 4) {
            $(this).css("visibility", "hidden");

            pw.push(src);
        }


        var html = "";
        for (var i = 0; i < pw.length; i++) {
            html += "<img height ='100' src='" + pw[i] + "'/>";
            $("input[id=img" + i + "]").val(pw[i]);
        }
        $(".images").html(html);

        $(".undo").attr("disabled", pw.length == 0);
        $(".login").attr("disabled", pw.length != 4);
        $(".info").toggleClass("hidden", pw.length == 0);
        //$(".entered-pw").html(html+"<img height='150' src='"+src+"'/>");
    })

    $(".undo").click(function () {
        var selector = "img[src='" + pw.pop() + "']";
        $(selector).css("visibility", "visible");

        var html = "";
        for (var i = 0; i < pw.length; i++) {
            html += "<img height ='100' src='" + pw[i] + "'/>";
        }
        $(".images").html(html);
        $(".undo").attr("disabled", pw.length == 0);
        $(".login").attr("disabled", pw.length != 4);
        $(".info").toggleClass("hidden", pw.length == 0);
    })

    $(".entered-pw").width($(".maincontent").width())
</script>

