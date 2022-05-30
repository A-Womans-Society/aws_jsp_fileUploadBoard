package FileUpload;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class FileUploadDao {
	private static FileUploadDao instance = null;

	private FileUploadDao() {
	}

	public static FileUploadDao getInstance() {
		if (instance == null) {
			synchronized (FileUploadDao.class) {
				instance = new FileUploadDao();
			}
		}
		return instance;
	}

	public void insertFile(FileUploadDto insertFile) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "insert into MKFILEUPLOAD" + "(NUM, TITLE, WRITER, FILE_NAME, CONTENT, POSTDATE, PASS, READCOUNT)"
				+ "values(MKFILEUPLOAD_SEQ.nextval,?,?,?,?,?,?,?)";
		try {
			conn = ConnUtil.getConnection();
			//pstmt.close();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, insertFile.getTitle());
			pstmt.setString(2, insertFile.getWriter());
			pstmt.setString(3, insertFile.getFilename());
			pstmt.setString(4, insertFile.getContent());
			pstmt.setString(5, insertFile.getPostdate());
			pstmt.setString(6, insertFile.getPass());
			pstmt.setString(7, insertFile.getReadcount());
			pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {
				}
		}

	}
}