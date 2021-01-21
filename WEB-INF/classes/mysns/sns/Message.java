package mysns.sns;

/**
 * File : Message.java
 * Desc : SNS 게시글 Data Object 클래스
 * @author 황희정(dinfree@dinfree.com)
 *
 */
public class Message {

	// 게시글 시퀀스 id
	private int mid;
	
	// 게시글 작성자
	private String uid;
	
	// 게시글 내용
	private String msg;
	
	// 게시글 작성일, 시간
	private String date;
	
	// 좋아요 회수
	private int favcount;
	
	// 댓글 갯수
	private int replycount;
	
	// 파일 이름
	private String filename;
	
	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public int getMid() {
		return mid;
	}

	public void setMid(int mid) {
		this.mid = mid;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getFavcount() {
		return favcount;
	}

	public void setFavcount(int favcount) {
		this.favcount = favcount;
	}

	public int getReplycount() {
		return replycount;
	}

	public void setReplycount(int replycount) {
		this.replycount = replycount;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}
	
}