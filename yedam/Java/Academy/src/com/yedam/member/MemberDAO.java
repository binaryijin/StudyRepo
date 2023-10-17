package com.yedam.member;

import com.yedam.common.DAO;

public class MemberDAO extends DAO {
	private static MemberDAO memDao = null;

	private MemberDAO(){

	}
	public static MemberDAO getInstance() {
		if(memDao == null) {
			memDao = new MemberDAO();
		}
		return memDao;
	}

	//로그인
	public Member login (String id) {
		Member member = null;
		try {
			conn();
			String sql = "SELECT * FROM member WHERE member_id =? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member = new Member();
				member.setMemberId(id);
				member.setMemberPw(rs.getString("member_pw"));
				member.setMemberName(rs.getString("member_name"));
				member.setMemberAuth(rs.getString("member_auth"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconn();
		}
		return member;
	}

	//회원 가입 - 기본 정보
	public int insertMember(Member member) {
		int result = 0;
		try {
			conn();
			String sql = "INSERT INTO member VALUES(?, ?, ?, 'S')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getMemberId());
			pstmt.setString(2, member.getMemberPw());
			pstmt.setString(3, member.getMemberName());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconn();
		}
		return result;
	}

	//내 정보 조회 - 수강 정보 조회
	public Member getCourseInfo (String id) {
		Member member = null;
		try {
			conn();
			String sql = "SELECT * FROM courseinfo WHERE member_id =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member = new Member();
				member.setMemberId(id);
				member.setLevelId(rs.getInt("level_id"));
				member.setLevelName(rs.getString("level_name"));
				member.setStartDate(rs.getDate("start_date"));
				member.setDuration(rs.getInt("duration"));
				member.setEndDate(rs.getString("end_date"));
				member.setTestApply(rs.getString("test_apply"));
				member.setTestApprove(rs.getString("test_approve"));
				member.setTestResult(rs.getString("test_result"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconn();
		}
		return member;
	}
	
	//비밀번호 수정
	public int updatePw(Member member) {
		int result = 0;
		try {
			conn();
			String sql = "UPDATE member SET member_pw = ? WHERE member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getMemberPw());
			pstmt.setString(2, member.getMemberId());

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconn();
		}
		return result;
	}

	//수강 신청
	public int insertCourse( int selectLevel, int selectDuration) {
		int result = 0;
		try {
			conn();
			String levelName = getLevelName(selectLevel);

			String sql = "INSERT INTO courseinfo VALUES(?, ?, ?, sysdate, ?, to_char(add_months(sysdate, ?),'YYYY-MM-DD'),null, null, null)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, MemberService.memberInfo.getMemberId());
			pstmt.setInt(2, selectLevel);
			pstmt.setString(3, levelName);
			pstmt.setInt(4, selectDuration);
			pstmt.setInt(5, selectDuration);

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconn();
		}
		return result;
	}
	private String getLevelName(int selectLevel) {
		String levelName = "";
		switch (selectLevel) {
		case 1:
			levelName = "Beginner";
			break;
		case 2:
			levelName = "Basic";
			break;
		case 3:
			levelName = "Intermediate";
			break;
		case 4:
			levelName = "Advanced";
			break;
		default:
			break;
		}
		return levelName;
	}

	//재 수강 신청
	public int updateCourse( int selectLevel, int selectDuration) {
		int result = 0;
		try {
			conn();

			String levelName = getLevelName(selectLevel);

			String sql = "UPDATE courseinfo "
					+ "SET level_id = ?, level_name = ?, start_date = sysdate, duration = ?, end_date = to_char(add_months(sysdate, ?),'YYYY-MM-DD'),"
					+ "test_apply = null, test_approve = null, test_result = null\r\n"
					+ "WHERE member_id = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, selectLevel);
			pstmt.setString(2, levelName);
			pstmt.setInt(3, selectDuration);
			pstmt.setInt(4, selectDuration);
			pstmt.setString(5, MemberService.memberInfo.getMemberId());

			result = pstmt.executeUpdate();
			
			//재 수강 신청시 테스트 결과 - null로 변경
			if (result > 0) {
				sql = "UPDATE courseinfo SET test_result = null WHERE member_id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, MemberService.memberInfo.getMemberId());
				pstmt.executeUpdate();
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconn();
		}
		return result;
	}

	//레벨 테스트 신청
	public int testApply (String id) {
		int result = 0;
		try {
			conn();
			String sql = "UPDATE courseinfo SET test_apply = ? WHERE member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "신청 대기");
			pstmt.setString(2, id);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconn();
		}
		return result;
	}
	
	//레벨 테스트 결과
	public int testResult(String id) {
		int result = 0;
		try {
			conn();
			String sql = "UPDATE courseinfo SET test_result = ? WHERE member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "합격");
			pstmt.setString(2, id);
			result = pstmt.executeUpdate();
			
			//합격시 신청,승인 null로 변경
			if (result > 0) {
				sql = "UPDATE courseinfo SET test_apply = null, test_approve = null WHERE member_id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconn();
		}
		return result;
	}

}