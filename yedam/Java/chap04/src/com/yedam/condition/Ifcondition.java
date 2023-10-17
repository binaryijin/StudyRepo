package com.yedam.condition;

import java.util.Scanner;

public class Ifcondition {

	public static void main(String[] args) {
		int score = 93;
		
		//if문 한개
		if(score >= 90) {
			System.out.println("점수가 90 이상이고 등급 A");
		}
		
		//if문 실행문 한줄
		if(score > 90)
			System.out.println("점수가 90 이상이고 등급 A");
		System.out.println("스코어 90");
		
		//if-else
		if(score >= 90) {
			System.out.println("점수가 90 이상입니다.");
		}else {
			System.out.println("점수가 90 미만입니다.");
		}
		
		
		if(score >= 90) {
			System.out.println("등급 A");
		}else if(score >= 80) {
			System.out.println("등급 B");
		}else if(score >= 70) {
			System.out.println("등급 C");
		}else {
			System.out.println("등급 D");
		}
		
		if(score < 70) {
			System.out.println("등급 D");
		}else if(score < 80) {
			System.out.println("등급 C");
		}else if(score < 90) {
			System.out.println("등급 B");
		}else {
			System.out.println("등급 A");
		}
		
		//random() 값 추출
		//Random() / Math.random()
		//Math.random() -> 실수
		//0 <= Math.random() < 1 : 0 <= x < 1
		//System.out.println(Math.random());
		//1부터 10사이의 데이터를 랜덤 추출
		//0 * 10 <= Math.random() * 10 < 0.9xxxx * 10 
		//0 ~ 9.xxxx, double -> int 소수점 삭제
		//(int) 0 <= (int)Math.random() * 10 < (int) 10
		//(int) 0 + 1 <= (int)Math.random() * 10 + 1 < (int) 10 + 1
		//(int) 1 ~ (int) 11
		
		// 주사위 번호 뽑기(1~6)
		// 0 <= x < 1
		// 0 * 6 <= x * 6 < 1 * 6
		// (int)0 <= (int)x * 6 < (int)6
		// (int)1 <= (int)x * 6 + 1 < (int)7
		
		int number = (int)(Math.random() * 6) + 1;
		if(number == 1) {
			System.out.println("주사위 눈 1");
		}else if (number == 2) {
			System.out.println("주사위 눈 2");
		}else if (number == 3) {
			System.out.println("주사위 눈 3");
		}else if (number == 4) {
			System.out.println("주사위 눈 4");
		}else if (number == 5) {
			System.out.println("주사위 눈 5");
		}else {
			System.out.println("주사위 눈 6");
		}
		
		// 중첩 if문
		// 하나의 데이터를 여러번 조건을 확인할 때
//		if(조건식) {
//			실행문
//			if(조건식) {
//				실행문
//				if(조건식) {		
//					실행문
//				}
//			}
//		}
		
		int no = 10;
		if(no % 2 == 0) {
			if(no % 5 == 0) {
				if(no % 10 == 0) {
					System.out.println("2의 배수, 5의 배수, 10의 배수");
				}
			}
		}
		
		Scanner sc = new Scanner(System.in);
		
		System.out.println("점수 입력>");
		
		score = Integer.parseInt(sc.nextLine());
		
		String grade = "";
		
		if(score >= 90) {
			if(score >= 95) {
				grade = "A+";
			}else {
				grade = "A";
			}
		}
		System.out.println("획득한 학점 : "+ grade);
	}

}
