package com.yedam.manager;


import java.util.List;
import java.util.Scanner;

import com.yedam.member.Member;
import com.yedam.member.MemberDAO;

public class ManagerService {
	Scanner sc = new Scanner(System.in);

	//전체 수강생 정보 조회
	public void getMemberList() {
		List<Member> list = ManagerDAO.getInstance().getMemberList();
		System.out.println("[ 전체 수강생 조회 ]");
		for(int i=0; i<list.size(); i++) {
			System.out.println("=========================");
			System.out.println("ID : " + list.get(i).getMemberId());
			System.out.println("이름 : " + list.get(i).getMemberName());
			System.out.println("수강 레벨 : " + list.get(i).getLevelName());
			System.out.println("등록일 : " + list.get(i).getStartDate());
			System.out.println("등록 기간 : " + list.get(i).getDuration() + "개월");
			System.out.println("종료일 : " + list.get(i).getEndDate());
			
			if(list.get(i).getTestApply() == null) {
				System.out.println("레벨 테스트 신청 : X");
			}else {
				System.out.println("레벨 테스트 신청 : " + list.get(i).getTestApply());
			}
			
			if(list.get(i).getTestApprove() == null) {
				System.out.println("레벨 테스트 승인 : X");
			}else {
				System.out.println("레벨 테스트 승인 : " + list.get(i).getTestApprove());
			}
			
			if(list.get(i).getTestResult() == null) {
				System.out.println("레벨 테스트 결과 : X");
			}else {
				System.out.println("레벨 테스트 결과 : " + list.get(i).getTestResult());
			}
			
		}
	}

	//강의별 수강생 조회
	public void getcourseList() {
		System.out.println("[ 강의별 수강생 조회 ]");
		System.out.println("▽수강 레벨을 선택하세요.");
		System.out.println("1. Beginner | 2. Basic | 3. Intermediate | 4. Advanced");

		int courseMenu = Integer.parseInt(sc.nextLine());
		List<Member> list = ManagerDAO.getInstance().getcourseList(courseMenu);

		switch (courseMenu) {
		case 1:
			System.out.println("[ Beginner 레벨 ]");
			break;
		case 2:
			System.out.println("[ Basic 레벨 ]");
			break;
		case 3:
			System.out.println("[ Intermediate 레벨 ]");
			break;
		case 4:
			System.out.println("[ Advanced 레벨 ]");
			break;
		default:
			System.out.println("잘못 입력하셨습니다.");
			break;
		}

		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				System.out.println("=========================");
				System.out.println("수강 레벨 : " + list.get(i).getLevelName());
				System.out.println("ID : " + list.get(i).getMemberId());
				System.out.println("이름 : " + list.get(i).getMemberName());
				System.out.println("등록일 : " + list.get(i).getStartDate());
				System.out.println("등록 기간 : " + list.get(i).getDuration() + "개월");
				System.out.println("종료일 : " + list.get(i).getEndDate());
				
				if(list.get(i).getTestApply() == null) {
					System.out.println("레벨 테스트 신청 : X");
				}else {
					System.out.println("레벨 테스트 신청 : " + list.get(i).getTestApply());
				}
				
				if(list.get(i).getTestApprove() == null) {
					System.out.println("레벨 테스트 승인 : X");
				}else {
					System.out.println("레벨 테스트 승인 : " + list.get(i).getTestApprove());
				}
				
				if(list.get(i).getTestResult() == null) {
					System.out.println("레벨 테스트 결과 : X");
				}else {
					System.out.println("레벨 테스트 결과 : " + list.get(i).getTestResult());
				}
			}
		}else {
			System.out.println("해당 레벨의 수강생이 없습니다.");
		}
	}

	//테스트 신청자 조회 후 승인
	public void getTestApply() {
		List<Member> list = ManagerDAO.getInstance().checkApplyList();
		boolean applicant = false;

		if(list.size() > 0) {
			System.out.println("[ 테스트 신청자 조회 ]");
			for(int i=0; i<list.size(); i++) {
				if ("승인 완료".equals(list.get(i).getTestApprove())) {
					continue;
				}
				//신청자 한명 씩 확인하고 승인하기
				applicant = true;

				System.out.println("==============================================================");
				System.out.println("ID : " + list.get(i).getMemberId() + ", 수강 레벨 : " + list.get(i).getLevelName() + 
						", 등록 기간 : " + list.get(i).getDuration() + "개월, 종료일 : " + list.get(i).getEndDate());
				System.out.println("--------------------------------------------------------------");
				// 승인 하기
				System.out.println("테스트 신청을 승인하시겠습니까?");
				System.out.println("1. 승인 | 2. 취소");
				int selectNo = Integer.parseInt(sc.nextLine());
				switch (selectNo) {
				case 1:
					int result = ManagerDAO.getInstance().testApprove(list.get(i));
					if (result > 0) {
						System.out.println(list.get(i).getMemberId() + "님의 레벨 테스트 신청이 승인되었습니다.");
					} else {
						System.out.println(list.get(i).getMemberId() + "님의 레벨 테스트 신청이 승인 실패했습니다.");
					}
					break;
				case 2:
					return;
				default:
					System.out.println("잘못된 선택입니다. 다시 입력해주세요.");
					break;
				}
			}
			if (applicant) {
				System.out.println("[ 모든 신청자 조회 완료 ]");
			} else {
				System.out.println("레벨 테스트 신청자가 없습니다.");
			}
		} else {
			System.out.println("레벨 테스트 신청자가 없습니다.");
		}
	}

	//회원 삭제
	//부모 테이블(member) 삭제 시, 자식 테이블도 같이 삭제됨(해당 컬럼 -> ON DELETE CASCADE)
	public void deleteMember() {
		System.out.println("[ 수강생 삭제 ]");
		System.out.println("ID를 입력하세요. >");
		String id = sc.nextLine();

		int result = 0;
		if(id.equals("manager")) {
			System.out.println("관리자 계정은 삭제할 수 없습니다.");
		}else {
			Member member = MemberDAO.getInstance().login(id);
			if(member == null) {
				System.out.println("존재하지 않는 ID 입니다.");
			}else {
				System.out.println("ID " + id + " 를 삭제하시겠습니까?");
				System.out.println("1. 삭제 | 2. 취소");
				int selectNo = Integer.parseInt(sc.nextLine());
				if(selectNo == 1) {
					result = ManagerDAO.getInstance().deleteMember(id);
				}else if(selectNo == 2) {
				}
			}
		}
		if(result > 0) {
			System.out.println("수강생 ID " + id + " 가 삭제되었습니다.");
		}else {
			System.out.println("(수강생 삭제 실패)");
		}
	}

}