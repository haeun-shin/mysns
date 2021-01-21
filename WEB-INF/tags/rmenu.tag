<%@ tag body-content="scriptless" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 태그에서 속성 가져오기 <%@attribute name="속성값" %> --%>
<!-- 댓글 고유 번호(Reply.rid) -->
<%@ attribute name="rid" %>
<!-- 댓글 작성자 아이디(Reply.uid) -->
<%@ attribute name="ruid" %>
<!-- 인덱스 -->
<%@ attribute name="curmsg" %>

<!-- 만약 <작성자>와 <댓글작성자아이디>가 같다면 보여라 -->
<c:if test="${uid == ruid}">
	<a href="sns_control.jsp?action=delreply&rid=${rid}&curmsg=${curmsg}&cnt=${cnt}&suid=${suid}" class="badge badge-secondary">삭제</a>
</c:if>
