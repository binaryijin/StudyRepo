package com.yedam.oop;

import java.util.Scanner;

public class Application06 {

	public static void main(String[] args) {
		//학생의 정보를 관리하는 프로그램
		//학생의 정보를 관리하는 객체
		//이름, 학년, 국어, 영어, 수학
		
		//기본 생성자
		
		//메소드
		//모든 정보를 출력 getInfo()
		
		//1. 학생수
		//2. 정보 입력
		//3. 정보 확인
		//4. 분석 - 전체 학생의 점수를 총합(국+영+수)
		//       - 총합의 평균(학생수의 평균)
		//		 - 개인별 가장 점수가 높은 과목 / 낮은 과목
		//5. 종료
		
		//학생의 정보를 보관하는 배열
		Student[] studentArr = null;
		//학생의 정보가 몇명인지 보관하는 변수
		int studentNum = 0;
		
		Scanner sc = new Scanner(System.in);
		
		while(true) {
			System.out.println("=============================================");
			System.out.println("1.학생수 | 2.정보입력 | 3.정보확인 | 4.분석 | 5.종료");
			System.out.println("=============================================");
			
			int selectNo = Integer.parseInt(sc.nextLine());
			
			if(selectNo == 1) {
				System.out.println("학생수>");
				studentNum = Integer.parseInt(sc.nextLine());
			}else if(selectNo == 2) {
				studentArr = new Student[studentNum];
				
				for(int i=0; i<studentArr.length; i++) { //studentArr.length = studentNum
					//배열에 바로 객체를 만듬
					studentArr[i] = new Student();
					System.out.println("이름>");
					studentArr[i].name = sc.nextLine();
					System.out.println("학년>");
					studentArr[i].year = Integer.parseInt(sc.nextLine());
					System.out.println("국어>");
					studentArr[i].kor = Integer.parseInt(sc.nextLine());
					System.out.println("영어>");
					studentArr[i].eng = Integer.parseInt(sc.nextLine());
					System.out.println("수학>");
					studentArr[i].math = Integer.parseInt(sc.nextLine());
					
					
//					Student student = new Student();
//					System.out.println("이름>");
//					student.name = sc.nextLine();
//					System.out.println("학년>");
//					student.year = Integer.parseInt(sc.nextLine());
//					System.out.println("국어>");
//					student.kor = Integer.parseInt(sc.nextLine());
//					System.out.println("영어>");
//					student.eng = Integer.parseInt(sc.nextLine());
//					System.out.println("수학>");
//					student.math = Integer.parseInt(sc.nextLine());
//					studentArr[i] = student;
				}
			}else if(selectNo == 3) {
				for(int i=0; i<studentArr.length; i++) {
					System.out.println((i+1)+ "번 학생의 정보");
					studentArr[i].getInfo();
					System.out.println();
				}
			}else if(selectNo == 4) {
				int total = 0;
				double avg = 0;
				int max = 0;
				int min = 0;
				for(int i=0; i<studentArr.length; i++) {
					//반복문 돌때마다 누적 합계
					total = total + studentArr[i].kor + studentArr[i].eng + studentArr[i].math;
					
					max = studentArr[i].kor;
					min = studentArr[i].kor;
					
					if(studentArr[i].eng < studentArr[i].math) {
						if(max < studentArr[i].math) {
							max = studentArr[i].math;
						}
					}else {
						if(max < studentArr[i].eng) {
							max = studentArr[i].eng;
						}
					}
				}
				System.out.println("총 합 : " + total);
				System.out.println("평 균 : " + (double)total/studentArr.length);
				
//				int sum = 0;
//				int max = 0;
//				int min = 0;
//				
//				for(int i=0; i<studentArr.length; i++) {
//					sum = studentArr[i].kor 
//						 + studentArr[i].eng
//						 + studentArr[i].math;
//					System.out.println(studentArr[i].name + "학생의 총합 : " + sum);
//					System.out.println(studentArr[i].name + "학생의 평균 : " + (double)sum / 3);				
					
							
			}else if(selectNo == 5) {
				System.out.println("프로그램 종료");
				break;
			}
		}
		
		
	}

}
