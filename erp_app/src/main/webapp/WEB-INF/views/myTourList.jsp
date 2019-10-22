<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="en">

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
			<section class="panel">
              <header class="panel-heading wht-bg">
                <h4 class="gen-case"> My Bookings </h4>
              </header>
              <div class="panel-body minimal">
              	<c:forEach var="order" items="${selectOrder}">
					Tour Date : ${order.date} <br>
					Tour Destination : ${order.country} <br>
					Seat : ${order.seat_no} <br>
					ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
				</c:forEach>	
              </div>
            </section>
		</section>
	</section>
	<!--main content end-->
	<!--footer start-->
	<jsp:include page="footer.jsp"></jsp:include>

	<!--footer end-->
</body>

</html>
