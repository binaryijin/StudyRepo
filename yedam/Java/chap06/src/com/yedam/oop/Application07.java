package com.yedam.oop;

import java.util.Scanner;

import com.yedam.access.Access;

public class Application07 {
	//import ctrl + shift + o
	Scanner sc = new scanner(System.in);
	//필드 선언
	static int num = 1;
	
	//메소드 선언
	static void info() {
		System.out.println("info 출력");
	}
	
	public static void main(String[] args) {
//		static이 아닐 경우엔 아래처럼 사용
//		자기 자신을 객체로 만든 예제 -> 절대로 하지 말 것
//		Application07 app = new Application07
//		app.info()
		
		int a = num + 1;
		
		info();
		
		//클래스에 정의된 정적 멤버 사용
		//클래스명.필드명 | 클래스명.메소드명
		
		//정적 필드
		System.out.println(StaticCal.PI);
		//정적 메소드
		System.out.println(StaticCal.minus(10, 5));
		System.out.println(StaticCal.plus(10, 5));
		
		Person p1 = new Person("111111-111111", "김또치");
		System.out.println(p1.nation);
		System.out.println(p1.ssn);
		System.out.println(p1.name);
		
//		p1.ssn = "222222-22222"; final -> 변경 안됨
		
		System.out.println("지구의 반지름 : " + StaticCal.EARTH_RADIUS);
							//pi * r * r
		System.out.println("지구의 표면적 : " + StaticCal.PI * StaticCal.EARTH_RADIUS * StaticCal.EARTH_RADIUS);
		
		Access ac = new Access();
		ac.free = "public";
//		ac.parent = "protected";
//		ac.basic = "default";
//		ac.privacy = "private";
	}

}
