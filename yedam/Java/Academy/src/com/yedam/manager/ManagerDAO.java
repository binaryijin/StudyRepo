package com.yedam.manager;

import java.util.ArrayList;
import java.util.List;

import com.yedam.common.DAO;
import com.yedam.member.Member;

public class ManagerDAO extends DAO{
	private static ManagerDAO mngDao = null;

	private ManagerDAO(){

	}
	public static ManagerDAO getInstance() {
		if(mngDao == null) {
			mngDao = new ManagerDAO();
		}
		return mngDao;
	}
	
	//전체 수강생 조회
	public List<Member> getMemberList(){
		List<Member> list = new ArrayList<>();
		Member member = null;
		try {
			conn();
			String sql = "SELECT m.member_id, m.member_name, c.level_id, c.level_name, c.start_date, c.duration, c.end_date, c.test_apply, c.test_approve, c.test_result\r\n"
					+ "FROM member m join courseinfo c\r\n"
					+ "ON m.member_id = c.member_id ORDER BY m.member_id";

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				member = new Member();
				member.setMemberId(rs.getString("member_id"));
				member.setMemberName(rs.getString("member_name"));
				member.setLevelId(rs.getInt("level_id"));
				member.setLevelName(rs.getString("level_name"));
				member.setStartDate(rs.getDate("start_date"));
				member.setDuration(rs.getInt("duration"));
				member.setEndDate(rs.getString("end_date"));
				member.setTestApply(rs.getString("test_apply"));
				member.setTestApprove(rs.getString("test_approve"));
				member.setTestResult(rs.getString("test_result"));

				list.add(member);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconn();
		}
		return list;
	}

	//강의별 수강생 조회
	public List<Member> getcourseList(int courseMenu){
		List<Member> list = new ArrayList<>();
		Member member = null;
		try {
			conn();
			String sql = "SELECT c.level_id, c.level_name, m.member_id, m.member_name, c.start_date, c.duration, c.end_date, c.test_apply, c.test_approve, c.test_result\r\n"
					+ "FROM member m join courseinfo c\r\n"
					+ "ON m.member_id = c.member_id\r\n"
					+ "WHERE c.level_id = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, courseMenu);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				member = new Member();
				member.setLevelId(rs.getInt("level_id"));
				member.setLevelName(rs.getString("level_name"));
				member.setMemberId(rs.getString("member_id"));
				member.setMemberName(rs.getString("member_name"));
				member.setStartDate(rs.getDate("start_date"));
				member.setDuration(rs.getInt("duration"));
				member.setEndDate(rs.getString("end_date"));
				member.setTestApply(rs.getString("test_apply"));
				member.setTestApprove(rs.getString("test_approve"));
				member.setTestResult(rs.getString("test_result"));

				list.add(member);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconn();
		}
		return list;
	}

	//테스트 신청 확인
	public List<Member> checkApplyList(){
		List<Member> list = new ArrayList<>();
		Member member = null;
		try {
			conn();
			String sql = "SELECT * FROM courseinfo WHERE test_apply = '신청 대기' ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				member = new Member();
				member.setMemberId(rs.getString("member_id"));
				member.setLevelId(rs.getInt("level_id"));
				member.setLevelName(rs.getString("level_name"));
				member.setDuration(rs.getInt("duration"));
				member.setEndDate(rs.getString("end_date"));
				member.setTestApply(rs.getString("test_apply"));
				member.setTestApprove(rs.getString("test_approve"));
				member.setTestResult(rs.getString("test_result"));

				list.add(member);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconn();
		}
		return list;
	}

	//레벨 테스트 신청 승인
	public int testApprove(Member member) {
		int result = 0;
		try {
			conn();
			String sql = "UPDATE courseinfo SET test_approve = ? WHERE member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "승인 완료");
			pstmt.setString(2, member.getMemberId());
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconn();
		}
		return result;
	}

	//회원 삭제
	public int deleteMember(String id) {
		int result = 0;
		try {
			//부모 테이블(member) 삭제 시, 자식 테이블도 같이 삭제됨(해당 컬럼 -> ON DELETE CASCADE)
			conn();
			String sql = "DELETE FROM member WHERE member_id = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconn();
		}
		return result;
	}
	
}
