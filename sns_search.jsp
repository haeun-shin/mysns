<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="sns"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>My SNS</title>

<!-- css -->
<link rel="stylesheet" href="./css/styles.css">
<!-- 아코디언 -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<!-- 부트스트랩 -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js"></script>


<script>
	 function newuser() {
		window.open(
			"new_user.jsp",
			"newuser",
			"titlebar=no,location=no,scrollbars=no,resizeable=no,menubar=no,toolbar=no,width=300,height=240");
	}
	 
	$(document).ready(function(){
		
		$('a[data-toggle="pill"]').on('show.bs.tab', function(e) {
			localStorage.setItem('activeTab', $(e.target).attr('href'));
		});
		var activeTab = localStorage.getItem('activeTab');
		if(activeTab){
			$('.nav-pills a[href="' + activeTab + '"]').tab('show');
		}
		
	});
</script>


</head>


<body class="nav_wrap bg-light">

<jsp:include page="navbar.jsp" />

<div id="result_wrap">
<section class="row flex-xl-nowrap">
	<section class="col-12 col-md-9 col-xl-8 py-md-3 pl-md-5 bd-content">
	<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
	  <li class="nav-item" role="presentation">
	    <a class="nav-link active" id="search_mem_tab" data-toggle="pill" href="#search_mem" role="tab" aria-selected="true">
	    	아이디 검색결과 <span class="badge badge-light">${s_members.size()}</span>
	    </a>
	  </li>
	  <li class="nav-item" role="presentation">
	    <a class="nav-link" id="search_msg_tab" data-toggle="pill" href="#search_msg" role="tab" aria-selected="false">
	    	게시글 검색결과 <span class="badge badge-light">${s_messages.size()}</span>
	    </a>
	  </li>
	  <li class="nav-item" role="presentation">
	    <a class="nav-link" id="search_rmsg_tab" data-toggle="pill" href="#search_rmsg" role="tab" aria-selected="false">
	    	댓글 검색결과 <span class="badge badge-light">${s_replys.size()}</span>
	    </a>
	  </li>
	</ul>
	
	<div class="tab-content" id="pills-tabContent">
	
		<!-- 멤버 검색 결과 -->
		<div class="tab-pane fade show active" id="search_mem" role="tabpanel" aria-labelledby="pills-home-tab">
			<c:choose>
			<c:when test="${s_members.size() != 0 }">
			<div class="row row-cols-1 row-cols-md-3">
				<!-- 검색 결과 반복 -->
				<c:forEach var="s_mem" items="${s_members}">
				<div class="col mb-4">
				    <div class="card h-100">
				      <div class="card-body">
				        <h5 class="card-title">${s_mem.uid }</h5>
					    <h6 class="card-subtitle mb-2 text-muted">${s_mem.name }</h6>
					    <p class="card-text">${s_mem.email }</p>
					     <a href="sns_control.jsp?action=getall&suid=${s_mem.uid}" class="btn btn-primary">작성글 보러가기</a>
				      </div>
				    </div>
				  </div>
				</c:forEach>	
			</div>
			</c:when>
				<c:otherwise>
					<div class="alert alert-dark" role="alert">
					  아이디 검색 결과가 존재하지 않습니다.
					</div>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${s_members.size() < cnt }">
				</c:when>
				<c:otherwise>
					<a href="sns_control.jsp?action=search&cnt=${cnt+12}&search=${search}" style="color:#fff" class="btn btn-primary btn-lg btn-block mt-3">더보기</a>
				</c:otherwise>
			</c:choose>
		</div>
	
		<!-- 게시글 검색 결과 -->
		<div class="tab-pane fade" id="search_msg" role="tabpanel" aria-labelledby="pills-profile-tab">
			<c:choose>
			<c:when test="${s_messages.size() != 0 }" >
			<div class="row row-cols-1 row-cols-md-3">
				<!-- 검색 결과 반복 -->
				<c:forEach var="s_mesage" items="${s_messages}">
				<div class="col mb-4">
				    <div class="card h-100">
				      <div class="card-body">
				        <h5 class="card-title">${s_mesage.uid } </h5>
					    <p class="card-text">${s_mesage.msg }</p>
					    <h6 class="card-subtitle mb-2 text-muted">${s_mesage.date }</h6>
					     <a href="sns_control.jsp?action=getMessage&mid=${s_mesage.mid}" class="btn btn-primary">게시글 보러가기</a>
				      </div>
				    </div>
				  </div>
				</c:forEach>	
			</div>
			</c:when>
			<c:otherwise>
				<div class="alert alert-dark" role="alert">
				 	게시물 검색 결과가 존재하지 않습니다.
				</div>
			</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${s_messages.size() < cnt }">
				</c:when>
				<c:otherwise>
					<a href="sns_control.jsp?action=search&cnt=${cnt+12}&search=${search}" style="color:#fff" class="btn btn-primary btn-lg btn-block mt-3">더보기</a>
				</c:otherwise>
			</c:choose>
		</div>
	
		<!-- 댓글 검색 결과 -->
		<div class="tab-pane fade" id="search_rmsg" role="tabpanel" aria-labelledby="pills-contact-tab">
			<c:choose>
			<c:when test="${s_replys.size() != 0 }">
			<div class="row row-cols-1 row-cols-md-3">
				<!-- 검색 결과 반복 -->
				<c:forEach var="s_reply" items="${s_replys}">
				<div class="col mb-4">
				    <div class="card h-100">
				      <div class="card-body">
				        <h5 class="card-title">${s_reply.uid } </h5>
					    <p class="card-text">${s_reply.rmsg }</p>
					    <h6 class="card-subtitle mb-2 text-muted">${s_reply.date }</h6>
					     <a href="sns_control.jsp?action=getMessage&mid=${s_reply.mid}" class="btn btn-primary">원문 보러가기</a>
				      </div>
				    </div>
				  </div>
				</c:forEach>	
			</div>
			</c:when>
			<c:otherwise>
				<div class="alert alert-dark" role="alert">
				 	댓글 검색 결과가 존재하지 않습니다.
				</div>
			</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${s_replys.size() < cnt }">
				</c:when>
				<c:otherwise>
					<a href="sns_control.jsp?action=search&cnt=${cnt+12}&search=${search}" style="color:#fff" class="btn btn-primary btn-lg btn-block mt-3">더보기</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	</section>
	<jsp:include page="sns_aside.jsp" />
</section>
</div>

</body>
</html>
