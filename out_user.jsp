<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Out User</title>
<script type="text/javascript">
	function check_pw() {
		// 아이디가 공백이면 alert
		if(document.getElementById('ch_uid').value == null || document.getElementById('ch_uid').value == '') {
			alert('아이디를 입력해주세요.')
		
		// 아이디가 정상적으로 입력
		} else {
			// 현재 로그인한 아이디와 입력한 아이디가 같다면
			if(document.getElementById('ch_uid').value == '${uid}') {
				// 비밀번호와 확인비밀번호 공백체크
				if(document.getElementById('ch_passwd').value !='' && document.getElementById('ch_passwd2').value!=''){
					// 비밀번호와 확인비밀번호가 일치하면 이동
		             if(document.getElementById('ch_passwd').value==document.getElementById('ch_passwd2').value){
		                 document.frmOut.submit();
		             }
		             else{
		                 alert('비밀번호가 일치하지 않습니다.');
		             }
		         } else {
		        	 alert('비밀번호를 입력해주세요.');
		         }
			} else {
				alert('아이디를 확인해주세요.');
			}
		}
		
	}
</script>
</head>


<body>

<!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#staticBackdrop">
  회원 탈퇴
</button> -->

<div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">회원 탈퇴</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form name="frmOut" method="post" action="user_control.jsp?action=out">
		<table>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="uid" size="10" id="ch_uid" required ></td>
			</tr>
		 	<tr>
				<td>비밀번호</td>
				<td><input type="password" name="passwd" id="ch_passwd" size="10" required></td>
			</tr> 
			<tr>
				<td>비밀번호 확인</td>
				<td>
					<input type="password" name="passwd2" id="ch_passwd2" size="10" required> 
				</td>
			</tr>
			<tr>
				<td colspan="2">
					 작성한 게시물과 댓글까지 삭제하시겠습니까?
				</td>
			</tr>
			<tr>
				<td colspan="2">
					예 <input type="checkbox" name="check" value="yes" onclick="doOpenCheck(this)" checked>
					아니오 <input type="checkbox" name="check" value="no" onclick="doOpenCheck(this)">
				</td>
			</tr>
		</table> 
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" onClick="check_pw()">탈퇴하기</button>
      </div>
    </div>
  </div>
</div>

<!-- 체크박스 하나만 선택할 수 있도록 -->
<script type="text/javascript">
function doOpenCheck(chk){
    var obj = document.getElementsByName("check");
    for(var i=0; i<obj.length; i++){
        if(obj[i] != chk){
            obj[i].checked = false;
        }
    }
} 
</script>
</body>
</html>