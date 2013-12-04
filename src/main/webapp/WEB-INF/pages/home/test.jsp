            <img class="darkencss" src="http://i.imgur.com/ir4Ii.jpg">
            <img class="darkencss" src="http://i.imgur.com/E59TaCy.jpg">
            <img class="darkencss" src="https://hostr.co/file/63mGxsgsk3UL/wallpaper_14271933.jpg">
            <img class="darkencss"src="http://i.imgur.com/VNHzA.jpg">
            <img class="darkencss"src="http://i.imgur.com/0MgS4od.jpg">
            <img class="darkencss"src="http://i.imgur.com/cYWveEa.jpg">
            <img class="darkencss"src="http://elbarto.35photo.ru/photos/20130314/495251.jpg">
            <img class="darkencss"src="http://stuckincustoms.smugmug.com/Portfolio-The-Best/your-favorites/i-VXWmNsM/0/3000x3000/trey-ratcliff-the-fields-3000x3000.jpg">
            <img class="darkencss"src="http://moro.35photo.ru/photos/20120814/393363.jpg">
            <img src="http://ppcdn.500px.org/48894678/47f5f67836d8d55b0fdaaca1c80d76e46c73d4ea/5.jpg">
            <img src="http://i.imgur.com/ir4Ii.jpg">
            <img src="http://i.imgur.com/E59TaCy.jpg">
            <img src="https://hostr.co/file/63mGxsgsk3UL/wallpaper_14271933.jpg">
            <img src="http://i.imgur.com/VNHzA.jpg">
            <img src="http://i.imgur.com/0MgS4od.jpg">
            <img src="http://i.imgur.com/cYWveEa.jpg">
            <img src="http://i.imgur.com/ir4Ii.jpg">
            <img src="http://i.imgur.com/E59TaCy.jpg">
            <img src="https://hostr.co/file/63mGxsgsk3UL/wallpaper_14271933.jpg">
            <img src="http://i.imgur.com/VNHzA.jpg">



            <script type="text/javascript">
                var pw = new Array();

                $("button").attr("disabled", pw.length ==0);
                $(".login").attr("disabled", pw.length !=4);
                $(".info").toggleClass("hidden", pw.length==0);

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

                    $("button").attr("disabled", pw.length ==0);
                    $(".login").attr("disabled", pw.length !=4);
                    $(".info").toggleClass("hidden", pw.length==0);
                    //$(".entered-pw").html(html+"<img height='150' src='"+src+"'/>");
                })

                $("button").click(function () {
                    pw.pop();
                    var html = "";
                    for (var i = 0; i < pw.length; i++) {
                        html += "<img height ='100' src='" + pw[i] + "'/>";
                    }
                    $(".images").html(html);
                    $("button").attr("disabled", pw.length ==0);
                    $(".login").attr("disabled", pw.length !=4);
                    $(".info").toggleClass("hidden", pw.length==0);
                })

                $(".entered-pw").width($(".maincontent").width())
            </script>