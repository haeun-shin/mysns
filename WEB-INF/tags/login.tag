<%@ tag body-content="scriptless" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
 	function outuser() {
		window.open(
					"out_user.jsp",
					"outuser",
					"titlebar=no,location=no,scrollbars=no,resizeable=no,menubar=no,toolbar=no,width=300,height=240");
	} 
	
	function logout() {
		document.loginform.submit();
	}
</script>
<form name="loginform" method="post" action="user_control.jsp"  class="form-inline my-2 my-lg-0">
	<c:choose>
		<c:when test="${uid != null}">
			<div class="nav-item dropdown ">
		        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          ${uid }
		        </a>
		        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink" style="left:auto;right: -16px;">
		          <%-- <a class="dropdown-item" href="sns_control.jsp?action=getall&suid=${uid}" >내 글 모아보기</a> --%>
	          	  <a class="dropdown-item" href="javascript:logout()">로그아웃</a>
	          	  <input type="hidden" name="action" value="logout">
	          	  
	          	  <!-- <a class="dropdown-item" href="javascript:outuser()">회원탈퇴</a> -->
	          	  
	          	  <a class="dropdown-item" data-toggle="modal" data-target="#staticBackdrop"  style="cursor: pointer;">
					  회원 탈퇴
				  </a>
		        </div>
	      	</div>
<%-- 			<li class="nav-item"><a href="sns_control.jsp?action=getall&suid=${uid}"  class="nav-link">${uid}님 글 모아보기</a></li>
			
			<li class="nav-item"><input type="submit" value="로그아웃"></li>
			<li class="nav-item"><a href="">회원탈퇴</a></li> --%>
		</c:when>
		<c:otherwise>
			<!-- <li class="nav-item"><a href="#"  class="nav-link">로그인</a></li> -->
				<input type="hidden" name="action" value="login" >
				<input type="text" name="uid" size="10" class="form-control mr-sm-2"  placeholder="아이디"> 
				<input type="password" name="passwd" size="10" class="form-control mr-sm-2"  placeholder="비밀번호">
				<input type="submit" value="로그인" class="btn btn-dark">
	</c:otherwise>
	</c:choose>
	
</form>
