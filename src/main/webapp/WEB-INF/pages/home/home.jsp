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
            <div class="panel panel-default">
                <div class="panel-body">
                    <h1>Cognometric Analyis</h1>
                    <h4><p class="instructions">In this part of the study, you will be asked to communicate images.</p></h4>
                    <h4><p class="instructions">Please <a href="/login">login</a> and follow the scenario described by investigators.</p></h4>
                </div>
                <jsp:include page="login.jsp"/>
            </div>
        </sec:authorize>

        <sec:authorize access="hasAnyRole({'ROLE_ADMIN','ROLE_USER'})">
            <div id="search-panel" class="panel panel-default">
                <div class="collagewrap panel-body">
                    <h1>Tagged Images</h1>

                    <div class="panel-body">
                        <div class="form-inline">
                            <div class="form-group col-md-8">
                                <input id="filter-input" type="text" class="form-control" placeholder="Filter Tags">
                            </div>
                            <button type="button" id="show-images" class="btn btn-info">Display</button>
                            <button type='button' id='clear-filter' class='btn btn-default'>Clear</button>
                            <button type='button' id='show-filter' class='btn btn-default'>Show</button>
                        </div>
                    </div>

                    <table id="filter-table" class="table table-bordered">
                        <tr>
                            <c:forEach var="tag" items="${tags}" begin="0" step="1" varStatus="counter">
                                <td><input type="checkbox" value="${tag.tagName}"> ${tag.tagName}</td>
                                <c:if test="${counter.count % 7 eq 0}">
                                    </tr>
                                    <tr>
                                </c:if>
                            </c:forEach>
                        </tr>
                    </table>
                </div>
            </div>
            <div id="display-images" class="panel panel-body">

            </div>

            <div class="entered-pw" style="width: 1110px">
                <h3 class="info">You've entered:</h3>

                <div>
                    <input type="hidden" name="password" id="img0" value=""/>
                    <input type="hidden" name="password" id="img1" value=""/>
                    <input type="hidden" name="password" id="img2" value=""/>
                    <input type="hidden" name="password" id="img3" value=""/>
                    <span class="images"></span>

                    <div style="float: right; margin: 0px 15px 0px 15px">
                        <button type="button" class="undo btn btn-warning supertall">Undo</button>
                        <input type="submit" class="login btn btn-primary supertall" value="Continue"/>
                    </div>
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
        $('#show-filter').hide();
    });

    $("#show-filter").click(function() {
        $("#show-filter").hide();
        $("#filter-table").show();
    });

    $("#clear-filter").click(function () {
        $("#filter-table td > input").prop('checked', false);
        $("#filter-table td").removeClass("unchecked-tag");
        $("#filter-table td").removeClass("checked-tag");

    });

    $("#filter-table td").click(function() {
        if ($(this).hasClass("checked-tag")) {
            $(this).removeClass("checked-tag");
            $(this).addClass("unchecked-tag");
        } else if ($(this).hasClass("unchecked-tag")) {
            $(this).find('input').prop('checked', false);
            $(this).removeClass("unchecked-tag");
        } else {
            $(this).addClass("checked-tag");
            $(this).find('input').prop('checked', true);
        }
    });

    $("#show-images").click(function() {
        $(this).attr("disabled", "disabled");
        $("#filter-input").val("");

        $('#filter-table').find('td').show();


        var tagobj = $(".checked-tag");
        var untagobj = $(".unchecked-tag");
        var taglist = new Array();
        var untaglist = new Array();

        $.each(tagobj, function(key, value) {
            taglist.push(value.innerText);
        });

        $.each(untagobj, function(key, value) {
            untaglist.push(value.innerText);
        });

        $("#show-filter").show();

        $("#display-images").load("/tagwith", $.param({"taglist" : taglist, "untaglist": untaglist}, true), function(eve) {
            $("#filter-table").hide();
            $("#show-images").removeAttr("disabled");

            var pw = new Array();

            $(".undo").attr("disabled", pw.length == 0);
            $(".login").attr("disabled", pw.length != 4);
            $(".info").toggleClass("hidden", pw.length == 0);

            $(".img-tag > img").click(function () {

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

        });
    });

    $("#filter-input").keyup(function () {
        var data = this.value.split(" ");

        var ta = $('#filter-table').find('td');
        if (this.value == "") {
            ta.show();
            return;
        }

        ta.hide();

        ta.filter(function (i, v) {
            var $t = $(this);
            for (var d = 0; d < data.length; ++d) {
                if ($t.is(":contains('" + data[d] + "')")) {
                    return true;
                }
            }
            return false;
        }).show();
    })

</script>
</body>
</html>