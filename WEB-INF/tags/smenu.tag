<%@ tag body-content="scriptless" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 게시글 고유 번호 -->
<%@ attribute name="mid" %>
<!-- 게시글 작성자 아이디 -->
<%@ attribute name="auid" %>
<!-- 인덱스 -->
<%@ attribute name="curmsg" %>
<!-- 파일면 -->
<%@ attribute name="filename" %>
	<a href="sns_control.jsp?action=fav&mid=${mid}&curmsg=${curmsg}&cnt=${cnt}&suid=${suid}" class="badge badge-danger">♥ 좋아요</a>
	<%-- <a href="sns_control.jsp?action=fav&mid=${mid}&curmsg=${curmsg}&cnt=${cnt}&suid=${suid}">좋아요</a> --%>
<c:if test="${uid == auid}">
	<%-- <a href="sns_control.jsp?action=delmsg&mid=${mid}&curmsg=${curmsg}&cnt=${cnt}&suid=${suid}">삭제</a> --%>
	<a href="sns_control.jsp?action=delmsg&mid=${mid}&curmsg=${curmsg}&cnt=${cnt}&suid=${suid}&filename=${filename}" class="badge badge-secondary">삭제</a>
</c:if>
	