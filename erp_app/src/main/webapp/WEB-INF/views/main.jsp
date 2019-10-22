<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="en">


  
<body>
	<!--header start-->
	<jsp:include page="header.jsp"></jsp:include>
	<!--header end-->
	<!--main content start-->
	<section id="main-content">
		<section class="wrapper">		
            <div class="row mt">
              <!-- DIRECT MESSAGE PANEL -->
              <div class="col-md-12 mb">
                <div class="message-p pn">
                  <div class="message-header">
                    <h5>Welcome</h5>
                  </div>
	               <div class="col-lg-6 col-lg-offset-3 p404 centered">     
	               	   <!-- <img src="/resources/img/travel.jpg" width="100%" height="100%" style="overflow:hidden"> -->
	                   <h2 style="color:green">Plan your trip now</h2>             
	                   <div class="col-md-8 col-md-offset-2">
	                     <h3 style="color:#82D580">welcome to my tour!</h3>   
	                     <button class="btn btn-theme mt" onclick="window.location.href='/tour'">Start</button>
	                   </div>
	                 </div>                             
	              </div>
                </div>
                <!-- /Message Panel-->
              </div>
              <!-- /col-md-8  -->
            </div>
            
            
			<div class="row">
              <!-- WEATHER PANEL -->
              <div class="col-md-4 mb">
              
                <div class="grey-panel pn donut-chart">
                  <div class="grey-header">
                    <h5>KOREA</h5>
                  </div>
                  <img src="/resources/img/korea.jpg" width="100%" height="100%" style="overflow:hidden">
                </div>
                <!-- /grey-panel -->
              </div>
              
              <div class="col-md-4 mb">             
                <div class="grey-panel pn donut-chart">
                  <div class="grey-header">
                    <h5>AUSTRALIA</h5>
                  </div>
                  <img src="/resources/img/australia.jpg" width="100%" height="100%" style="overflow:hidden">
                </div>
                <!-- /grey-panel -->
              </div>
              
              <div class="col-md-4 mb">              
                <div class="grey-panel pn donut-chart">
                  <div class="grey-header">
                    <h5>THAILAND</h5>
                  </div>
                  <img src="/resources/img/thailand.jpg" width="100%" height="100%" style="overflow:hidden">
                </div>
                <!-- /grey-panel -->
              </div>
              
		</section>
		
	</section>
	
	 <!-- Modal -->
            <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
               <div class="modal-dialog">
                  <div class="modal-content">
                     <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeSocket();">&times;</button>
                        <h4 class="modal-title">let's talk together</h4>
                     </div>
                     <div class="modal-body" style="overflow:scroll; width:500px; height:600px;">
                             <!-- page start-->
                             <div class="chat-room mt">        
                                  <div class="group-rom">
                                  	<div id="messages"></div>                                 
                             </div>
                     </div>
                     <div class="modal-footer">
                             <div class="chat-txt">
                             	<input type="text" id="sender" value="${sessionScope.LoginInfo.id}" style="display: none;">
                               <input type="text" class="form-control" id="messageinput">
                             </div>
                        <button class="btn btn-theme" onsubmit="return false;" onclick="send();">Submit</button>
                     </div>
                  </div>
               </div>
            </div>
	
	<!--main content end-->
	
	<!--footer start-->
	<jsp:include page="footer.jsp"></jsp:include>
	<!--footer end-->
</body>


<script type="text/javascript">
    $(document).ready(function() { 	
      var unique_id = $.gritter.add({
        // (string | mandatory) the heading of the notification
        title: 'you can talk to others',
        // (string | mandatory) the text inside the notification
        text: 'Click this. You can talk in real time with others. and You can share information with each other.',
        // (string | optional) the image to display on the left
        image: 'img/ui-sam.jpg',
        // (bool | optional) if you want it to fade out on its own or just sit there
        sticky: true,
        // (int | optional) the time you want it to be alive for before fading out
        time: 8000,
        // (string | optional) the class name you want to apply to that specific message
        class_name: 'my-sticky-class'
      });
		
      $('#gritter-notice-wrapper').click(function(){
    	  openSocket();
    	  $("#myModal").modal();
    	  
    	  
        }); 
      return false;
    });

    var ws;
    var messages=document.getElementById("messages");
    
    function openSocket(){
    	
        if(ws!==undefined && ws.readyState!==WebSocket.CLOSED){
            writeResponse("WebSocket is already opened.");
            return;
        }
        //웹소켓 객체 만드는 코드
        ws=new WebSocket("ws://localhost:8080/echo");
        //ws=new WebSocket("ws://192.168.1.221:8080/echo.do");
        ws.onopen=function(event){
            if(event.data===undefined) return;
            
            writeResponse(event.data);
        };
        ws.onmessage=function(event){
        	 var data = event.data.split(',');
             var msg = "";
             
             msg += "<div class='group-rom'>";
             msg += "<div class='first-part'>" + data[0] + "</div>";
             msg += "<div class='second-part'>" + data[1] + "</div>";
             msg += "<div class='third-part'>" + data[2] + "</div>";
             msg += "</div>";
             
             //writeResponse(msg);
             $("#messages").append(msg);
        };
        ws.onclose=function(event){
            writeResponse("Connection closed");
        }
    }
    
    function send(){
    	
    	var curDate = new Date();
        var curTime;
        if(parseInt(curDate.getMinutes())<10)
        	curTime = curDate.getHours() + ":0" + curDate.getMinutes();
        else
    		curTime = curDate.getHours() + ":" + curDate.getMinutes();
        var text=document.getElementById("sender").value+","+document.getElementById("messageinput").value+","+curTime;
        ws.send(text);
        text="";
    }
    
    function closeSocket(){
        ws.close();
    }
    function writeResponse(text){
        messages.innerHTML+="<br/>"+text;
    }

    $('#myModal').on('hide.bs.modal', function(e) {
        closeSocket();
     });
     $("#messageinput").keyup(function(e) {
        if(e.keyCode == 13) send(); 
     });
   
  </script>
  
</html>
