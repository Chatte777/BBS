package mountainFile;

import java.net.InetAddress;
import java.sql.Connection;	
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MountainFileDAO {
	private Connection conn;

	public MountainFileDAO() {
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
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int getNext(int mountainNo){
		String SQL = "SELECT COUNT(1) FROM mountain_file WHERE mountain_no=?";
		
		try{
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, mountainNo);
			ResultSet rs = pstmt.executeQuery();

			if(rs.next()){
				return rs.getInt(1)+1;
			}
			return 1; //첫 게시물인 경우
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}

	public int upload(String fileClientName, String fileServerName, int mountainNo) {
		String SQL = "INSERT INTO mountain_file VALUES(?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, mountainNo);
			pstmt.setInt(2, getNext(mountainNo));
			pstmt.setString(3, fileClientName);
			pstmt.setString(4, fileServerName);
			pstmt.setInt(5, 1);
			pstmt.setInt(6, 1);

			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	/*
	public int hit(String fileRealName) {
		String SQL = "UPDATE FILE SET downloadCount = downloadCount + 1 " + "WHERE fileRealName=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, fileRealName);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	*/

	public ArrayList<MountainFile> getList(int mountainNo) {
		String SQL = "SELECT * FROM mountain_file WHERE mountain_no=?";
		ArrayList<MountainFile> list = new ArrayList<MountainFile>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, mountainNo);
			ResultSet rs = pstmt.executeQuery();

			while(rs.next()){
				MountainFile file = new MountainFile(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getInt(5), rs.getInt(6));
				list.add(file);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
