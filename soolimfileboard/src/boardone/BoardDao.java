package boardone;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDao {
	private static DataSource ds = null;
	{
		try {
			Context init = new InitialContext();
			ds = (DataSource)init.lookup("java:comp/env/jdbc/myOracle");
			}catch(Exception e) {
				System.err.println("Connection 실패");
		}
	}
		public Connection getConnection() throws SQLException{
			return ds.getConnection();
		}
		
		private static BoardDao instance = null;
		public BoardDao() {	}
		
		public static BoardDao getInstance() {
			if(instance == null) {
				synchronized(BoardDao.class) {
					instance = new BoardDao();
				}
			}
			return instance;
		}

	public boolean insertArticle(BoardDto article) {
		boolean ret = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int num = article.getNum();
		int ref = article.getRef();
		int step = article.getStep();
		int depth = article.getDepth();
		int number = 0;
		String sql = "";

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement("select max(NUM) from BOARD");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				number = rs.getInt(1) + 1;
			} else {
				number = 1;
			}
			if (num != 0) { // 답 글일 경우
				sql = "update \"BOARD\" set STEP=STEP+1 where REF = ? and STEP > ?";
				pstmt.close();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, step);
				pstmt.executeQuery();
				step++;
				depth++;
			} else { // 새 글일 경우
				ref = number;		
				step = 0;
				depth = 0;
			}
			// 쿼리 작성
			sql = "insert into \"BOARD\" values (BOARD_SEQ.nextval,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt.close();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getEmail());
			pstmt.setString(3, article.getSubject());
			pstmt.setString(4, article.getPass());
			pstmt.setInt(5, article.getReadcount());
			pstmt.setInt(6, ref);
			pstmt.setInt(7, step);
			pstmt.setInt(8, depth);
			pstmt.setTimestamp(9, article.getRegdate());
			pstmt.setString(10, article.getContent());
			pstmt.setString(11, article.getFilename());
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
		return ret;
		
	}
	
	public int getArticleCount() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0;
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement("select count(*) from \"BOARD\"");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		} catch(Exception e) {
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
		return x;
	}
	
	public List<BoardDto> getArticles(){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BoardDto> articleList = null;
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement("select * from \"BOARD\" order by \"NUM\" desc");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				articleList = new ArrayList<BoardDto>();
				do {
					BoardDto article = new BoardDto();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPass(rs.getString("pass"));					
					article.setReadcount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setStep(rs.getInt("step"));
					article.setDepth(rs.getInt("depth"));
					article.setRegdate(rs.getTimestamp("regdate"));
					article.setContent(rs.getString("content"));
					article.setFilename(rs.getString("filename"));
					articleList.add(article);
				} while(rs.next());
			}
		} catch(Exception e) {
			e.printStackTrace();
		}finally {
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
		return articleList;
	}
	public BoardDto getArticle(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDto dto = new BoardDto();
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement("update \"BOARD\" set \"READCOUNT\"=\"READCOUNT\"+1 where \"NUM\"=?");
			pstmt.setInt(1, num);	
			pstmt.executeQuery();
			pstmt.close();
			
			pstmt = conn.prepareStatement("select * from \"BOARD\" where \"NUM\"=?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setEmail(rs.getString("email"));
				dto.setSubject(rs.getString("subject"));
				dto.setPass(rs.getString("pass"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setRef(rs.getInt("ref"));
				dto.setStep(rs.getInt("step"));
				dto.setDepth(rs.getInt("depth"));
				dto.setRegdate(rs.getTimestamp("regdate"));
				dto.setContent(rs.getString("content"));
				dto.setFilename(rs.getString("filename"));
			}
		} catch(Exception e) {
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
	public BoardDto updateGetArticle(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDto dto = new BoardDto();
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement("select * from \"BOARD\" where \"NUM\"=?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setEmail(rs.getString("email"));
				dto.setSubject(rs.getString("subject"));
				dto.setPass(rs.getString("pass"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setRef(rs.getInt("ref"));
				dto.setStep(rs.getInt("step"));
				dto.setDepth(rs.getInt("depth"));
				dto.setRegdate(rs.getTimestamp("regdate"));
				dto.setContent(rs.getString("content"));
				dto.setFilename(rs.getString("filename"));
			}
		} catch(Exception e) {
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
	public int updateArticle(BoardDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpassword = "";
		int result = -1; //결과값
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement("select \"PASS\" from \"BOARD\" where \"NUM\"=?");
			pstmt.setInt(1, dto.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbpassword = rs.getString("pass"); //비밀번호 비교
				if(dbpassword.equals(dto.getPass())) {
					String sql = "update \"BOARD\" set \"WRITER\"=?, \"EMAIL\"=?, \"SUBJECT\"=?, \"CONTENT\"=? where \"NUM\"=?";
					pstmt.close();
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, dto.getWriter());
					pstmt.setString(2, dto.getEmail());
					pstmt.setString(3, dto.getSubject());
					pstmt.setString(4, dto.getContent());	
					pstmt.setInt(5, dto.getNum());
					pstmt.executeQuery();
					result = 1; //수정 성공
				} else {
					result = 0; //수정 실패
				}
			}

		} catch(Exception e) {
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
		return result;
	}
	public int deleteArticle(int num, String pass) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpassword = "";
		int result = -1; //결과값
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement("select \"PASS\" from \"BOARD\" where \"NUM\"=?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbpassword = rs.getString("pass"); //비밀번호 비교
				if(dbpassword.equals(pass)) {
					pstmt.close();
					pstmt = conn.prepareStatement("delete from \"BOARD\" where \"NUM\"=?");
					pstmt.setInt(1, num);
					pstmt.executeQuery();
					result = 1; //수정 성공
				} else {
					result = 0; //수정 실패
				}
			}

		} catch(Exception e) {
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
		return result;
	}

}
