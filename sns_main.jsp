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

<!-- 아코디언 -->
<!-- <script src="http://code.jquery.com/jquery-1.9.1.js" ></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script> -->


<script>
/*  	$(function() {
		$("#accordion").accordion({
			heightStyle : "content",
			active : parseInt("${curmsg == null ? 0:curmsg}")
		});
	}); */
	 
	 function newuser() {
		window.open(
			"new_user.jsp",
			"newuser",
			"titlebar=no,location=no,scrollbars=no,resizeable=no,menubar=no,toolbar=no,width=300,height=240");
	}
	function send_message() {
		var send_form = document.m_form;
        var send_message = send_form.msg.value;
	        
        if(send_message == null || send_message == ""){
        	/* document.getElementById("test").innerHTML='<a href="https://hi098123.tistory.com">안녕 ㅎ</a>'; */
        	/* document.getElementByName('invalid-feedback').innerHTML = "새로 생성된 DIV입니다."; */
	        	
        }else{
        	send_form.submit();
        } 
	}
</script>

<!--[if IE]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
</head>

<body>
<% 
	pageContext.setAttribute("newLineChar", "\n"); 

	// 이건 이미지 절대경로인데, 쓸수도있을것같아서 남김..
	//String realPath = application.getRealPath("/");
	//realPath = realPath.substring(1,realPath.indexOf(".metadata"))+"mysns\\WebContent\\upload\\";
%>

<!-- <style>
	* {
	font-family: 'Noto Sans KR', sans-serif;
	}
	nav {
		max-width:1250px;
		margin: 0 auto;
	}
	
	#wrapper {
		max-width:1250px;
		margin: 50px auto;
	}
	
	#accordion .ui-state-default {
		background-color : #fff;
	}
	
	.btn-link {
		color:#000;
	}
	
	.dropdown-menu {
		/* right: -16px !important; */
	}
</style> -->
<%-- <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <a class="navbar-brand" href="#">에센에스</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  
  <div class="collapse navbar-collapse" id="navbarNav">
    <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
	  <c:choose>
	  	<c:when test="${uid == null }">
	  		<li class="nav-item">
	        	<a class="nav-link" href="javascript:newuser()">회원가입</a>
	      	</li>
	  	</c:when>
	  	<c:otherwise>
	  		<li class="nav-item">
        		<a class="nav-link" href="sns_control.jsp?action=getall">전체글 보기</a>
     		 </li>
	  		<li class="nav-item">
	        	<a class="nav-link" href="sns_control.jsp?action=getall&suid=${uid}" >내 글 모아보기</a>
	      	</li>
	  	</c:otherwise>
	  </c:choose>
    </ul>
    <sns:login />
  </div>
</nav>--%>

	<jsp:include page="navbar.jsp" />
	<div id="wrapper">
		
		<section id="main" class="row flex-xl-nowrap">
			<section id="content" class="col-12 col-md-9 col-xl-8 py-md-3 pl-md-6 bd-content">
			
				<form class="form-group needs-validation" novalidate method="post" action="sns_control.jsp?action=newmsg"  enctype="multipart/form-data">
				  <input type="hidden" name="uid" value="${uid}">

				  <sns:write type="msg"/>
				  <!-- 이미지 업로드 -->
				  <div class="input-group-append">
				  	<c:choose>
						<c:when test="${uid == null }">
<!-- 						<div class="input-group mt-3">
							<input type="file" name="filename" class="form-control-file " accept=".gif, .jpg, .png" value="사진 첨부" disabled> 
							<div class="btn btn-outline-primary write_submit ml-auto col-3 disabled" >등록</div>
						</div> -->
						</c:when> 
						<c:otherwise>
							
							<div class="input-group mt-3">
					  			<input type="file" name="filename" class="form-control-file col-5"  accept=".gif, .jpg, .png" value="사진 첨부" > 
								<button class="btn btn-outline-primary write_submit ml-auto col-3" type="submit">등록</button>
							</div>
						</c:otherwise>
					</c:choose>
					
				  </div>
				  <div class="invalid-feedback">
		        	  내용을 입력해주세요.
		      	  </div>
			    </form>
			   
			   
<%-- 				<p>내소식 업데이트</p>
				<form class="m_form" method="post" action="sns_control.jsp?action=newmsg">
					<input type="hidden" name="uid" value="${uid}">
					<sns:write type="msg"/>
					<button class="submit" type="submit">등록</button>
				</form> --%>
				<h4 class="mt-5">친구들의 최신 소식</h4>
				<br>
				<div id="accordion">
					<!-- control에서 전달받은 data(MessageSet)를 forEacgh로 하나씩 반복 -->
					<!-- varStatus는 상태용 변수. mcnt.index는 0부터 카운트 -->
					<c:forEach varStatus="mcnt" var="msgs" items="${datas}">
						<!-- forEach의 값인 msgs로 message(게시글) 객체를 m으로 접근할 수 있도록 함 -->
						<c:set var="m" value="${msgs.message}"/>
						<div class="card">
							<div class="card-header " id="heading_${mcnt.index}">
								<div class="mb-0 row">
									<button class="btn btn-link collapsed col-lg-12" data-toggle="collapse" data-target="#collapse_${mcnt.index}" aria-expanded="false" aria-controls="collapse_${mcnt.index}">
										<span class="d-inline-block text-truncate float-left col-8 text-left"><strong>${m.uid}</strong> &nbsp;&nbsp; ${m.msg}</span>
										<span class="float-right">
											<span class="badge badge-primary badge-pill" >댓글 &nbsp; ${m.replycount}</span>  &nbsp;
											<span class="badge badge-danger badge-pill">♥ &nbsp; ${m.favcount}</span>
										</span>
									</button>
								</div>
							</div>
							
							<!-- 
							- 게시글 index를 저장하는 curmsg 가 null이라면 0 번째 게시물 오픈
							- curmsg랑 표시하려는 게시물의 인덱스랑 같다면 그 게시물 오픈
							- 그 외의 게시물을 닫기
							 -->
							<c:choose>
								<c:when test="${(curmsg == null) && (mcnt.index == 0)}">
									<div id="collapse_${mcnt.index}" class="collapse show" aria-labelledby="heading_${mcnt.index}" data-parent="#accordion">
								</c:when>
								<c:when test="${(curmsg == mcnt.index) && (curmsg != null) }">
									<div id="collapse_${mcnt.index}" class="collapse show" aria-labelledby="heading_${mcnt.index}" data-parent="#accordion">
								</c:when>
								<c:otherwise>
									<div id="collapse_${mcnt.index}" class="collapse" aria-labelledby="heading_${mcnt.index}" data-parent="#accordion">	
								</c:otherwise>
							</c:choose>
								 <img src="${pageContext.request.contextPath }/upload/${m.filename}"  class="card-img-top" alt="${m.filename }">
								<div class="card-body">
									<!-- 게시글 start -->
									<%-- <p>${m.msg}</p> 줄바꿈 처리함 --%>
									<p>${fn:replace((m.msg), newLineChar, "<br/>")}</p>
									 <div class="d-flex justify-content-between align-items-center mt-5">
									 	<span>
									   	 	<sns:smenu mid="${m.mid}" auid="${m.uid}" curmsg="${mcnt.index}" filename="${m.filename }"/>
									    </span>
									    <!-- 작성일 -->
									    <span class="text-muted">${m.date}</span>
									  </div>
									<%-- <p><sns:smenu mid="${m.mid}" auid="${m.uid}" curmsg="${mcnt.index}"/> 작성일 : ${m.date}</p> --%>
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
											<c:choose>
												<c:when test="${uid == null }">
													<div class="btn btn-outline-secondary disabled" style="padding-top: 18px;">등록</div>
												</c:when> 
												<c:otherwise>
										  			<button class="btn btn-outline-secondary" type="submit" id="button-addon2">등록</button>
												</c:otherwise>
											</c:choose>
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
				<script>
				// Example starter JavaScript for disabling form submissions if there are invalid fields
				(function() {
				  'use strict';
				  window.addEventListener('load', function() {
				    // Fetch all the forms we want to apply custom Bootstrap validation styles to
				    var forms = document.getElementsByClassName('needs-validation');
				    // Loop over them and prevent submission
				    var validation = Array.prototype.filter.call(forms, function(form) {
				      form.addEventListener('submit', function(event) {
				        if (form.checkValidity() === false) {
				          event.preventDefault();
				          event.stopPropagation();
				        }
				        form.classList.add('was-validated');
				      }, false);
				    });
				  }, false);
				})();
				</script>
				<%-- <h3>친구들의 최신 소식</h3>
				<div id="accordion">
					<!-- control에서 전달받은 data(MessageSet)를 forEacgh로 하나씩 반복 -->
					<!-- varStatus는 상태용 변수. mcnt.index는 0부터 카운트 -->
					<c:forEach varStatus="mcnt" var="msgs" items="${datas}">
						<!-- forEach의 값인 msgs로 message(게시글) 객체를 m으로 접근할 수 있도록 함 -->
						<c:set var="m" value="${msgs.message}"/>
						<h3>[${m.uid}]${m.msg} :: [좋아요 ${m.favcount} | 댓글 ${m.replycount}]</h3>
						<div>
							<p></p>
							<p><sns:smenu mid="${m.mid}" auid="${m.uid}" curmsg="${mcnt.index}"/>/ ${m.date}에 작성된 글입니다.</p>
							
							<ul class="reply">
								<!-- forEach의 값인 msgs로 rlist(댓글) 객체를 r로 접근할 수 있도록 함 -->
								<!-- rlist인 r을 forEach로 하나씩 반복 -->
								<c:forEach  var="r" items="${msgs.rlist}">
									<!-- 태그라이브러리 rmenu에 접근하여 curmsg, rid, ruid 값을 전달 -->
									<!-- 만약 uid(로그인아이디)와 ruid(작성자아이디)가 같으면 삭제버튼이 나타남 --> 
									<li>${r.uid } :: ${r.rmsg} - ${r.date} <sns:rmenu curmsg="${mcnt.index}" rid="${r.rid}" ruid="${r.uid}"/></li>
								</c:forEach>
							</ul>
							
							<form action="sns_control.jsp?action=newreply&cnt=${cnt}" method="post">
								<input type="hidden" name="mid" value="${m.mid}">
								<input type="hidden" name="uid" value="${uid}">
								<input type="hidden" name="suid" value="${suid}">
								<input type="hidden" name="curmsg" value="${mcnt.index}">				
								<sns:write type="rmsg"/>
							</form>
						</div>
					</c:forEach>
				</div> --%>
				
				<!-- 더보기를 누를 때 마다, cnt에 5를 더해서 게시물을 가져옴 -->
				<%-- <div align="center"><a href="sns_control.jsp?action=getall&cnt=${cnt+5}&suid=${suid}">더보기&gt;&gt;</a></div> --%>
				<!-- 존재하는 게시물보다 불러오는 게시물이 더 작을 때만, 더보기 버튼을 만들어라 -->
				<c:choose>
					<c:when test="${datas.size() < cnt }">
						<%-- <c:out value="마지막 게시물입니다." /> --%>
						<div class="btn btn-primary btn-lg btn-block disabled mt-3">마지막 게시물입니다.</div>
					</c:when>
					<c:otherwise>
						<a href="sns_control.jsp?action=getall&cnt=${cnt+5}&suid=${suid}" style="color:#fff;" class="btn btn-primary btn-lg btn-block mt-3">더보기</a>
						<%-- <div align="center"><a href="sns_control.jsp?action=getall&cnt=${cnt+5}&suid=${suid}">더보기&gt;&gt;</a></div> --%>
					</c:otherwise>
				</c:choose>
				
				
			</section>
			<jsp:include page="sns_aside.jsp" />
			<!-- end of sidebar -->
		</section>
	</div>

	<!-- <footer>
		<div class="container1">
			<section id="footer-area">

			<section id="footer-outer-block">
					<aside class="footer-segment">
							<h4>About</h4>
								<ul>
									<li><a href="#">About My Simple SNS</a></li>
									<li><a href="#">Copyright</a></li>
									<li><a href="#">Author</a></li>
								</ul>
					</aside>end of #first footer segment

					<aside class="footer-segment">
							<h4>Java Web Programming</h4>
								<ul>
									<li><a href="#">Book Information</a></li>
									<li><a href="#">Table of contents</a></li>
									<li><a href="#">Book History</a></li>
								</ul>
					</aside>end of #second footer segment

					<aside class="footer-segment">
							<h4>Contact Us</h4>
								<ul>
									<li><a href="#">Book Support</a></li>
									<li><a href="#">Publication</a></li>
									<li><a href="#">Investor Relations</a></li>
									</ul>
					</aside>end of #third footer segment
					
					<aside class="footer-segment">
							<h4>Hee Joung Hwang</h4>
								<p>&copy; 2014 <a href="#">dinfree.com</a> </p>
					</aside>end of #fourth footer segment

				</section>
				end of footer-outer-block

			</section>
			end of footer-area
		</div>
	</footer> -->
	
	

	<footer>
		<span>
			&copy; 2020 Copyright ShinHaeun
		</span>
	</footer>
	
	<jsp:include page="out_user.jsp" />
	<jsp:include page="new_user.jsp" /> 
</body>
</html>