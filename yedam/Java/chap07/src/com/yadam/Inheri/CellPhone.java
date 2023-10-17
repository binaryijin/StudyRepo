package com.yadam.Inheri;

public class CellPhone {
	//필드
	String model;
	String color;
	
	//생성자
	public CellPhone() {
		
	}
	
	CellPhone(String model){
		this.model = model;
	}
	
	//메소드
	void powerOn() {
		System.out.println("전원을 켭니다.");
	}
	
	void powerOff() {
		System.out.println("전원을 끕니다.");
	}
	
	void bell() {
		System.out.println("전화가 옵니다.");
	}
	
	void hangUp() {
		System.out.println("전화를 끊습니다.");
	}
}
