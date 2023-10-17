package com.yedam.exe;

import java.util.Scanner;

import com.yedam.member.MemberService;


public class Application {
	int selectNo = 0;
	Scanner sc = new Scanner(System.in);
	MemberService ms = new MemberService();

	public Application(){
		run();
	}

	private void run() {
		while(selectNo !=3 ) {
			if(MemberService.memberInfo == null) {
				System.out.println("-----------영 어 학 원-----------");
				System.out.println("=================================");
				System.out.println("1. 로그인 | 2. 회원가입 | 3. 종료");
				System.out.println("=================================");
				System.out.println("입력 > ");
				selectNo = Integer.parseInt(sc.nextLine());

				if(selectNo == 1) {
					ms.login();
				}else if(selectNo == 2) {
					ms.insertMember();
				}else if(selectNo == 3) {
					System.out.println("프로그램 종료");
				}else {
					System.out.println("잘못 입력하셨습니다.");
				}
			}
			if(MemberService.memberInfo != null) {
				//로그인한 정보 (학생 S)/ (관리자 M)
				if(MemberService.memberInfo.getMemberAuth().equals("S")) {
					new MemberApp();
				}else if(MemberService.memberInfo.getMemberAuth().equals("M")) {
					new ManagerApp();
				}
			}
		}
	}
}
