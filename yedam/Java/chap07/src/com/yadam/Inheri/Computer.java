package com.yadam.Inheri;

public class Computer extends Calculator{
	
	@Override //어노테이션
	double areaCircle(double r) {
		System.out.println("Computer 객체의 메소드 실행");
		return Math.PI * r * r;
	}
}
