<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<%-- <%String rw =(String) request.getAttribute("rw"); %> --%>
   <meta charset="utf-8">
   <title>Support</title>
   
	<script type="text/javascript" src="smarteditor/js/service/HuskyEZCreator.js" charset="utf-8">

	</script>
</head>
<body>
	<!--header start-->

	<jsp:include page="header.jsp"></jsp:include>
	<!--header end-->

	<!--sidebar end-->

	<!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
	<!--main content start-->	
	<section id="main-content">
      <section class="wrapper">
         <div class="content-panel">
            <h4>
               <i class="fa fa-angle-right"></i>Edit
            </h4>
            <hr>
            <section class="panel">
               <div class="panel-body ">
	           <form id="noticeSave" name="noticeSave" action="/noticeSave" method="post">
	<%-- 			<% if ((String) request.getAttribute("rw")!="write") {%> --%>
 				<input type="hidden" value="${noticeView.no}" name="no" id="no"/> 
				<input type="hidden" value="${sessionScope.LoginInfo.no}" name="member_no" id="member_no"/> 
			<%-- 	<%}%> --%>
				<div class="mail-header row">
							<div class="col-md-8">
								<h4 class="pull-left"><input type="text" placeholder="please enter a title" value="${noticeView.subject}" name="subject" id="subject"/></h4>
							</div>
							<div class="col-md-4">
								<div class="compose-btn pull-right">
								</div>
							</div>
						</div>
						<div class="mail-sender">
							<div class="row">
								<div class="col-md-8">
									<strong name="id">${sessionScope.LoginInfo.id}</strong>
								</div>
							</div>
						</div>              
                  <div id="editor">
                     <textarea name="contents" id="contents" rows="10" cols="10" style="width:100%; height:400px"/>${noticeView.contents}</textarea>
                     <input type="button" value="save" id="savebutton"/>
                     <input type="button" value="cancel" onclick=""/>
                  </div>

               </div>
            </section>
            </form>
         </div>
      </section>
   </section>
	
	
	
	<!--main content end-->
	<!--footer start-->
	<jsp:include page="footer.jsp"></jsp:include>

	<!--footer end-->
	
</body>

<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
   	elPlaceHolder: "contents",
	sSkinURI: "smarteditor/SmartEditor2Skin.html",
	fCreator: "createSEditor2"
});

//전송버튼 클릭이벤트
$("#savebutton").click(function (){
		oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
		var no = $('#no').val();
		if(no=="")
			document.getElementById("no").value=-1;
		if($('#subject').val()==""){a
			alert("please enter a title");
			return false;}
		else
			validation();
		noticeSave.submit();
				
		
})


// 필수값 Check 
function validation(){
	var content = $.trim(oEditors[0].getContents());
	if(content === '<p>&bnsp;</p>' || content === ''){// 기본적으로 아무것도 입력하지 않아도 값이 입력되어 있음.
		alert("please enter contents");
		oEditors.getById['contents'].exec('FOCUS');
		return false;
		}
	return true;
	}
	
	
	


</script>
</html>


