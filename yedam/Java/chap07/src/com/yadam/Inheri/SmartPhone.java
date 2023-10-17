package com.yadam.Inheri;

public class SmartPhone extends CellPhone{
	//필드
	String agency;
	
	//생성자
	SmartPhone(String model, String color, String agency){
		//부모 생성자 호출 -> 부모 클래스를 객체로 생성 한 뒤
		//자식 클래스를 객체로 생성
		super(); //CellPhone(){}를 호출함, 생략 가능
		this.model = model;
		this.color = color;
		this.agency = agency;
	}
	
	SmartPhone(String model, String color){
		super(model);
		this.color = color;
		this.agency = "KT";
	}
	void kakaoExe() {
		System.out.println("카카오톡을 실행합니다.");
	}
	
	void Info() {
		System.out.println("통신사 : " + agency + " 입니다.");
	}
	
	void kakaoExit() {
		System.out.println("카카오톡을 종료합니다.");
	}
}
