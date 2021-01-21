package mysns.sns;

import java.util.ArrayList;

/**
 * File : MessageSet.java
 * Desc : SNS 게시글 과 댓글을 묶어 sns_main.jsp 로 보내기 위한 DTO(Data Transfer Object) 클래스
 * @author 황희정(dinfree@dinfree.com)
 */
public class MessageSet {
	// 메시지
	private Message message;
	
	// 해당 메시지에 대한 댓글 목록
	private ArrayList<Reply> rlist = new ArrayList<Reply>();
	
	public Message getMessage() {
		return message;
	}
	public void setMessage(Message message) {
		this.message = message;
	}
	public ArrayList<Reply> getRlist() {
		return rlist;
	}
	public void setRlist(ArrayList<Reply> rlist) {
		this.rlist = rlist;
	}
}
