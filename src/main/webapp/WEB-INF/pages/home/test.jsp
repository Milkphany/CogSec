<div class="Collage effect-parent">
    <img class="darkencss" src="http://i.imgur.com/E59TaCy.jpg"><img class="darkencss" src="http://i.imgur.com/E59TaCy.jpg"><img class="darkencss" src="http://i.imgur.com/ir4Ii.jpg">
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

<script type="text/javascript">
    collage();
    $('.Collage').collageCaption();

    var pw = new Array();

    $("button").attr("disabled", pw.length == 0);
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
            $("input[name=img" + i + "]").val(pw[i]);
            console.log($("input[name=img" + i + "]").val());
        }
        $(".images").html(html);

        $("button").attr("disabled", pw.length == 0);
        $(".login").attr("disabled", pw.length != 4);
        $(".info").toggleClass("hidden", pw.length == 0);
        //$(".entered-pw").html(html+"<img height='150' src='"+src+"'/>");
    })

    $("button").click(function () {
        pw.pop();
        var html = "";
        for (var i = 0; i < pw.length; i++) {
            html += "<img height ='100' src='" + pw[i] + "'/>";
        }
        $(".images").html(html);
        $("button").attr("disabled", pw.length == 0);
        $(".login").attr("disabled", pw.length != 4);
        $(".info").toggleClass("hidden", pw.length == 0);
    })

    $(".entered-pw").width($(".maincontent").width());

    $("img").click(function(){
        console.log("MEOWW");
    })
</script>