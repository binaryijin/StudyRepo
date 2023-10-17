package com.yedam.oop;

public class Student {
	//학생의 정보를 관리하는 객체
	//필드 - 정보
	//이름, 학년, 국어, 영어, 수학
	
	//기본 생성자
			
	//메소드
	//모든 정보를 출력 getInfo()
	String name;
	int year;
	int kor;
	int eng;
	int math;
	
	Student(){
		
	}
	Student(String name, int year, int kor, int eng, int math){
		this.name = name;
		this.year = year;
		this.kor = kor;
		this.eng = eng;
		this.math = math;
	}
	
	void getInfo() {
		System.out.println("이름 : "+ name);
		System.out.println("학년 : "+ year);
		System.out.println("국어 : "+ kor);
		System.out.println("영어 : "+ eng);
		System.out.println("수학 : "+ math);
		System.out.println();
	}
	
}
