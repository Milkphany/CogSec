<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="../pagefrags/imports.jsp"/>

<script type="text/javascript" src="/js/jquery.removeWhitespace.js"></script>
<script type="text/javascript" src="/js/collage.js"></script>

<script type="text/javascript">

    // All images need to be loaded for this plugin to work so
    // we end up waiting for the whole window to load in this example

    $(document).ready(function () {

        $('.Collage').removeWhitespace().collagePlus(
                {
                    'targetHeight': 160
                }
        );        //$('.Collage').collageCaption();
    });

    // This is just for the case that the browser window is resized
    var resizeTimer = null;
    $(window).bind('resize', function () {
        // hide all the images until we resize them
        $('.Collage .Image_Wrapper').css("opacity", 0);
        // set a timer to re-apply the plugin
        if (resizeTimer) clearTimeout(resizeTimer);
        resizeTimer = setTimeout(collage, 200);
    });
</script>

<body>
<div class="container">


    <div class="maincontent">
        <h1>Enter your PIN:</h1>

        <div class="collagewrap">
            <div class="Collage effect-parent">

                <img class="darkencss" src="http://i.imgur.com/ir4Ii.jpg">
                <img class="darkencss" src="http://i.imgur.com/E59TaCy.jpg">
                <img class="darkencss" src="https://hostr.co/file/63mGxsgsk3UL/wallpaper_14271933.jpg">
                <img class="darkencss" src="http://i.imgur.com/VNHzA.jpg">
                <img class="darkencss" src="http://i.imgur.com/0MgS4od.jpg">
                <img class="darkencss" src="http://i.imgur.com/ir4Ii.jpg">
                <img class="darkencss" src="http://i.imgur.com/E59TaCy.jpg">
                <img class="darkencss" src="https://hostr.co/file/63mGxsgsk3UL/wallpaper_14271933.jpg">
                <img class="darkencss" src="http://i.imgur.com/VNHzA.jpg">
                <img class="darkencss" src="http://i.imgur.com/0MgS4od.jpg">
                <img class="darkencss" src="http://i.imgur.com/ir4Ii.jpg">
                <img class="darkencss" src="http://i.imgur.com/E59TaCy.jpg">
                <img class="darkencss" src="https://hostr.co/file/63mGxsgsk3UL/wallpaper_14271933.jpg">
                <img class="darkencss" src="http://i.imgur.com/VNHzA.jpg">
                <img class="darkencss" src="http://i.imgur.com/0MgS4od.jpg">
                <img class="darkencss" src="http://i.imgur.com/ir4Ii.jpg">
                <img class="darkencss" src="http://i.imgur.com/E59TaCy.jpg">
                <img class="darkencss" src="https://hostr.co/file/63mGxsgsk3UL/wallpaper_14271933.jpg">
                <img class="darkencss" src="http://i.imgur.com/VNHzA.jpg">
                <img class="darkencss" src="http://i.imgur.com/0MgS4od.jpg">
                <img class="darkencss" src="http://i.imgur.com/ir4Ii.jpg">
                <img class="darkencss" src="http://i.imgur.com/E59TaCy.jpg">
                <img class="darkencss" src="https://hostr.co/file/63mGxsgsk3UL/wallpaper_14271933.jpg">
                <img class="darkencss" src="http://i.imgur.com/VNHzA.jpg">
                <img class="darkencss" src="http://i.imgur.com/0MgS4od.jpg">
                <img class="darkencss" src="http://i.imgur.com/ir4Ii.jpg">
                <img class="darkencss" src="http://i.imgur.com/E59TaCy.jpg">
                <img class="darkencss" src="https://hostr.co/file/63mGxsgsk3UL/wallpaper_14271933.jpg">
                <img class="darkencss" src="http://i.imgur.com/VNHzA.jpg">
                <img class="darkencss" src="http://i.imgur.com/0MgS4od.jpg">
            </div>
        </div>
        <br/>

    </div>

    <div class="wrapper">
        <div class="entered-pw maincontent">
            <h3 class="info">You've entered:</h3>

            <form:form modelAttribute="loginForm" method='POST' id='loginForm' cssClass='cssform' autocomplete='off' action="login-check">
                <input type="hidden" id="userinput" name="username" value="${username}"/>
                <input type="hidden" name="password" id="img0" value=""/>
                <input type="hidden" name="password" id="img1" value=""/>
                <input type="hidden" name="password" id="img2" value=""/>
                <input type="hidden" name="password" id="img3" value=""/>
                <span class="images"></span>
                <div style="float: right; margin: 0px 15px 0px 15px">
                    <button type="button" class="undo btn btn-warning supertall">Undo</button>
                    <input type="submit" class="login btn btn-primary supertall" value="Log In"/>
                </div>
            </form:form>
        </div>
    </div>
    <jsp:include page="../pagefrags/footer.jsp"/>
</div>

<script type="text/javascript">


    var pw = new Array();

    $(".undo").attr("disabled", pw.length == 0);
    $(".login").attr("disabled", pw.length != 4);
    $(".info").toggleClass("hidden", pw.length == 0);

    $(".Collage img").click(function () {
        // alert($(this).attr("src"));
        var src = $(this).attr("src");

        if (pw.length < 4)
            pw.push(src);

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
        pw.pop();
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

