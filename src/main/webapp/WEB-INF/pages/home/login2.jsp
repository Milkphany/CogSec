<%--
  Created by IntelliJ IDEA.
  User: Polak
  Date: 11/25/13
  Time: 9:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../pagefrags/imports.jsp"/>

    <script type="text/javascript" src="/js/jquery.removeWhitespace.js"></script>
    <script type="text/javascript" src="/js/collage.js"></script>

    <script type="text/javascript">

        // All images need to be loaded for this plugin to work so
        // we end up waiting for the whole window to load in this example
        $(window).load(function () {
            $(document).ready(function(){
                collage();
                $('.Collage').collageCaption();
            });
        });


        // Here we apply the actual CollagePlus plugin
        function collage() {
            $('.Collage').removeWhitespace().collagePlus(
                    {

                        'targetHeight' : 160
                    }
            );
        };

        // This is just for the case that the browser window is resized
        var resizeTimer = null;
        $(window).bind('resize', function() {
            // hide all the images until we resize them
            $('.Collage .Image_Wrapper').css("opacity", 0);
            // set a timer to re-apply the plugin
            if (resizeTimer) clearTimeout(resizeTimer);
            resizeTimer = setTimeout(collage, 200);
        });

    </script>

</head>
<body>
<div class="container">

    <jsp:include page="../pagefrags/nav.jsp"/>

    <h1>Enter your password:</h1>

    <div class="maincontent">
        <div class="Collage effect-parent">
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

        </div>
    </div>

    <jsp:include page="../pagefrags/footer.jsp"/>
</div>

</body>
</html>