package threadMaster;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ThreadMasterDAO {

	private Connection conn;
	private ResultSet rs;
	
	public ThreadMasterDAO() {
		try {
			String dbURL = "jdbc:mysql://127.0.0.1:3306/BBS";
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
	
	public int getNext(){
		String SQL = "SELECT thread_no FROM thread_master ORDER BY thread_no DESC";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
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
	
	public int write(String threadTitle, String threadMakeUser, String threadContent){
		String SQL = "INSERT INTO thread_master VALUES(?,?,?,?,?,?)";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, threadTitle);
			pstmt.setString(3, threadMakeUser);
			pstmt.setString(4, getDate());
			pstmt.setString(5, threadContent);
			pstmt.setInt(6, 1);
			
			return pstmt.executeUpdate();
			
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1; //Database error
	}
	
	public ArrayList<ThreadMaster> getList(int pageNumber){
		String SQL = "SELECT * from thread_master WHERE thread_no < ? AND thread_delete_yn = 1 ORDER BY thread_no DESC LIMIT 10";
		ArrayList<ThreadMaster> list = new ArrayList<ThreadMaster>();
		
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()-(pageNumber-1)*10);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()){
				ThreadMaster threadMaster = new ThreadMaster();
				threadMaster.setThreadNo(rs.getInt(1));
				threadMaster.setThreadTitle(rs.getString(2));
				threadMaster.setThreadMakeUser(rs.getString(3));
				threadMaster.setThreadMakeDt(rs.getString(4));
				threadMaster.setThreadContent(rs.getString(5));
				threadMaster.setThreadDeleteYn(rs.getInt(6));
				list.add(threadMaster);
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		return list; //Database error
	}
	
	public boolean nextPage(int pageNumber){
		String SQL = "SELECT * from thread_master WHERE thread_no < ? AND thread_delete_yn = 1";
		
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
	
	public ThreadMaster getThreadMaster(int threadNo){
		String SQL = "SELECT * from thread_master WHERE thread_no = ?";
		
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, threadNo);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()){
				ThreadMaster threadMaster = new ThreadMaster();
				threadMaster.setThreadNo(rs.getInt(1));
				threadMaster.setThreadTitle(rs.getString(2));
				threadMaster.setThreadMakeUser(rs.getString(3));
				threadMaster.setThreadMakeDt(rs.getString(4));
				threadMaster.setThreadContent(rs.getString(5));
				threadMaster.setThreadDeleteYn(rs.getInt(6));
				
				return threadMaster;
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		return null; 
	}
	
	public int update(int threadNo, String threadTitle, String threadContent){
		String SQL = "UPDATE thread_master SET thread_title=?, thread_content=? WHERE thread_no=?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, threadTitle);
			pstmt.setString(2, threadContent);
			pstmt.setInt(3, threadNo);
			
			return pstmt.executeUpdate();
			
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1; //Database error
	}
	
	public int delete(int threadNo){
		String SQL = "UPDATE thread_Master SET thread_delete_yn=2 WHERE thread_no = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, threadNo);
			
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1; //Database error
	}
}
