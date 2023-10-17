package com.yedam.loop;

import java.util.Scanner;

public class ForLoop {

	public static void main(String[] args) {
		//for문
		//1~100까지의 수를 출력
		for(int i=1; i<=100; i++) {
			System.out.println(i);
		}
		int result = 0;
		
		for(int i=1; i<=100; i++) {
			result += i;
		}
		System.out.println("1~100사이의 합 " + result);
		
		//1~100사이의 짝, 홀수 구하기
		//숫자 % 2 == 0 -> 짝수
		//위의 경우가 아니라면 홀수
		for(int i=1; i<=100; i++) {
			if(i % 2 == 0) {
				System.out.println(i + "는 짝수");
			}else if(!(i % 2 ==0)){
				System.out.println(i + "는 홀수");
			}
		}
		
		//입력한 숫자에 대한 구구단 출력
		Scanner sc = new Scanner(System.in);
		
		//2 -> 2*1 = 2, 2*2 = 4
		System.out.println("구구단 입력>");
		
		int gugu = Integer.parseInt(sc.nextLine());
		
		for(int i=1; i<=9; i++) {
			System.out.println(gugu + " * "+ i + " = "+ (gugu*i));
		}
		
		//입력한 값에 대한 총합, 평균, 최대값, 최소값 구하기
		//몇번 반복 값을 입력 받는다.
		//예시) 5번 -> 2,50,20,10,5
		
//		System.out.println("몇번 반복?");
//		Scanner scanner = new Scanner(System.in);
//		int num = Integer.parseInt(scanner.nextLine());
//		int sum = 0;
//		double avg = 0;
//		int max = 0;
//		int min = 0;
//		for(int i=1; i<=num; i++) {
//			System.out.println("값 입력");
//			int x = Integer.parseInt(scanner.nextLine());
//			sum += x;
//			if(max < x) {
//				max = x;
//			}
//			if(min > x){
//				min = x;
//			}
//		}
//		System.out.println("총합" + sum);
//		
//		avg = (double)sum / num;
//		System.out.println("평균" + avg);
//		System.out.println("최대값" + max);
//		System.out.println("최소값" + min);
		
		
		System.out.println("반복횟수>");
		int count = Integer.parseInt(sc.nextLine());
		
		int total = 0;
		int avg = 0;
		int max = 0;
		int min = 0;
		
		for(int i=0; i<count; i++) {
			System.out.println("데이터입력>");
			int data = Integer.parseInt(sc.nextLine());
			//총 합계 -> 데이터를 입력 받는대로 누적 합계
			total += data; // total = total + 입력한 데이터
			if(i==0) {
				max = data;
				min = data;
			}else {
				//최대값 -> 최대값, 입력값을 비교 더 큰 데이터가 최대값
				if(max < data) {
					max = data;
				}
				//최소값 -> 최소값, 입력값을 비교 더 작은 데이터가 최소값
				if(min > data) {
					min = data;
				}
			}
		}
		//평균 -> 총 합계 / 반복문 횟수
		//total / count
		System.out.printf("평균 : %5.2f\n", (double)total / count);
		System.out.println("최대값 : " + max + " 최소값 : " + min);
		
		
		//임의의 랜덤 값(1~100) 하나 추출
		//5번 기회 안에 해당 랜덤 값을 맞추는 프로그램 구현
		//예시) 랜덤 값 : 50
		//사용자 : 입력 -> 30
		//컴퓨터 : up
		//사용자 : 입력 -> 40
		//컴퓨터 : up
		//사용자 : 입력 -> 60
		//컴퓨터 : down
		
		//1) 맞춘 경우
		//정답입니다. 몇 번 만에 맞추셨습니다.
		//2) 기회 안에 못 맞춘 경우
		//모든 기회를 소진하셨습니다.
		
		//반복문 강제 종료 -> break;
		
		int randomNo = (int)(Math.random()*100)+1;
		count = 0;
		for(int i=0; i<5; i++) {
			count++;
			System.out.println("값을 입력하세요");
			int num = Integer.parseInt(sc.nextLine());
			if(randomNo==num) {
				System.out.println("정답입니다. " + count +"번만에 맞추셨습니다.");
				break;
			}else if(randomNo>num) {
				System.out.println("up");
			}else if(randomNo<num) {
				System.out.println("down");
			}
			if(i==4) {
				System.out.println("모든 기회를 소진하셨습니다.");
			}
		}
		
		
		for(int i=1; i<=5; i++) {
			//데이터 입력
			System.out.println("데이터 입력>");
			int userData = Integer.parseInt(sc.nextLine());
			//정답
			if(userData == randomNo) {
				System.out.println("정답입니다, " + i + "번 만에 맞추셨습니다.");
				break;
			//입력 > 랜덤
			}else if(userData > randomNo) {
				System.out.println("down");
			//입력 < 랜덤
			}else if(userData < randomNo) {
				System.out.println("up");
			}
			if(i==5) {
				System.out.println("모든 기회 소진되었습니다.");
			}			
		}
		
		
	}

}
