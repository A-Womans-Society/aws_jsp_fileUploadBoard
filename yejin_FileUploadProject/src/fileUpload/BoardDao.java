package fileUpload;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BoardDao {
	private static BoardDao instance = null;

	private BoardDao() {
	}

	public static BoardDao getInstance() {
		if (instance == null) {
			synchronized (BoardDao.class) {
				instance = new BoardDao();
			}
		}
		return instance;
	}

	public static boolean upload(BoardDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean result = false;
		String sql = "insert into \"BOARD\" values (\"SEQ_BOARD\".nextval, ?, ?, ?, ?)";
		try {
			conn = ConnUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getPwd());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getFile());
			int tmp = pstmt.executeUpdate();
			result = (tmp > 0) ? true : false;
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
		return result;
	}

	public static ArrayList<BoardDto> list() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from \"BOARD\" order by \"POST_NUMBER\" asc";
		ArrayList<BoardDto> result = new ArrayList<>();
		try {
			conn = ConnUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BoardDto tmp = new BoardDto(rs.getString("AUTHOR"), rs.getString("PWD"), rs.getString("CONTENT"),
						rs.getString("FILE"));
				result.add(tmp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
		return result;
	}
}
