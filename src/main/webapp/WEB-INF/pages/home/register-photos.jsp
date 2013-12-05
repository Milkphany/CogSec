<jsp:include page="../pagefrags/imports.jsp"/>

<script type="text/javascript" src="/js/jquery.removeWhitespace.js"></script>
<script type="text/javascript" src="/js/collage.js"></script>

<script type="text/javascript">

    // All images need to be loaded for this plugin to work so
    // we end up waiting for the whole window to load in this example

    $(document).ready(function () {
        collage();
        //$('.Collage').collageCaption();
    });

    // Here we apply the actual CollagePlus plugin
    function collage() {
        $('.Collage').removeWhitespace().collagePlus(
                {

                    'targetHeight': 160
                }
        );
    }
    ;

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
                <img class="darkencss" src="http://ppcdn.500px.org/44746914/d0276b9a1b7757060e4dc9ff26b95a17c6e88793/2048.jpg">
                <img class="darkencss" src="http://ppcdn.500px.org/37900426/6d316a44c0dc1fdf4cced48d31fb4510cb585eb2/5.jpg">
                <img class="darkencss" src="http://ppcdn.500px.org/44746914/d0276b9a1b7757060e4dc9ff26b95a17c6e88793/2048.jpg">

            </div>
        </div>
        <br/>



    <div class="wrapper">
        <div class="entered-pw maincontent">
            <h3 class="info">You've entered:</h3>

            <form method="POST">
                <input type="hidden" name="username" value=""/>
                <input type="hidden" name="password" id="img0" value=""/>
                <input type="hidden" name="password" id="img1" value=""/>
                <input type="hidden" name="password" id="img2" value=""/>
                <input type="hidden" name="password" id="img3" value=""/>
                <span class="images"></span>
                <button type="button" class="undo btn btn-warning supertall">Undo</button>
                <input type="submit" class="login btn btn-primary supertall" value="Continue"/>
            </form>
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
        var selector = "img[src='"+pw.pop()+"']";
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

