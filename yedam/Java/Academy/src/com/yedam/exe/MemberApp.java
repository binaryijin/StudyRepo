package com.yedam.exe;

import java.util.Scanner;

import com.yedam.member.MemberService;

public class MemberApp {
	Scanner sc = new Scanner(System.in);
	MemberService ms = new MemberService();

	public MemberApp() {
		MemberRun();
	}

	private void MemberRun() {
		boolean run = true;

		while(run) {
			Membermenu();
			int selectNo = Integer.parseInt(sc.nextLine());

			switch (selectNo) {
			case 1:
				System.out.println("==========================================");
				System.out.println("1. 기본 정보 | 2. 수강 정보 | 3. 뒤로 가기");
				System.out.println("==========================================");
				System.out.println("입력 >");
				String menu = sc.nextLine();
				if(menu.equals("1")) {
					ms.getMemberInfo();
				}else if(menu.equals("2")) {
					ms.getCourseInfo();
				}else if(menu.equals("3")) {
					break;
				}
				break;
			case 2:
				System.out.println("=================================================");
				System.out.println("1. 수강 신청 | 2. 레벨 테스트 신청 | 3. 뒤로 가기");
				System.out.println("=================================================");
				System.out.println("입력 >");
				menu = sc.nextLine();
				if(menu.equals("1")) {
					ms.checkCourse();
				}else if(menu.equals("2")) {
					ms.testApply();
				}else if(menu.equals("3")) {
					break;
				}
				break;
			case 3:
				ms.updatePw();
				break;
			case 4:
				run = false;
				MemberService.memberInfo = null;
				System.out.println("로그아웃 되었습니다.");
				break;
			default:
				System.out.println("잘못 입력하셨습니다.");
				break;
			}
		}
	}

	private void Membermenu() {
		System.out.println("=========================================================================");
		System.out.println("1. 내 정보 조회 | 2. 수강 및 테스트 신청 | 3. 비밀번호 수정 | 4. 로그아웃");
		System.out.println("=========================================================================");
		System.out.println("입력 > ");
	}
}
