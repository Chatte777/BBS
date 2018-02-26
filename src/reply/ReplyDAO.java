package reply;

import java.net.InetAddress;
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
			String ipStr;
			InetAddress ip = InetAddress.getLocalHost();
			if(ip.toString().equals("KoreaUniv-PC/192.168.219.90")) ipStr="localhost";
			else ipStr = "122.42.239.89";
			
			String dbURL = "jdbc:mysql://" +ipStr+ ":3306/BBS";
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
		String SQL = "SELECT count(1) FROM reply WHERE bbsID = ?";
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
	

	public Reply getReply(int bbsID, int replyID){
		String SQL = "SELECT * from REPLY WHERE bbsID = ? and replyID = ?";
		
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
	
	public int delete(int bbsID, int replyID){
		String SQL = "UPDATE REPLY SET replyAvailable=0 WHERE bbsID = ? and replyID = ?";
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
	
	public int update(int bbsId, int replyId, String replyContent){
		String SQL = "UPDATE reply SET replyContent=? WHERE bbsId=? and replyID=?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, replyContent);
			pstmt.setInt(2, bbsId);
			pstmt.setInt(3, replyId);
			
			return pstmt.executeUpdate();
			
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1; //Database error
	}
}
