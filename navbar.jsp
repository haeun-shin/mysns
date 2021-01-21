<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="sns"%>   


<div style="width:100%; background-color:#fff;" class="shadow" >
<nav class="navbar navbar-expand-lg navbar-light" style="background-color:#fff;">
  <a class="navbar-brand" href="sns_control.jsp?action=getall" style="color:#282c37;"><strong>에센에스</strong></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  
  <div class="collapse navbar-collapse" id="navbarNav" >
    <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
	  <c:choose>
	  	<c:when test="${uid == null }">
	  		<li class="nav-item">
	        	<!-- <a class="nav-link" href="javascript:newuser()">회원가입</a> -->
	        	<a class="nav-link" data-toggle="modal" data-target="#sns_join" style="cursor: pointer;">회원가입</a>
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
</nav>
</div>
