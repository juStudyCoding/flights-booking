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
      <section class="wrapper site-min-height">
        <div class="row mt">
          <div class="col-lg-12">
            <div class="row">
            <c:forEach items="${list}" var="tourList">
              <div class="col-lg-4 col-md-4 col-sm-4 mb">
                <div class="product-panel-2 pn">
                  <div class="badge badge-hot">HOT</div>
                  <img src="img/product.jpg" width="200" alt="" style="margin-bottom:30%;">
                  <h5 class="mt" style="color:black;">${tourList.title}</h5>
                  <h6 style="color:black">${tourList.country}</h6>
                  <h6 style="color:black">${tourList.city}</h6>
                  <input type="hidden" id="no" name="no" value="${tourList.no}"/>
                  <button class="btn btn-small btn-theme04" onClick="tourSelect()">Make a reservation</button>
                </div>
              </div>
            </c:forEach>
          </div>
        </div>
      </section>
      <!-- /wrapper -->
    </section>
	<!--main content end-->
	<!--footer start-->
	<jsp:include page="footer.jsp"></jsp:include>

	<!--footer end-->
</body>
<script type = "text/javascript">
function tourSelect(){
	if(confirm("Would you like to make a reservation?")){
		location.href="/tourReservation?no="+$('#no').val();
	}
}
</script>
</html>
