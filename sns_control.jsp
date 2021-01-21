<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" import="mysns.sns.*,mysns.member.*,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 메시지 처리 빈즈 -->
<jsp:useBean id="msg" class="mysns.sns.Message" />
<jsp:useBean id="msgdao" class="mysns.sns.MessageDAO" />
<jsp:useBean id="reply" class="mysns.sns.Reply" />

<!-- 프로퍼티 set -->
<jsp:setProperty name="msg" property="*" />
<jsp:setProperty name="reply" property="*" />


<!-- 파일업로드 위한 라이브러리 임포트 -->
<%@ page import="java.io.File" %>

<!-- 파일 이름이 동일한게 나오면 자동으로 다른걸로 바꿔주고 그런 행동 해주는것 -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<!-- 실제로 파일 업로드 하기 위한 클래스 -->
<%@ page import="com.oreilly.servlet.MultipartRequest" %>

<!-- \\ 처리하기위한 클래스 -->
<%@ page import="java.util.regex.Matcher" %>

<%
	// 기본 파라미터 정리
	// 컨트롤러 요청 action 코드 값
	String action = request.getParameter("action");

	// 다음 페이지 요청 카운트
	String cnt = request.getParameter("cnt");

	// 특정 회원 게시물 only
	String suid = request.getParameter("suid");
	
	// 홈 URL
	String home;
	
	// 메시지 페이지 카운트
	int mcnt;
	
	// 검색어
	String search = request.getParameter("search");
	
	if((cnt != null) && (suid !=null)) {
		// 각 action 처리후 메인으로 되돌아가기 위한 기본 url
		home = "sns_control.jsp?action=getall&cnt="+cnt+"&suid="+suid;
		mcnt = Integer.parseInt(request.getParameter("cnt"));
	}
	else {
		// 게시글 작성시에는 현재 상태와 상관 없이 전체 게시물의 첫페이지로 이동 하기 위한 url
		home = "sns_control.jsp?action=getall";
		// 첫페이지 요청인 경우, 기본 게시물 5개씩
		mcnt = 5;
	}
	
	// 댓글이 달린 게시물 위치 정보 -> accordion 상태 유지 목적
	request.setAttribute("curmsg", request.getParameter("curmsg"));

	// 새로운 메시지 등록
	if (action.equals("newmsg")) {

		// 현재 파일의 절대경로 : /C:/Users/ez200520/eclipse-workspace/mysns/build/classes/mysns/sns/
		String uploadDir = this.getClass().getResource("").getPath();
		// C:/Users/ez200520/eclipse-workspace/mysns/ + Webcontent/upload
		uploadDir = uploadDir.substring(1,uploadDir.indexOf(".metadata"))+"mysns/WebContent/upload";
		// C:\\Users\\ez200520\\eclipse-workspace\\mysns\\Webcontent\\upload
		uploadDir = uploadDir.replaceAll("/", Matcher.quoteReplacement(File.separator));
		
		// 10MB까지 저장 가능하게함
		int maxSize = 1024 * 1024 * 10;
		String encoding = "UTF-8";
		
		// 사용자가 전송한 파일정보를 토대로 업로드 장소에 팡일 업르도 수행할 수 있게 함
		MultipartRequest multipartRequest = new MultipartRequest(request, uploadDir, maxSize, encoding, new DefaultFileRenamePolicy());
		
		// 중복된 파일이름이 있기에 fileRealName이 실제로 서버에 저장된 경로이자 파일
        // fineName은 사용자가 올린 파일의 이름이다
		// 이전 클래스 name = "file" 실제 사용자가 저장한 실제 네임
		/*String fileName = multipartRequest.getOriginalFileName("filename");*/
		
		// 실제 서버에 업로드 된 파일시스템 네임
		String fileRealName = multipartRequest.getFilesystemName("filename");
		
		msg.setFilename(fileRealName); 
		
		/* 폼타입이 enctype="multipart/form-data" 일 경우엔 request.getParameter()를 사용할 수 없다 */
		msg.setUid(multipartRequest.getParameter("uid"));
		msg.setMsg(multipartRequest.getParameter("msg"));
		
		if (msgdao.newMsg(msg))
			response.sendRedirect(home);
		else
			throw new Exception("메시지 등록 오류!!");
		
	// 댓글 등록
	} else if (action.equals("newreply")) {
		if (msgdao.newReply(reply))
			pageContext.forward(home);
		else
			throw new Exception("댓글 등록 오류!!");
	} 
	// 메시지 삭제
	else if (action.equals("delmsg")) {
		if(msgdao.delMsg(msg.getMid())) {
			// 만약 메시지 삭제가 완료되면 등록된 이미지도 지우기
			String filename = request.getParameter("filename");
			
			// 현재 파일의 절대경로 : /C:/Users/ez200520/eclipse-workspace/mysns/build/classes/mysns/sns/
			String uploadDir = this.getClass().getResource("").getPath();
			// C:/Users/ez200520/eclipse-workspace/mysns/ + Webcontent/upload
			uploadDir = uploadDir.substring(1,uploadDir.indexOf(".metadata"))+"mysns/WebContent/upload";
			// C:\\Users\\ez200520\\eclipse-workspace\\mysns\\Webcontent\\upload
			uploadDir = uploadDir.replaceAll("/", Matcher.quoteReplacement(File.separator));
			
			File f = new File(uploadDir + "\\" + filename);
			if(f.exists()) {
				f.delete();
			}
			
			response.sendRedirect(home);			
		} else {
			throw new Exception("메시지 등록 오류!!");
		}
	} 
	// 댓글 삭제
	else if (action.equals("delreply")) {
		if(msgdao.delReply(reply.getRid())) {
			pageContext.forward(home);
		}
		else
			throw new Exception("메시지 등록 오류!!");;
	} 
	// 전체 게시글 가져오기
	else if (action.equals("getall")) {
		ArrayList<MessageSet> datas = msgdao.getAll(mcnt,suid);
		ArrayList<String> nusers = new MemberDAO().getNewMembers();

		// 게시글 목록
		request.setAttribute("datas", datas);

		// 신규 회원 목록
		request.setAttribute("nusers", nusers);	

		// 특정 회원 only 인 경우 회원 uid 를 request  scope 에 저장
		request.setAttribute("suid",suid);
		
		// 현재 페이지 카운트 정보 저장
		request.setAttribute("cnt",mcnt);

		pageContext.forward("sns_main.jsp");
	}
	// 좋아요 추가
	else if(action.equals("fav")) {
		msgdao.favorite(msg.getMid());
		pageContext.forward(home);
	}
	
	// 검색
	else if(action.equals("search")) {
		ArrayList<String> nusers = new MemberDAO().getNewMembers();
		// 신규 회원 목록
		request.setAttribute("nusers", nusers);	
		
		String st_mid = request.getParameter("cnt");
		if(st_mid != null) {
			mcnt = Integer.parseInt(st_mid);
		} else {
			mcnt = 9;
		}
		
		// 현재 페이지 카운트 정보 저장
		request.setAttribute("cnt", mcnt);
		// 검색어 저장
		request.setAttribute("search", search);
		
		// 멤버 검색
		ArrayList<Member> s_members = msgdao.search_member(mcnt, search);
		// 게시글 검색
		ArrayList<Message> s_messages = msgdao.search_message(mcnt, search);
		// 댓글 검색
		ArrayList<Reply> s_replys = msgdao.search_reply(mcnt, search);		
		
		// 검색 멤버 목록
		request.setAttribute("s_members", s_members);
		// 검색 게시글 목록
		request.setAttribute("s_messages", s_messages);
		// 검색 댓글 목록
		request.setAttribute("s_replys", s_replys);
		
		pageContext.forward("sns_search.jsp");
	}
	
	// 특정 게시물 가져오기
	else if(action.equals("getMessage")) {
		ArrayList<String> nusers = new MemberDAO().getNewMembers();
		// 신규 회원 목록
		request.setAttribute("nusers", nusers);	
		
		// mid
		int mid = 0;
		String st_mid = request.getParameter("mid");
		
		if(st_mid != null) {
			mid = Integer.parseInt(st_mid);
		} 
		
		// 특정 게시물 검색
		ArrayList<MessageSet> getMessage = msgdao.getMessage(mid);
		
		// 특정 게시물
		request.setAttribute("getMessage", getMessage);
		
		pageContext.forward("sns_result.jsp");
		
	}
	
	
%>
