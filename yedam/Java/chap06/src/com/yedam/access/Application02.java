package com.yedam.access;

public class Application02 {

	public static void main(String[] args) {
		//인스턴스(객체) 생성
		Student std = new Student();
		//인스턴스 필드 -> 데이터 입력 및 저장
		std.setStdName("김또치");
		std.setMajor("컴퓨터공학과");
		std.setStdGrade("2학년");
		std.setPrograming(-5);
		std.setDatabase(50);
		std.setOs(-50);
		//인스턴스 필드 -> 데이터 얻기 및 읽기
		System.out.println("이름 : " + std.getStdName());
		System.out.println("전공 : " + std.getMajor());
		System.out.println("학년 : " + std.getStdGrade());
		System.out.println("프로그래밍 : " + std.getPrograming());
		System.out.println("데이터베이스 : " + std.getDatabase());
		System.out.println("운영체제 : " +std.getOs());
		
		System.out.println();
		
		Member mem = new Member();
		//인스턴스 필드 -> 데이터 입력
		mem.setId("jin");
		mem.setPw("1234");
		mem.setName("이진");
		mem.setAge(-10);
		//데이터 얻기 & 읽기
		System.out.println("아이디 : " + mem.getId());
		System.out.println("비밀번호 : " + mem.getPw());
		System.out.println("이름 : " + mem.getName());
		System.out.println("나이 : " + mem.getAge());
	}

}
