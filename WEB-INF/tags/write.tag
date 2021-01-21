<%@ tag body-content="scriptless" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%@ attribute name="type" %>

<c:if test="${uid != null}">
<c:choose> 
	<%-- <c:when test="${type == 'msg'}"><input  type="text" name="msg" maxlength="100" class="form-control" placeholder="내용을 입력하세요." aria-label="내용을 입력하세요." aria-describedby="button-addon2"></c:when>
	<c:when test="${type == 'rmsg'}">댓글달기 <input  type="text" name="rmsg" maxlength="50" size="60" class="form-control" placeholder="내용을 입력하세요." aria-label="내용을 입력하세요." aria-describedby="button-addon2"></c:when> --%>
	<c:when test="${type == 'msg'}">
		<textarea name="msg" maxlength="100" class="form-control" placeholder="내용을 입력하세요." aria-label="내용을 입력하세요." aria-describedby="button-addon2" wrap="hard" required></textarea>
		<!-- <label for="exampleFormControlTextarea1">내용 입력</label> -->
   		
   		<!-- <textarea  class="form-control" placeholder="내용을 입력하세요." aria-label="내용을 입력하세요." aria-describedby="button-addon2" wrap="hard" required rows="3"></textarea> -->
	</c:when>
	<c:when test="${type == 'rmsg'}">
		<textarea name="rmsg" maxlength="50" size="60" class="form-control" placeholder="댓글을 입력하세요." aria-label="댓글을 입력하세요." aria-describedby="button-addon2" required></textarea>
	</c:when>
</c:choose>
</c:if>

<c:if test="${uid == null}">
<c:choose> 
	<%-- <c:when test="${type == 'msg'}"><input type="text" name="msg" maxlength="100" disabled="disabled"  value="작성하려면 로그인 하세요!!" class="form-control" aria-describedby="button-addon2"></c:when>
	<c:when test="${type == 'rmsg'}">댓글달기 <input type="text" name="rmsg" maxlength="50" size="60" disabled="disabled" value="작성하려면 로그인 하세요!!" class="form-control" aria-describedby="button-addon2"></c:when> --%>
	<c:when test="${type == 'msg'}"><textarea name="msg" maxlength="100" disabled  placeholder="작성하려면 로그인 하세요!!" class="form-control" aria-describedby="button-addon2"></textarea></c:when>
	<c:when test="${type == 'rmsg'}"><textarea name="rmsg" maxlength="50" size="60" disabled placeholder="작성하려면 로그인 하세요!!" class="form-control" aria-describedby="button-addon2"></textarea></c:when>
</c:choose>
</c:if>