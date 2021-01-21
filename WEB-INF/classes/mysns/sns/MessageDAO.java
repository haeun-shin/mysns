package mysns.sns;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import mysns.member.Member;
import mysns.member.MemberDAO;
import mysns.util.DBManager;


/**
 * File : MessageDAO.java
 * Desc : SNS 게시글 Data Access Object 클래스
 *
 */
public class MessageDAO {
	Connection conn;
	PreparedStatement pstmt;
	Statement stmt;
	ResultSet rs;
	Logger logger = LoggerFactory.getLogger(MemberDAO.class);
	
	public ArrayList<MessageSet> getAll(int cnt, String suid) {
		// 첫페이지 요청인 경우, 기본 게시물 5개씩 -> cnt = 5
		
		ArrayList<MessageSet> datas = new ArrayList<MessageSet>();
		conn = DBManager.getConnection();
		String sql;

		try {
			// 전체 게시물인 경우
			// suid의 값이 없을 경우
			if((suid == null) || (suid.equals(""))) {
				// 게시글을 날짜 역순으로 정렬
				sql = "select * from s_message order by date desc limit 0,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cnt);
			}
			// 특정 회원 게시물 only 인 경우
			else{
				// 게시글을 날짜 역순으로 정렬
				sql = "select * from s_message where uid=? order by date desc limit 0,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,suid);
				pstmt.setInt(2,cnt);
			}
			
			// 게시글 정렬해서 가져온걸 rs에 넣음
			ResultSet rs = pstmt.executeQuery();
			
			// 게시글을 하나씩 반복함
			while(rs.next()) {
				// MessageSet -> 게시글 + 댓글
				MessageSet ms = new MessageSet();
				// Message -> 게시글
				Message m = new Message();
				// ArrayList<Reply> -> 댓글
				ArrayList<Reply> rlist = new ArrayList<Reply>();
				
				// 게시글을 Message 클래스에 저장
				m.setMid(rs.getInt("mid"));
				m.setMsg(rs.getString("msg"));
				m.setDate(rs.getDate("date")+"   "+rs.getTime("date"));
				m.setFavcount(rs.getInt("favcount"));
				m.setUid(rs.getString("uid"));
				m.setFilename(rs.getString("filename"));
				
				// 댓글을 날짜순으로 n개씩 정렬.
				String rsql = "select *  from s_reply where mid=? order by date";
				pstmt = conn.prepareStatement(rsql);
				pstmt.setInt(1,rs.getInt("mid"));
				ResultSet rrs = pstmt.executeQuery();
				
				// 댓글을 하나씩 반복
				while(rrs.next()) {
					// 댓글을 Reply클래스에 저장
					Reply r = new Reply();
					r.setRid(rrs.getInt("rid"));
					r.setUid(rrs.getString("uid"));
					r.setRmsg(rrs.getString("rmsg"));
					r.setDate(rrs.getDate("date")+"  "+rrs.getTime("date"));
					// ArrayList에 추가
					rlist.add(r);
				}
				// 맨 마지막으로 가서
				rrs.last();
				// 댓글 갯수 세서 Message 댓글 갯수에 저장
				m.setReplycount(rrs.getRow());
				//System.out.println("r count"+rrs.getRow());
				
				// MessageSet에 게시글 저장
				ms.setMessage(m);
				// MessageSet에 댓글 목록 저장
				ms.setRlist(rlist);
				// 댓글 + 게시글을 가져갈 ArrayList data에 <게시글 + 댓글>을 저장
				datas.add(ms);
				// 클로즈
				rrs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
		}
		finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				//rs.close();
				//pstmt.close();
				//conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println(e.getErrorCode());
			}
		}		
		return datas;
	}
	
	/**
	 * 신규 메시지 등록
	 * @param msg
	 * @param filerealName
	 * @return
	 */
	public boolean newMsg(Message msg) {
		conn = DBManager.getConnection();
		String sql;
		
		if(msg.getFilename() != null) {
			sql = "insert into s_message(uid, msg, date, filename) values(?,?,now(),'";
			sql += msg.getFilename();
			sql += "')";
		} else {
			sql = "insert into s_message(uid, msg, date) values(?,?,now())";
		}
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, msg.getUid());
			pstmt.setString(2, msg.getMsg());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
			return false;
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;	
}
	
	/**
	 * 메시지 삭제
	 * @param mid
	 * @return
	 */
	public boolean delMsg(int mid) {
		conn = DBManager.getConnection();
		String sql = "delete from s_message where mid = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
			return false;
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;	
	}
		
	/**
	 * 게시글에 대한 답글 등록, 원 게시물에 대한 mid 필요
	 * @param mid
	 * @param rmsg
	 * @return
	 */
	public boolean newReply(Reply reply) {
		conn = DBManager.getConnection();
		String sql = "insert into s_reply(mid,uid,rmsg,date) values(?,?,?,now())";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reply.getMid());
			pstmt.setString(2, reply.getUid());
			pstmt.setString(3, reply.getRmsg());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
			return false;
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}
	
	/**
	 * 답글 삭제
	 * @param rid
	 * @return
	 */
	public boolean delReply(int rid) {
		conn = DBManager.getConnection();
		String sql = "delete from s_reply where rid = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rid);;
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
			return false;
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}
	
	/**
	 * 좋아요 추가
	 * @param mid
	 */
	public void favorite(int mid) {
		conn = DBManager.getConnection();
		// 좋아요 추가를 위해 favcount 를 +1 해서 update 함
		String sql = "update s_message set favcount=favcount+1 where mid=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	
	/**
	 * 멤버 검색
	 * @param search
	 * @return datas
	 */
	public ArrayList<Member> search_member(int cnt, String search) {
		
		ArrayList<Member> s_members = new ArrayList<Member>();
		
		conn = DBManager.getConnection();
		String sql;

		try {
			
			// 멤버를 날짜 역순으로 정렬 (최신순)
			sql = "select * from s_member ";
			sql += "where uid like ";
			sql += "'%" + search + "%' ";
			sql += "order by date desc limit 0,?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cnt);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Member m = new Member();
				
				m.setUid(rs.getString("uid"));
				m.setName(rs.getString("name"));
				m.setEmail(rs.getString("email"));
				
				s_members.add(m);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("Error Code : {}",e.getErrorCode());
		}
		
		return s_members;
	}
	
	
	/**
	 * 게시글 검색
	 * @param search
	 * @return 
	 */
	public ArrayList<Message> search_message(int cnt, String search) {
		
		ArrayList<Message> s_messages = new ArrayList<Message>();
		
		conn = DBManager.getConnection();
		String sql;

		try {
			
			// 게시글을 날짜 역순으로 정렬 (최신순)
			sql = "select * from s_message ";
			sql += "where msg like ";
			sql += "'%" + search + "%' ";
			sql += "order by date desc limit 0,?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cnt);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Message m = new Message();
				m.setMid(rs.getInt("mid"));
				m.setUid(rs.getString("uid"));
				m.setMsg(rs.getString("msg"));
				m.setDate(rs.getString("date"));
				
				s_messages.add(m);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("Error Code : {}",e.getErrorCode());
		}
		
		return s_messages;
	}
	
	
	/**
	 * 댓글 검색
	 * @param search
	 * @return datas
	 */
	public ArrayList<Reply> search_reply(int cnt, String search) {
		
		ArrayList<Reply> s_reply = new ArrayList<Reply>();
		
		conn = DBManager.getConnection();
		String sql;

		try {
			
			// 댓글을 날짜 역순으로 정렬 (최신순)
			sql = "select * from s_reply ";
			sql += "where rmsg like ";
			sql += "'%" + search + "%' ";
			sql += "order by date desc limit 0,?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cnt);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Reply m = new Reply();
				m.setMid(rs.getInt("mid"));
				m.setUid(rs.getString("uid"));
				m.setRmsg(rs.getString("rmsg"));
				m.setDate(rs.getString("date"));
				
				s_reply.add(m);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("Error Code : {}",e.getErrorCode());
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return s_reply;
	}
	
	
	
	/**
	 * 특정 게시물 가져오기
	 * @param mid
	 * @return 
	 */
	public ArrayList<MessageSet> getMessage(int mid) {
		ArrayList<MessageSet> getMessage = new ArrayList<MessageSet>();
		
		conn = DBManager.getConnection();
		String sql;

		try {
			
			// 게시물 번호로 게시물 가져오기
			sql = "select * from s_message where mid=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mid);
			
			rs = pstmt.executeQuery();
			rs.next();
			
			// MessageSet -> 게시글 + 댓글
			MessageSet ms = new MessageSet();
			// Message -> 게시글
			Message m = new Message();
			// ArrayList<Reply> -> 댓글
			ArrayList<Reply> rlist = new ArrayList<Reply>();
			
			m.setMid(rs.getInt("mid"));
			m.setMsg(rs.getString("msg"));
			m.setDate(rs.getDate("date")+"   "+rs.getTime("date"));
			m.setFavcount(rs.getInt("favcount"));
			m.setUid(rs.getString("uid"));
			
			
			// 댓글을 날짜순으로 n개씩 정렬.
			String rsql = "select *  from s_reply where mid=? order by date";
			pstmt = conn.prepareStatement(rsql);
			pstmt.setInt(1,rs.getInt("mid"));
			ResultSet rrs = pstmt.executeQuery();
			
			// 댓글을 하나씩 반복
			while(rrs.next()) {
				// 댓글을 Reply클래스에 저장
				Reply r = new Reply();
				r.setRid(rrs.getInt("rid"));
				r.setUid(rrs.getString("uid"));
				r.setRmsg(rrs.getString("rmsg"));
				r.setDate(rrs.getDate("date")+"  "+rrs.getTime("date"));
				// ArrayList에 추가
				rlist.add(r);
			}
			// 맨 마지막으로 가서
			rrs.last();
			// 댓글 갯수 세서 Message 댓글 갯수에 저장
			m.setReplycount(rrs.getRow());
			//System.out.println("r count"+rrs.getRow());
			
			// MessageSet에 게시글 저장
			ms.setMessage(m);
			// MessageSet에 댓글 목록 저장
			ms.setRlist(rlist);
			// 댓글 + 게시글을 가져갈 ArrayList data에 <게시글 + 댓글>을 저장
			getMessage.add(ms);
			// 클로즈
			rrs.close();
		
		} catch (SQLException e) {
			e.printStackTrace();
			logger.info("Error Code : {}",e.getErrorCode());
		}
		
		return getMessage;
	}
	
}
