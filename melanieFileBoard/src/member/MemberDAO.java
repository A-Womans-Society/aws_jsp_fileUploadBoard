package member;

import common.DBConnPool;

public class MemberDAO extends DBConnPool {
	
	public MemberDAO() {
		super();
	}
	
	// 명시한 아이디와 일치하는 회원정보를 반환
	public MemberDTO getMemberDTO(String memId) {
		MemberDTO dto = new MemberDTO(); 
		String query = "SELECT * FROM member WHERE memId=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, memId);
			rs = psmt.executeQuery();
		
			if (rs.next()) { 
				dto.setMemNum(rs.getString("memNum"));
				dto.setMemId(rs.getString("memId"));
				dto.setMemPwd(rs.getString("memPwd"));
				dto.setMemRegidate(rs.getDate("memRegidate"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	
	// 명시한 아이디/패스워드와 일치하는 회원정보를 반환
	public MemberDTO getMemberDTO(String userId, String userPwd) {
		MemberDTO dto = new MemberDTO(); 
		String query = "SELECT * FROM member WHERE memId=? AND memPwd=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, userId);
			psmt.setString(2, userPwd);
			rs = psmt.executeQuery();
		
			if (rs.next()) { 
				dto.setMemNum(rs.getString("memNum"));
				dto.setMemId(rs.getString("memId"));
				dto.setMemPwd(rs.getString("memPwd"));
				dto.setMemRegidate(rs.getDate("memRegidate"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	// 새로운 회원 등록
	public int insertMember(MemberDTO dto) {
		int applyResult = 0;
		
		try {
			String query = "INSERT INTO member (memNum, memId, memPwd, memRegidate) "
					+ " VALUES (seq_member_num.NEXTVAL, ?, ?, sysdate)";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getMemId());
			psmt.setString(2, dto.getMemPwd());

			applyResult = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("새로운 회원 등록 중 예외 발생");
			e.printStackTrace();
		}
		return applyResult;
	}
}
