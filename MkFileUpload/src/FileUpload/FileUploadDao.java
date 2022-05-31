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
		String sql = "insert into MKFILEUPLOAD (NUM, TITLE, WRITER, FILE_NAME, CONTENT, PASS, READCOUNT) values(MKFILEUPLOAD_SEQ.nextval,?,?,?,?,?,?)";
		try {
			conn = ConnUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			System.out.println(insertFile);
			pstmt.setString(1, insertFile.getTitle());
			pstmt.setString(2, insertFile.getWriter());
			pstmt.setString(3, insertFile.getFilename());
			pstmt.setString(4, insertFile.getContent());
			pstmt.setString(5, insertFile.getPass());
			pstmt.setString(6, insertFile.getReadcount());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
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

	public List<FileUploadDto> selectAll() {
		List<FileUploadDto> fileList = new ArrayList<FileUploadDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM MKFILEUPLOAD ORDER BY NUM DESC";
		try {
			conn = ConnUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				FileUploadDto dto = new FileUploadDto();
				dto.setNum(rs.getString("NUM"));
				dto.setTitle(rs.getString("TITLE"));
				dto.setWriter(rs.getString("WRITER"));
				dto.setFilename(rs.getString("FILE_NAME"));
				dto.setContent(rs.getString("CONTENT" ));
				dto.setPostdate(rs.getString("POSTDATE"));
				dto.setPass(rs.getString("PASS"));
				dto.setReadcount(rs.getString("READCOUNT"));
				fileList.add(dto); // 목록에 추가
			}
		} catch (SQLException e) {
			System.out.println("SELECT시 예외 발생");
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return (fileList.size() == 0) ? null : fileList;
	}

	// 글 내용을 확인할 수 있는 페이지 -num을 매개변수로 db에서 세부정보 가져오기
	public FileUploadDto getArticle(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		FileUploadDto dto = null;
		try {
			conn = ConnUtil.getConnection();
			pstmt = conn.prepareStatement("update MKFILEUPLOAD set READCOUNT=READCOUNT+1 where NUM = ?");
			pstmt.setInt(1, num);
			pstmt.executeQuery();
			pstmt.close();
			pstmt = conn.prepareStatement("select * from MKFILEUPLOAD where NUM = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			//컬럼명과 동일하게
			if (rs.next()) { // 순회하는 내용이 내가 보여주고자하는 항목만
				dto = new FileUploadDto();
				dto.setNum(rs.getString("NUM"));
				dto.setTitle(rs.getString("TITLE"));
				dto.setWriter(rs.getString("WRITER"));
				dto.setFilename(rs.getString("FILE_NAME"));
				dto.setContent(rs.getString("CONTENT"));
				dto.setReadcount(rs.getString("READCOUNT"));
			}
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
		return dto;
	}
}