<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="en">
<style type:text/css">
A:hover{color : #000000;}
</style>
<Script>

	function paging(curPage){
		location.href = "/notice?curPage=" + curPage;
	}
	
	function noticeView(no){
		location.href = "/noticeView?no=" + no;
	}
		
</Script>
  
<body>
	<!--header start-->

	<jsp:include page="header.jsp"></jsp:include>
	<!--header end-->


	<!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
	<!--main content start-->
	<section id="main-content">
		<section class="wrapper site-min-height">
			<div class="col-lg-12 mt">
				<div class="row content-panel">
					<!-- /panel-heading -->
					<div class="panel-body">
						<h4>Support</h4>
						<div class="compose-btn pull-right">
							<button class="btn  btn-sm tooltips" data-original-title="Edit"
								type="button" data-toggle="tooltip" data-placement="top"
								title="" onclick="location.href='/noticeEdit?rw=write'">
								<i class="fa fa-edit"> Write</i>
							</button>
						</div>
						<div class="tab-content">
							<div id="overview" class="tab-pane active">
							
								<div class="row">
									<div class="col-md-12">
										<table class="table table-striped table-advance table-hover">
										
											<colgroup>
												<col width="70px"><col><col width="100px">
											</colgroup>
											<thead>
												<tr>
													<th class="text-center">No</th>
													<th class="text-center"><i class="fa fa-edit"></i>Title</th>
													<th class="text-center"><i class=" fa fa-calendar"></i>Date</th>
													<th class="text-center">Views</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach items="${list}" var="noticeList">												
												<tr>
													<td>${noticeList.no}</td>
 													<td><a href="#"  onClick="noticeView('${noticeList.no}')">${noticeList.subject}  (${noticeList.reply_cnt})</td>
													<td>${noticeList.make_date}</td> 
													<td>${noticeList.view_count}</td> 
												</tr>					
											</c:forEach>	
											</tbody>
										</table>

										<div class="row-fluid">
											<div class="span6">
												<div class="dataTables_paginate paging_bootstrap pagination">
													<ul>
														
                        								<li class="prev disabled"><a href="#" onClick="paging('${notice.prev}')">이전</a></li>  
														<c:forEach var="pageNum" begin="1" end="${listCnt}">
															<li><a href="#" onClick="paging('${pageNum}')">${pageNum}</li>
									                    </c:forEach>
														 <c:if test="${notice.curPage ne listCnt && listCnt > 0}"> 
															 <li class="next"><a href="#" onClick="paging('${notice.next}')">다음</a></li> 
														 </c:if> 
													</ul>
												</div>
											</div>
										</div>
										<!-- /content-panel -->
									</div>
									<!-- /col-md-12 -->
								</div>
								<!-- /row -->
								<!-- /OVERVIEW -->
							</div>
										<!-- /content-panel -->
									</div>
									<!-- /col-md-12 -->
								</div>
								<!-- /row -->
							</div>
		</section>
	</section>
	<!--main content end-->
	<!--footer start-->
	<jsp:include page="footer.jsp"></jsp:include>

	<!--footer end-->
</body>

</html>
