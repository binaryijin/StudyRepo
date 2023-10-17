package com.yadam.operator;

public class Operator {

	public static void main(String[] args) {
		//++num, num++
		int num = 0;
		System.out.println(num++);
		
		System.out.println(++num);
		
		System.out.println(num--);
		
		System.out.println(--num);
		
		//논리 부정 연산자 ! (not)
		boolean play = true;
		
		System.out.println(play);
		
		play = !play;
		
		System.out.println(play);
		
		//비교 연산자
		
		//true or false
		
		int num1 = 10;
		int num2 = 10;
		
		boolean result1 = (num1 == num2);
		boolean result2 = (num1 != num2);
		boolean result3 = (num1 <= num2);
		
		System.out.println(result1);
		System.out.println(result2);
		System.out.println(result3);
		
		char char1 = 'A';
		char char2 = 'B';
		
		boolean result4 = (char1 < char2);
		System.out.println(result4);
		
		//논리 연산자
		char charCode = 'A';
		//A보다 같거나 크고 Z보다 같거나 작은 경우
		if(charCode >= 65 && charCode <= 90) {
			System.out.println("대문자 입니다.");
		}
		
		if(charCode >= 97 && charCode <= 122) {
			System.out.println("소문자 입니다.");
		}
		
		//논리 부정 연산자 -> 이산수학
		if(!(charCode < 65) && !(charCode > 90)) {
			System.out.println("대문자 입니다.");
		}
		
		//복합 대입 연산자
		int result = 0;
		
		result += 10; //result = result + 10; -> 속도 차이 없음
		result -= 5; //result = result - 5;
		result *= 5; //result = result * 5;
		
		//삼항 연산자
		
		int score = 80;
		char grade;
		
		if(score >= 80) {
			grade = 'B';
		}else {
			grade = 'D';
		}
		
		grade = score >= 80 ? 'B' : 'D';
		
	}

}
