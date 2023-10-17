package com.yedam.member;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;

public class MemberService {
	public static Member memberInfo = null;
	Scanner sc = new Scanner(System.in);

	//로그인
	public void login() {
		while(true) {
			System.out.println("[ 로 그 인 ]");
			System.out.println("ID > ");
			String id = sc.nextLine();

			Member member = MemberDAO.getInstance().login(id);

			if(member == null) {
				System.out.println("아이디가 존재하지 않습니다. \n다시 입력하세요.");
			}else {
				System.out.println("PW > ");
				String pw = sc.nextLine();
				if(member.getMemberPw().equals(pw)) {
					System.out.println("로그인되었습니다.");
					memberInfo = member;
					break;
				}else {
					System.out.println("비밀번호가 틀렸습니다.");
				}
			}
		}
	}

	//회원가입 - 기본정보
	public void insertMember() {
		System.out.println("[ 회 원 가 입 ]");	
		String id = "";
		while(true) {
			System.out.println("ID>");
			id = sc.nextLine();
			Member member = MemberDAO.getInstance().login(id);
			if(member != null) {
				System.out.println("존재하는 ID 입니다.");
			}else if(member == null) {
				System.out.println("사용 가능한 ID 입니다.");
				break;
			}
		}
		System.out.println("PW > ");
		String pw = sc.nextLine();

		System.out.println("NAME > ");
		String name = sc.nextLine();

		Member member = new Member();
		member.setMemberId(id);
		member.setMemberPw(pw);
		member.setMemberName(name);

		int result = MemberDAO.getInstance().insertMember(member);

		if(result > 0) {
			System.out.println("회원 가입되었습니다.");
		}else {
			System.out.println("회원 가입 실패");
		}
	}

	//내 정보 조회 - 기본 정보
	public void getMemberInfo() {
		System.out.println("[ 기본 정보 조회 ]");
		Member member = MemberDAO.getInstance().login(memberInfo.getMemberId());
		System.out.println("ID : " + member.getMemberId());
		System.out.println("PW : " + member.getMemberPw());
		System.out.println("이름 : " + member.getMemberName());
	}

	//내 정보 조회 - 수강 정보 조회 
	public void getCourseInfo() {
		System.out.println("[ 수강 정보 조회 ]");

		Member member = MemberDAO.getInstance().getCourseInfo(memberInfo.getMemberId());
		if(member == null) {
			System.out.println("수강 정보가 없습니다. 수강 신청하세요.");
		}else {
			System.out.println("ID : " + member.getMemberId());
			System.out.println("수강 레벨 : " + member.getLevelName());
			System.out.println("등록일 : " + member.getStartDate());
			System.out.println("등록 기간 : " + member.getDuration() + "개월");
			System.out.println("종료일 : " + member.getEndDate());
			
			if(member.getTestApply() == null) {
				System.out.println("레벨 테스트 신청 : X");
			}else {
				System.out.println("레벨 테스트 신청 : " + member.getTestApply());
			}
			
			if(member.getTestApprove() == null) {
				System.out.println("레벨 테스트 승인 : X");
			}else {
				System.out.println("레벨 테스트 승인 : " + member.getTestApprove());
			}
			
			if(member.getTestResult() == null) {
				System.out.println("레벨 테스트 결과 : X");
			}else {
				System.out.println("레벨 테스트 결과 : " + member.getTestResult());
			}
			
		}
	}

	//비밀번호 수정
	public void updatePw() {
		System.out.println("[ 비밀번호 수정 ]");
		Member member = new Member();
		String memberPw = "";

		System.out.println("본인 확인을 위해 ID를 입력하세요. >");
		String id = sc.nextLine();

		if(id.equals(memberInfo.getMemberId())) {
			System.out.println("본인 확인 완료");
			System.out.println("새 비밀번호를 입력하세요. >");
			memberPw = sc.nextLine();

			member.setMemberId(id);
			member.setMemberPw(memberPw);

			int result = MemberDAO.getInstance().updatePw(member);
			if(result > 0) {
				System.out.println("비밀번호가 수정되었습니다.");
			}else {
				System.out.println("비밀번호 수정 실패");
			}
		}else {
			System.out.println("ID가 틀렸습니다.");
			System.out.println("비밀번호 수정 실패");
		}
	}

	//수강신청 전 수강 등록내역 유무 확인
	public void checkCourse() {
		Member member = MemberDAO.getInstance().getCourseInfo(memberInfo.getMemberId());
		//수강 내역 있음
		if(MemberDAO.getInstance().getCourseInfo(memberInfo.getMemberId()) != null ) {
			//현재날짜, 종료일 비교
			Date now = new Date();
			Date endCheck2 = new Date();
			String endCheck = member.getEndDate();
			SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
			fm.format(now);
			try {
				endCheck2 = fm.parse(endCheck);
			} catch (Exception e) {
				e.printStackTrace();
			}
			int compare = now.compareTo(endCheck2);
			if(compare > 0) {
				//수강 완료 - 종료일 지남 - 재 신청 가능 - 새 수강신청 메서드
				updateCourse();
			}else {
				//수강 진행 중 - 종료일 남았음
				System.out.println("현재 수강 중 입니다.");
				System.out.println(member.getLevelName() + " 레벨, " + member.getDuration() + "개월 과정");
			}
		}else {
			//수강 내역 없음 - 신청 가능 - 수강신청 메서드
			insertCourse();
		}
	}

	//수강신청 - insert
	public void insertCourse(){
		System.out.println("[ 수 강 신 청 ]");
		System.out.println("▽ 수강 레벨을 선택하세요.");
		System.out.println("1. Beginner | 2. Basic | 3. Intermediate | 4. Advanced");
		int selectLevel = Integer.parseInt(sc.nextLine());
		if (selectLevel < 1 || selectLevel > 4) {
			System.out.println("잘못 입력하셨습니다. 다시 입력해주세요.");
			selectLevel = Integer.parseInt(sc.nextLine());
		}

		System.out.println("▽ 수강 기간을 선택하세요.");
		System.out.println("1. 1개월 | 2. 2개월");
		int selectDuration = Integer.parseInt(sc.nextLine());
		if (selectDuration < 1 || selectDuration > 2) {
			System.out.println("잘못 입력하셨습니다. 다시 입력해주세요.");
			selectDuration = Integer.parseInt(sc.nextLine());
		}

		int result = MemberDAO.getInstance().insertCourse(selectLevel, selectDuration);

		if (result > 0) {
			Member member = MemberDAO.getInstance().getCourseInfo(memberInfo.getMemberId());
			System.out.println( member.getLevelName() + " 레벨, " + selectDuration + "개월 과정이 신청되었습니다.");
			System.out.println("수강 종료일은 " + member.getEndDate() + "일 입니다.");
		} else {
			System.out.println("수강 신청 실패");
		}
	}

	//새 수강 신청 - update
	public void updateCourse() {
		System.out.println("[ 수 강 신 청 ]");
		System.out.println("▽ 수강 레벨을 선택하세요.");
		System.out.println("1. Beginner | 2. Basic | 3. Intermediate | 4. Advanced");
		int selectLevel = Integer.parseInt(sc.nextLine());
		if (selectLevel < 1 || selectLevel > 4) {
			System.out.println("잘못 입력하셨습니다. 다시 입력해주세요.");
			selectLevel = Integer.parseInt(sc.nextLine());
		}

		System.out.println("▽ 수강 기간을 선택하세요.");
		System.out.println("1. 1개월 | 2. 2개월");
		int selectDuration = Integer.parseInt(sc.nextLine());
		if (selectDuration < 1 || selectDuration > 2) {
			System.out.println("잘못 입력하셨습니다. 다시 입력해주세요.");
			selectDuration = Integer.parseInt(sc.nextLine());
		}

		int result = MemberDAO.getInstance().updateCourse(selectLevel, selectDuration);

		if (result > 0) {
			Member member = MemberDAO.getInstance().getCourseInfo(memberInfo.getMemberId());
			System.out.println( member.getLevelName() + " 레벨, " + selectDuration + "개월 과정이 신청되었습니다.");
			System.out.println("수강 종료일은 " + member.getEndDate() + "일 입니다.");
		} else {
			System.out.println("수강 신청 실패");
		}
	}
	//레벨 테스트 신청 -> 관리자 승인 -> 테스트 진행
	//수강 2개월 이상 and 종료일 이후 - 신청 가능
	public void testApply() {
		Member member = MemberDAO.getInstance().getCourseInfo(memberInfo.getMemberId());
		if (member == null) {
			System.out.println("수강 정보가 없습니다. 수강 신청하세요.");
			return;
		}
		if (member.getTestApply() != null) {
			if (member.getTestApprove() != null && member.getTestApprove().equals("승인 완료")) {
				System.out.println("관리자 승인이 완료되었습니다.");
				System.out.println(member.getLevelName() +" 레벨 테스트 진행 가능합니다.");
				System.out.println();
				//레벨 테스트 메서드 실행
				takeTest(member.getLevelId());
			} else {
				System.out.println("이미 신청되었습니다. 관리자 승인을 기다려주세요.");
			}
		}else {
			Date now = new Date();
			Date endCheck2 = new Date();
			String endCheck = member.getEndDate();
			SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
			fm.format(now);
			try {
				endCheck2 = fm.parse(endCheck);
			} catch (Exception e) {
				e.printStackTrace();
			}
			int compare = now.compareTo(endCheck2);
			
			//수강 2개월 이상 and 종료일 이후
			if((compare > 0) && (member.getDuration() ==2)) {
				//종료일 지남 - 테스트 신청 가능
				System.out.println("레벨 테스트 신청 가능합니다.");
				System.out.println("신청하시겠습니까?");
				System.out.println("1. 신청 | 2. 취소");
				int selectNo = Integer.parseInt(sc.nextLine());
				if(selectNo == 1) {
					int result = MemberDAO.getInstance().testApply(memberInfo.getMemberId());
					if(result > 0 ) {
						System.out.println("레벨 테스트 신청 되었습니다. 관리자 승인을 기다려주세요.");
					}else {
						System.out.println("레벨 테스트 신청 신청 실패");
					}
				}else if(selectNo == 2) {
				}
			}else if((compare < 0) && (member.getDuration() ==2)){
				//종료 전 - 신청 불가
				System.out.println("수강 코스 2개월 수강 후 신청 가능합니다. 종료일을 확인하세요.");
				System.out.println("현재 " + member.getDuration() + "개월 과정 수강 중, 종료일 : " + member.getEndDate());
			}else if(member.getDuration() ==1) {
				//수강 기간 부족 - 신청 불가
				System.out.println("수강 코스 2개월 수강 후 신청 가능합니다. \n(추가 등록 필요)");
				System.out.println(member.getDuration() + "개월 과정 수강, 종료일 : " + member.getEndDate());
			}
		}
	}

	//레벨 테스트 진행
	public void takeTest(int level) {
		System.out.println("[ 레벨 테스트 ]");
		System.out.println("각 문항에 대한 정답을 입력하세요.");
		System.out.println();
		
		String question1 = "";
	    int answer1 = 0;

	    String question2 = "";
	    int answer2 = 0;

	    String question3 = "";
	    int answer3 = 0;
	    
	    int incorrectCount = 0;
	    
	    //수강 레벨에 따라 문제, 정답 설정
	    if (level == 1) {
	        question1 = "문제 1: How are you doing today?\r\n" + 
	        		"1. I'm fine, thank you.\r\n" + 
	        		"2. It's sunny outside.\r\n" + 
	        		"3. I like pizza.";
	        answer1 = 1;

	        question2 = "문제 2: What time is it?\r\n" + 
	        		"1. It's 9 o'clock.\r\n" + 
	        		"2. I'm sorry.\r\n" + 
	        		"3. It's a beautiful day.";
	        answer2 = 1;

	        question3 = "문제 3: What is your favorite hobby?\r\n" + 
	        		"1. I'm tired.\r\n" + 
	        		"2. Watching movies.\r\n" + 
	        		"3. This is a book.";
	        answer3 = 2;
	    } else if (level == 2) {
	        question1 = "문제 1: What time do you usually go to bed?\r\n" + 
	        		"1. I love soccer.\r\n" + 
	        		"2. My favorite color is blue.\r\n" + 
	        		"3. Around 10 PM.";
	        answer1 = 3;

	        question2 = "문제 2: Where is the nearest supermarket?\r\n" + 
	        		"1. It's on Main Street.\r\n" + 
	        		"2. I'm not sure, sorry.\r\n" + 
	        		"3. I like to watch movies.";
	        answer2 = 1;

	        question3 = "문제 3: What do you usually have for breakfast?\r\n" + 
	        		"1. I have two dogs.\r\n" + 
	        		"2. I usually have cereal and milk.\r\n" + 
	        		"3.I enjoy reading books.";
	        answer3 = 2;
	    } else if (level == 3) {
	        question1 = "문제 1: Can you recommend a good restaurant?\r\n" + 
	        		"1. I don't like trying new foods.\r\n" + 
	        		"2. Yes, there's a great Italian restaurant downtown.\r\n" + 
	        		"3. I like to watch movies.";
	        answer1 = 2;

	        question2 = "문제 2: What's your favorite movie genre?\r\n" + 
	        		"1. I'm a big fan of classical music.\r\n" + 
	        		"2. I enjoy gardening in my free time.\r\n" + 
	        		"3. I'm more into action movies.";
	        answer2 = 3;

	        question3 = "문제 3: How do you usually commute to work or school?\r\n" + 
	        		"1. I like hiking in the mountains.\r\n" + 
	        		"2. I take the bus.\r\n" + 
	        		"3. I have a pet dog.";
	        answer3 = 2;
	    } else if (level == 4) {
	        question1 = "문제 1: How do you handle stress?\r\n" + 
	        		"1. I practice meditation and deep breathing exercises.\r\n" + 
	        		"2. I don't really get stressed.\r\n" + 
	        		"3. I collect stamps as a hobby.";
	        answer1 = 1;

	        question2 = "문제 2: How do you handle difficult situations at work?\r\n" + 
	        		"1. I don't really have a specific way to relax.\r\n" + 
	        		"2. I seek guidance from my colleagues and superiors.\r\n" + 
	        		"3. I'm not really interested in my work.";
	        answer2 = 2;

	        question3 = "문제 3: How do you stay motivated to achieve your goals?\r\n" + 
	        		"1. I don't really set specific goals for myself.\r\n" + 
	        		"2. I break my goals into smaller tasks and reward myself upon completion.\r\n" + 
	        		"3. I often find it difficult to stay motivated and lose interest quickly.";
	        answer3 = 2;
	    }

	    //답안 입력
	    System.out.println(question1 + "\n알맞은 대답을 고르세요 >");
	    int memAnswer1 = Integer.parseInt(sc.nextLine());
	    System.out.println();

	    System.out.println(question2 + "\n알맞은 대답을 고르세요 >");
	    int memAnswer2 = Integer.parseInt(sc.nextLine());
	    System.out.println();

	    System.out.println(question3 + "\n알맞은 대답을 고르세요 >");
	    int memAnswer3 = Integer.parseInt(sc.nextLine());
	    System.out.println();

	    // 테스트 확인
	    if (memAnswer1 == answer1 && memAnswer2 == answer2 && memAnswer3 == answer3) {
	        System.out.println("축하합니다! 레벨 테스트를 통과하셨습니다.");
	        // 테스트 결과 업데이트
	        int result = MemberDAO.getInstance().testResult(memberInfo.getMemberId());
	        if (result > 0) {
	            System.out.println("레벨 테스트 합격 처리되었습니다.");
	        } else {
	            System.out.println("레벨 테스트 처리 실패");
	        }
	    } else {
	        incorrectCount += (memAnswer1 != answer1) ? 1 : 0;
	        incorrectCount += (memAnswer2 != answer2) ? 1 : 0;
	        incorrectCount += (memAnswer3 != answer3) ? 1 : 0;
	        System.out.println(incorrectCount + "개 틀렸습니다.");
	        System.out.println("레벨 테스트를 통과하지 못하셨습니다. 다시 시도해주세요.");
	    }
	}

}

