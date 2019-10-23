<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
   <jsp:include page="header.jsp"></jsp:include>
   <style>
      .seat{
         margin:2px; float:left;
         width:30px; height:30px;
         border-radius:3px;
         background:gray;} 
   </style>
<link rel="stylesheet" href="resources/css/pignose.calendar.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.6/moment.min.js"></script>
<script src="resources/lib/pignose.calendar.full.min.js"></script>
<link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
 
</head>

<body>

   <!--sidebar end-->

   <!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
   <!--main content start-->
   <section id="main-content">
   	<section class="wrapper">
	   		<input type="hidden" id="no" name="no" value="${no}" /> 
	   		<input type="hidden" id="seat_no" name="seat_no"  /> 
	   		<input type="hidden" id="date" name="date"/> 
	      	<div class="content-panel" style="display:flex; align-items: flex-top;">
	         	<div class="calendar" style="float:left; width:40%; margin-bottom:10px;"></div> 
		         <div>seats: <div id="seats" style="display:inline-block; margin-top:40px;" ></div></div>
		         <button type="button" id="reservbt" style="width: 120px; height: 180px; margin:50px 0 0 50px; background-color:black; color:#fff; font-size:20px; border-radius:10px 10px 10px 10px; " onclick="reservCheck()">Make a payment</button>
	      	</div>
      </section>
   </section> 
   <!--main content end-->
   <!--footer start-->
   <jsp:include page="footer.jsp"></jsp:include>

  
</body>

   <script>   
   var abledDates = [];
   var seatcount = 0;
   $(document).ready(function() {
 		$.ajax({
	        url: "enableDate",
	        type: "POST",
	        async: false,
	        data: {
					"no" : $("#no").val(),
				},
			dataType : "json",
	        success: function(data){
		       	for(var i=0; i<data.length; i++){
		       		//sdf.parse(data[i])
		       		abledDates.push(data[i]);
	        	}; 
	        	//alert(abledDates);
	        	//location.reload();
	        },
	        error: function(){
	            alert("An error occurred. please try again.");
	        }
	    });   
	    function onSelectHandler(date, context) {
	           var $element = context.element;
	           var $calendar = context.calendar;
	           var $box = $element.siblings('.box').show();
	           var text = 'You selected date ';

	           if (date[0] !== null) {
	               viewSeats(date[0].format('YYYYMMDD'));	          
	           }

	           if (date[0] !== null && date[1] !== null) {
	               text += ' ~ ';
	           }
	           else if (date[0] === null && date[1] == null) {
	               text += 'nothing';
	           }

	           if (date[1] !== null) {
	               text += date[1].format('YYYY-MM-DD');
	           }
	       }
	    $('.calendar').pignoseCalendar({
	    	select: onSelectHandler,
	         format: 'YYYY-MM-DD',
	         /* minDate:0, */
	         minDate:'2019-07-30',
	         enabledDates: abledDates
	      });
	   var num=1;
      for(var i = 0; i < 6; i++) {
         for(var j = 0; j < 4; j++){

            $("#seats").append("<div class='seat' id='seat-"+num+"'>"+num+"</div>");
            num++;
         }
         $("#seats").append("<br>");
      }
      function viewSeats(date){
   	   	$.ajax({
   	        url: "viewSeats",
   	        type: "POST",
   	        async: false,
   	        data: {
   					"date" : date,
   					"tour_no": $("#no").val()
   				},
   			dataType : "json",
   	        success: function(result){
   		        for(var i=0; i<result.length; i++){		       		
   		       		if (result[i].order_type=="F"){
   		       			$("#seat-"+(i+1)).css("background-color","blue");
   		       		}else{
   		       			$("#seat-"+(i+1)).css("background-color","gray");
   		       			$("#seat-"+(i+1)).prop('disabled', true);;
   		       		}  		       			
   		       	} 
   	        },
   	        error: function(){
   	            alert("An error occurred. please try again.");
   	        }
   	    }); 
   	 	document.getElementById("date").value= date;
      }
      	         
   });
      
   function reservCheck(){
	    $.ajax({
	        url: "reservCheck",
	        type: "POST",
	        async: false,
	        data: {
					"date" : $("#date").val(),
					"seat_no": $("#seat_no").val(),
					"no" : $("#no").val()
				},
			dataType : "json",
	        success: function(result){
	        	if(result.order_type==("T")){
	        	alert('This seat is already reserved.');
	        	return false;
	        	}else{
	        		location.href="payPage?date=" + $("#date").val()+ "&seat_no=" + $("#seat_no").val()+"&no="+$("#no").val();
	        	}
	        },
	        error: function(){
	            alert("An error occurred. please try again.");
	        }
	    });  
      }
       $(document).on('click','.seat',function(){
    	   var seatId = $(this).attr('id'); 
    	   var seatInfo = document.getElementById(seatId);
    	   var seatcolor=seatInfo.style.backgroundColor;
    	   if(seatcolor=='red'){
    		   seatInfo.style.backgroundColor="blue";
    		   seatcount--;
    	   }else{
    		   if(seatcount>=1){
    			   alert("you are able to select only one seat");
    			   return false;
    		   }else{
    	    	   seatInfo.style.backgroundColor="red";
    	    	   seatcount++;
    	    	   seatId = seatId.substring(5,seatId.length);
    	    	 //alert(seatId);
    	    	   document.getElementById("seat_no").value = seatId; 
    		   }
    	   }
       })
      
 
   </script>

</html>
