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
<title>My SNS </title>

<!-- css -->
<link rel="stylesheet" href="./css/styles.css">
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
</script>

</head>
<body class="nav_wrap bg-light">
<jsp:include page="navbar.jsp" />
<div id="result_wrap">
<section class="row flex-xl-nowrap">
	<section class="col-12 col-md-9 col-xl-8 py-md-3 pl-md-5 bd-content">
		<div id="accordion">
		<c:forEach varStatus="mcnt" var="msgs" items="${getMessage}">
			<c:set var="m" value="${msgs.message}"/>
			<div class="card">
				<div class="card-header " id="heading_${mcnt.index}">
					<div class="mb-0 row">
						<button class="btn btn-link collapsed col-lg-12" data-toggle="collapse" data-target="#collapse_${mcnt.index}" aria-expanded="false" aria-controls="collapse_${mcnt.index}">
							<span class="d-inline-block text-truncate float-left col-9 text-left"><strong>${m.uid}</strong> &nbsp;&nbsp; ${m.msg}</span>
							<span class="float-right">
								<span class="badge badge-primary badge-pill">댓글 &nbsp; ${m.replycount}</span>  &nbsp;
								<span class="badge badge-danger badge-pill">♥ &nbsp; ${m.favcount}</span>
							</span>
						</button>
					</div>
				</div>
				<div id="collapse_${mcnt.index}" class="collapse show" aria-labelledby="heading_${mcnt.index}" data-parent="#accordion">
				
					<div class="card-body">
						<!-- 게시글 start -->
						<%-- <p>${m.msg}</p> 줄바꿈 처리함 --%>
						<p>${fn:replace((m.msg), newLineChar, "<br/>")}</p>
						 <div class="d-flex justify-content-between align-items-center mt-5">
						 	<span>
						   	 	<sns:smenu mid="${m.mid}" auid="${m.uid}" curmsg="${mcnt.index}"/>
						    </span>
						    <!-- 작성일 -->
						    <span class="text-muted">${m.date}</span>
						  </div>
						<!-- 게시글 end -->
						
						<!-- 댓글 start -->
						<ul class="list-group list-group-flush mt-3">
							<li class="list-group-item">댓글 &nbsp; ${m.replycount}</li>
							<!-- forEach의 값인 msgs로 rlist(댓글) 객체를 r로 접근할 수 있도록 함 -->
							<!-- rlist인 r을 forEach로 하나씩 반복 -->
							<c:forEach  var="r" items="${msgs.rlist}">
								<!-- 태그라이브러리 rmenu에 접근하여 curmsg, rid, ruid 값을 전달 -->
								<!-- 만약 uid(로그인아이디)와 ruid(작성자아이디)가 같으면 삭제버튼이 나타남 --> 
								<li class="list-group-item">
									<!-- 댓글 작성자 -->
									<div><strong>${r.uid }</strong></div>
									<!-- 댓글내용 -->
									<%-- ${r.rmsg}<br> --%>
									<p>${fn:replace((r.rmsg), newLineChar, "<br/>")}</p>
									<!-- 삭제버튼 -->
									<span class="float-right mt-1 text-muted">${r.date} <sns:rmenu curmsg="${mcnt.index}" rid="${r.rid}" ruid="${r.uid}"/></span>
								</li>
							</c:forEach>
						</ul>
						<!-- 댓글 end -->
						
						<!-- 댓글 입력 start -->
						<form action="sns_control.jsp?action=newreply&cnt=${cnt}" method="post"  class="m_form input-group mb-3 needs-validation mt-3" novalidate>
							<input type="hidden" name="mid" value="${m.mid}">
							<input type="hidden" name="uid" value="${uid}">
							<input type="hidden" name="suid" value="${suid}">
							<input type="hidden" name="curmsg" value="${mcnt.index}">				
							<sns:write type="rmsg"/>
							<div class="input-group-append">
							  <button class="btn btn-outline-secondary" type="submit" id="button-addon2">등록</button>
							</div>
							<div class="invalid-feedback">
					        	내용을 입력해주세요.
					      	</div>
						</form>
						<!-- 댓글 입력 end -->
					</div>
				</div>
			</div>
			</c:forEach>
		</div>
	</section>
	<jsp:include page="sns_aside.jsp" />
</section>
</div>
</body>
</html>