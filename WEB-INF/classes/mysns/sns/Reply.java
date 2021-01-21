package mysns.sns;


/**
 * File : Reply.java
 * Desc : 답글 Data Object 클래스
 * @author 황희정(dinfree@dinfree.com)
 */
public class Reply {
	// 게시글 고유 번호
	private int mid;
	
	// 댓글 고유 번호 AutoIncrement
	private int rid;
	
	// 답글 작성자 아이디 
	private String uid;
	
	// 답글 내용
	private String rmsg;
	
	// 답글 작성일자
	private String date;

	public int getRid() {
		return rid;
	}

	public void setRid(int rid) {
		this.rid = rid;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getMid() {
		return mid;
	}

	public void setMid(int mid) {
		this.mid = mid;
	}

	public String getRmsg() {
		return rmsg;
	}

	public void setRmsg(String rmsg) {
		this.rmsg = rmsg;
	}
	
	
	
}
