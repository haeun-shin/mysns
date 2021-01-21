<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- css -->
<link rel="stylesheet" href="./css/styles.css">

<aside id="sidebar2" class="col-12 col-md-3 col-xl-4 bd-sidebar">


<!-- 검색 start-->
<!-- <form name="frm_search" id="search_bar" class="m_form input-group mb-3 needs-validation" novalidate method="post" action="sns_control.jsp?action=search"  >
	<input id="search_text" class="form-control mr-sm-2" type="text" placeholder="검색어 입력" aria-label="Search" name="search">
	<button id="search_submit" class="btn my-2 my-sm-0" type="submit">검색</button>
</form> -->

<form name="frm_search" id="search_bar" class="m_form input-group mb-3 needs-validation shadow" novalidate method="post" action="sns_control.jsp?action=search"  >
    <div class="input-group w-100"> 
    	<input type="text" name="search" class="form-control search-form" style="width:55%;" placeholder="Search">
        <div class="input-group-append"> 
        	<button class="btn btn-primary search-button" type="submit"> <i class="fa fa-search"></i> </button> 
        </div>
    </div>
</form>
<!-- 검색 end -->

<!-- sidebar2 -->
	<ul class="list-group list-group-flush">
<li class="list-group-item list-group-item-dark" style="background-color: #282c37; color:#fff;">
	새로운 친구들
</li>
<c:forEach items="${nusers}" var="n">
<li class="d-flex justify-content-between align-items-center">
	<a href="sns_control.jsp?action=getall&suid=${n}"class="list-group-item list-group-item-action list-group-item-light">
		${n}
		<span class="badge badge-pill badge-dark float-right">></span>
	</a>
<%-- 						<li class="list-group-item  d-flex justify-content-between align-items-center">
						<a href="sns_control.jsp?action=getall&suid=${n}">${n}</a>
						</li> --%>
	
</li>
</c:forEach>
	</ul>

<!-- <br> <br>
<h3>We're Social Too!!</h3>
<img src="img/facebook_32.png"> <img src="img/twitter_32.png">
<img src="img/youtube_32.png"> <br> <br>
<br> <br>

<h3>Links</h3>
<ul>
	<li><a href="#">한빛미디어</a></li>
	<li><a href="#">가천대학교</a></li>
	<li><a href="#">가천대학교 길병원</a></li>
</ul> -->

</aside>