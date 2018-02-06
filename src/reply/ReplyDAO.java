package reply;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ReplyDAO {

	private Connection conn;
	private ResultSet rs;
	
	public ReplyDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	
	public String getDate(){
		String SQL = "select now()";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				return rs.getString(1);
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		return ""; //Database error
	}
	
	public int getNext(int bbsID){
		String SQL = "SELECT count(replyID) FROM reply WHERE bbsID = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				return rs.getInt(1)+1;
			}
			return 1; // 첫 게시물일 경우.
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1; //Database error
	}

	
	public int write(int bbsID, String userID, String replyContent){
		String SQL = "INSERT INTO reply VALUES(?,?,?,?,?,?)";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			pstmt.setInt(2, getNext(bbsID));
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, replyContent);
			pstmt.setInt(6, 1);
			
			return pstmt.executeUpdate();
			
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1; //Database error
	}
	
	/*
	public ArrayList<Reply> getList(int pageNumber){
		String SQL = "SELECT * from BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		ArrayList<Reply> list = new ArrayList<Reply>();
		
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()-(pageNumber-1)*10);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()){
				Reply bbs = new Reply();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		return list; //Database error
	}
	*/
	public ArrayList<Reply> getList(int bbsID){
		String SQL = "SELECT * from reply WHERE bbsID= ? and replyAvailable = 1";
		ArrayList<Reply> list = new ArrayList<Reply>();
		
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);			
			
			rs = pstmt.executeQuery();
			
			while (rs.next()){
				Reply reply = new Reply();
				reply.setBbsID(rs.getInt(1));
				reply.setReplyID(rs.getInt(2));
				reply.setUserID(rs.getString(3));
				reply.setReplyDate(rs.getString(4));
				reply.setReplyContent(rs.getString(5));
				reply.setReplyAvailable(rs.getInt(6));
				list.add(reply);
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		return list; //Database error
	}
	
	 
	/*
	public boolean nextPage(int pageNumber){
		String SQL = "SELECT * from BBS WHERE bbsID < ? AND bbsAvailable = 1";
		
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()-(pageNumber-1)*10);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()){
				return true;
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		return false; 
	}
	*/
	
	/*
	public Reply getReply(int bbsID, int replyID){
		String SQL = "SELECT * from BBS WHERE bbsID = ?";
		
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()){
				Reply bbs = new Reply();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				
				return bbs;
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		return null; 
	}
	*/
	public Reply getReply(int bbsID, int replyID){
		String SQL = "SELECT * from BBS WHERE bbsID = ? and replyID = ?";
		
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			pstmt.setInt(2, replyID);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()){
				Reply reply = new Reply();
				reply.setBbsID(rs.getInt(1));
				reply.setReplyID(rs.getInt(2));
				reply.setUserID(rs.getString(3));
				reply.setReplyDate(rs.getString(4));
				reply.setReplyContent(rs.getString(5));
				reply.setReplyAvailable(rs.getInt(6));
				
				return reply;
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		return null; 
	}
	
	/*
	public int update(int bbsID, String bbsTitle, String bbsContent){
		String SQL = "UPDATE BBS SET bbsTitle=?, bbsContent=? WHERE bbsID=?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			
			return pstmt.executeUpdate();
			
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1; //Database error
	}
	*/
	public int update(int bbsID, int replyID, String replyContent){
		String SQL = "UPDATE reply SET replyContent=? WHERE bbsID=? and replyID=?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, replyContent);
			pstmt.setInt(2, replyID);
			
			return pstmt.executeUpdate();
			
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1; //Database error
	}
	
	/*
	public int delete(int bbsID){
		String SQL = "UPDATE BBS SET bbsAvailable=0 WHERE BBSid = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1; //Database error
	}
	*/
	public int delete(int bbsID, int replyID){
		String SQL = "UPDATE BBS SET bbsAvailable=0 WHERE BBSid = ? and replyID = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			pstmt.setInt(2, replyID);
			
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1; //Database error
	}
}
