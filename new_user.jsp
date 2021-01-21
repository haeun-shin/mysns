<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>New User</title>

<script type="text/javascript">
	function join() {
		document.frmJoin.submit();
	}
</script>
</head>

<body>



<div class="modal fade" id="sns_join" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="sns_joinLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="sns_joinLabel">회원 가입</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form method="post" action="user_control.jsp?action=new" name="frmJoin">
			<table>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" size="10" required></td>
				</tr>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="uid" size="10" required></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="email" name="email" size="10"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd" size="10" required></td>
				</tr>
			</table> 
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" onClick="join()">가입하기</button>
      </div>
    </div>
  </div>
</body>
</html> 