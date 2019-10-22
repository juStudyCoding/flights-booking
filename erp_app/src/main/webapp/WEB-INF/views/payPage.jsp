<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
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
        <!-- page start-->
        <div class="row mt">
          <div class="col-sm-9">
            <section class="panel">
              <header class="panel-heading wht-bg">
                <h4 class="gen-case"> Payment </h4>
              </header>
              <form id="orderform" action="order" method="POST">
              <div class="panel-body minimal">
              	<input type="hidden" id="tour_no" name="tour_no" value="${seatCheck.tour_no}"/>
              	<input type="hidden" id="date_no" name="date_no" value="${seatCheck.date_no}"/>
              	<input type="hidden" id="seat_no" name="seat_no" value="${seatCheck.no}"/>
              	<input type="hidden" id="member_no" name="member_no" value="${sessionScope.LoginInfo.no}"/>
              	<h6>Member ID: ${sessionScope.LoginInfo.id}</h6>
              	<h6>Tour Date: ${seatCheck.date}</h6>
              	<h6>Name: <input type="text" id="name" name="name" value="${sessionScope.LoginInfo.name}"/></h6>
              	<h6>Birth: <input type="text" id="birth" name="birth" placeholder="20190130" required/></h6>
				<h6>Passport: <input type="text" id="passport" name="passport" required/></h6>
              	<h6>First name: <input type="text" id="first_name" name="first_name" required/></h6>
              	<h6>Last name: <input type="text" id="last_name" name="last_name" required/></h6>
              	<h6>Phone: <input type="text" id="phone" name="phone" required/></h6>
              	<h6>E-mail: <input type="text" id="email" name="email" value="${sessionScope.LoginInfo.email}"/> </h6>
              	<h6>Payment</h6>   
              	<input type='radio' name="pay" value="card"/>Credit Card
              	<input type='radio' name="pay" value="account"/>Bank Transfer
              	<input type='radio' name="pay" value="phone"/>Mobile payment  	
              </div>
            </section>
          </div>
          
          <div class="col-sm-3">
            <section class="panel">
              <div class="panel-body">
                <ul class="nav nav-pills nav-stacked mail-nav">
                
                	<li> <i class="fa fa-envelope-o"></i>Default price: <span id="price">${seatCheck.price}</span> </li>
                	<li><i class="fa fa-trash-o"></i> Commission fee: <span id="commission">${seatCheck.commission}</span> </li>
                   <li class="active"><i class="fa fa-inbox"></i> Total price: <span id="totalprice">${seatCheck.totalPrice}</span>  </li>
                </ul>
                <a href="#" class="btn btn-compose" onclick="document.getElementById('orderform').submit()">
                  <i class="fa fa-pencil"></i>  Make a payment
                  </a>
              </div>
            </section>
            
          </div>
          </form>
        </div>
      </section>
      <!-- /wrapper -->
    </section>
    <!-- /MAIN CONTENT -->
	<!--footer start-->
	<jsp:include page="footer.jsp"></jsp:include>

	<!--footer end-->
</body>
</html>
