<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../pagefrags/imports.jsp"/>
    <title>Survey</title>
</head>
<body>
<div class="container">

    <div class="collagewrap centered" style="max-width: 800px">

        <h2>Informed Consent</h2>

        <p class="instructions">

            <p><h4>Investigators:</h4> Jason Chen, Yang Sheng Fang, Monika Tuchowska
               </p>

        <p><h4>Study Aim:</h4> To gauge recognizability and communicability of picture passwords.</p>

        <p><h4>Study Procedures:</h4> This is a two-part experiment spanning the course of a week. In the first part, you will be directed to a registration page where you will create an account and set a password consisting of four images. You will then log in with your new account, complete an online questionnaire, and then attempt to log in again. The second part of the study will take place a week from now; in this part, you will be asked to describe your password to another participant.
        </p>

        <p><h4> Confidentiality:</h4> All survey responses and account information will be kept anonymous. Only the investigators (Jason Chen, Yang Sheng Fang, and Monika Tuchowska) will have access to the data.
        </p>

        <p><h4>Potential Risks and Discomforts:</h4>There are no foreseeable physical or psychological risks associated with this study.</p>

        <p><h4> Voluntary Participation:</h4>Your participation in this experiment is completely voluntary. Your completion of the registration process and survey expresses your consent to participate. You may withdraw from this study at any time prior to the close of the experiment a week from now; if you choose to do so, your responses and results will be discarded and will not be included in the study.
        </p>

        <p><h4> Contact Information: </h4>If you have any questions or concerns about this study, please feel free to contact Jason Chen (<a href="mailto:jason.chen@stonybrook.edu"/>), Yang Sheng Fang <a href="mailto:yangshengfang@stonybrook.edu"/> , or Monika Tuchowska (<a href="monika.tuchowska@stonybrook.edu"/>).
        </p>

        <p>
            <br/>

            <%--<button type="button" class="undo btn btn-primary fat tall">Proceed to Registration</button>--%>
        </p>
    </div>

    <jsp:include page="../pagefrags/footer.jsp"/>
</div>


</body>
</html>