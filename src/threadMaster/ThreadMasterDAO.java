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
		String SQL = "INSERT INTO thread_master VALUES(?,?,?,?,?,?,?,?,?,?)";
		int tmpNextNo = getNext();
		
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, tmpNextNo);
			pstmt.setString(2, threadTitle);
			pstmt.setInt(3, 1);
			pstmt.setString(4, threadContent);
			pstmt.setString(5, threadMakeUser);
			pstmt.setString(6, getDate());
			pstmt.setInt(7, 1);
			pstmt.setInt(8, 1);
			pstmt.setInt(9, 1);
			pstmt.setInt(10, 1);

			pstmt.executeUpdate();
			
			return tmpNextNo;
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
				threadMaster.setThreadTm(rs.getInt(3));
				threadMaster.setThreadContent(rs.getString(4));
				threadMaster.setThreadMakeUser(rs.getString(5));
				threadMaster.setThreadMakeDt(rs.getString(6));
				threadMaster.setThreadReadCnt(rs.getInt(7));
				threadMaster.setThreadLikeCnt(rs.getInt(8));
				threadMaster.setThreadDislikeCnt(rs.getInt(9));
				threadMaster.setThreadDeleteYn(rs.getInt(10));
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
				threadMaster.setThreadTm(rs.getInt(3));
				threadMaster.setThreadContent(rs.getString(4));
				threadMaster.setThreadMakeUser(rs.getString(5));
				threadMaster.setThreadMakeDt(rs.getString(6));
				threadMaster.setThreadReadCnt(rs.getInt(7));
				threadMaster.setThreadLikeCnt(rs.getInt(8));
				threadMaster.setThreadDislikeCnt(rs.getInt(9));
				threadMaster.setThreadDeleteYn(rs.getInt(10));
				
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
			
			pstmt.executeUpdate();
			return threadNo;
			
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
