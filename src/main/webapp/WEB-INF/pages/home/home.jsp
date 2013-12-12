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
                            <div class="form-group col-md-10">
                                <input id="filter-input" type="text" class="form-control" placeholder="Filter Tags">
                            </div>
                            <button type="button" id="show-images" class="btn btn-default">Display</button>
                            <button type='button' id='show-filter' class='btn btn-default'>Show</button>
                        </div>
                    </div>

                    <table id="filter-table" class="table table-bordered">
                        <c:forEach var="tag" items="${tags}" begin="0" step="1" varStatus="counter">
                            <c:if test="${counter.count % 7 eq 0}">
                                <tr>
                            </c:if>
                            <c:if test="${counter.count % 7 != 0}">
                                <td><input type="checkbox" value="${tag.tagName}"> ${tag.tagName}</td>
                            </c:if>
                            <c:if test="${counter.count % 7 eq 0}">
                                </tr>
                            </c:if>
                        </c:forEach>
                    </table>
                </div>
            </div>
            <div id="display-images" class="panel panel-body">

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

    $("td").click(function() {
        if ($(this).hasClass("checked-tag")) {
            $(this).find('input').prop('checked', false);
            $(this).css('background-color', 'white');
            $(this).removeClass("checked-tag");
        } else {
            $(this).find('input').prop('checked', true);
            $(this).css('background-color', 'green');
            $(this).addClass("checked-tag");
        }
    });

    $("#show-images").click(function() {
        var tagobj = $(".checked-tag");
        var taglist = new Array();
        $.each(tagobj, function(key, value) {
            taglist.push(value.innerText);
        });

        $("#show-filter").show();

        $("#display-images").load("/tagwith", $.param({"taglist" : taglist}, true), function(eve) {
            $("#filter-table").hide();
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