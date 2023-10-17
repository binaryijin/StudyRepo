package com.yedam.oop;

import java.util.Scanner;

public class Application05 {

	public static void main(String[] args) {
		//객체 배열
		//Book Class
		Book[] bookAry = new Book[10];
		
		//객체를 생성해서 저장
		Book b1 = new Book("혼자 공부하는 자바", "학습서", "24000원", "0001", "한빛 미디어");
		
		bookAry[0] = b1;
		System.out.println(b1);
		System.out.println(bookAry[0]);
		//b1.getInfo()
		//bookAry[0].getInfo()
		
		//배열의 공간에 바로 객체 생성
		bookAry[1] = new Book("자바스크립트", "학습서", "15000원", "0002", "어포스트");
		
//		Book b2 = new Book("자바스크립트", "학습서", "15000원", "0002", "어포스트");
		
		//객체 배열
		//책들의 정보를 저장하는 프로그램
		//1. 책 몇권인지
		//2. 책 정보 입력
		//3. 책 정보 확인
		//4. 종료
		
		//책 정보를 보관하는 배열
		Book[] bookAry2 = null;
		
		//책 몇권인지 받는 변수
		int bookNum = 0;
		
		//데이터 입력을 받을 수 있는 스캐너
		Scanner sc = new Scanner(System.in);
		
		while(true) {
			System.out.println("=========================================");
			System.out.println("1. 책 수 | 2. 책 입력 | 3. 정보 확인 | 4. 종료");
			System.out.println("=========================================");
			
			String selectNo = sc.nextLine();
			
			if(selectNo.equals("1")) {
				//데이터 입력 -> 배열 -> 크기
				System.out.println("책 수>");
				bookNum = Integer.parseInt(sc.nextLine());
				
			}else if(selectNo.equals("2")) {
				bookAry2 = new Book[bookNum];
				//책 정보 입력
				for(int i=0; i<bookAry2.length; i++) {
					//객체를 생성하고 배열에 저장
					Book book = new Book();
					
					System.out.println("책 제목>");
					book.name = sc.nextLine();
					System.out.println("책 종류>");
					book.kind = sc.nextLine();
					System.out.println("책 가격>");
					book.price = sc.nextLine();
					System.out.println("도서번호>");
					book.num = sc.nextLine();
					System.out.println("출판사>");
					book.company = sc.nextLine();
					
					//bookAry2 각 위치마다 생성한 객체를 저장
					bookAry2[i] = book;
				}
			}else if(selectNo.equals("3")) {
				//모든 책 정보 확인
				for(int i=0; i<bookAry2.length; i++) {
					System.out.println((i+1) + "번째 책 정보====");
					bookAry2[i].getInfo();
					System.out.println();
				}
			}else if(selectNo.equals("4")) {
				System.out.println("프로그램 종료");
				break;
			}else {
				System.out.println("번호 잘못 입력");
			}
				
		}
		
		
		
		
	}

}
