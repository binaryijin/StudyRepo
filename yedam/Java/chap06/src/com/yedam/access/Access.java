package com.yedam.access;

public class Access {
	/*
	 * 접근 제한자 : 필드, 메소드, 킅ㄹ래스, 생성자, 인터페이스 등 앞에 사용 가능
	 * public : 어디서든 누구나 다 사용할 수 있다.
	 * protected : 같은 패키지 내에서만 사용 가능, 다른 패키지일 경우에는 사용x
	 * 				상속이라는 관계를 맺은 부모 - 자식 사용 가능(패키지가 달라도 가능)
	 * default : 같은 패키지 내에서만 사용 가능, 다른 패키지일 경우에는 사용x
	 * private : 내가 속한 클래스, 객체에서만 사용 가능
	 */
	//필드
	public String free;
	protected String parent;
	String basic; //default
	private String privacy;
	
	
	//생성자에 접근 제한 -> 객체를 생성하는 범위를 제한
	/*
	 * public -> 어디서든지 객체 생성 가능
	 * protected -> 같은 패키지에서만 객체 생성 가능하나 부모 - 자식 관계에서는 어디서든지 객체 생성 가능
	 * default -> 같은 패키지에서만 생성 가능
	 * private -> 객체 생성 불가능(막음)
	 */
	
	public Access() {
		
	}
	
	protected Access(int a) {
		
	}
	
	Access(String s){
		
	}
	
	private Access(double a) { //-> 노란색 줄 : 한번도 사용하지 않음
		
	}
	
	//메소드
	private void info() {
		System.out.println("private 메소드");
	}
	
	public void instead() {
		info();
	}
	
	protected void parent()	{
		System.out.println("protected 메소드");
	}
	
	void basic() {
		System.out.println("default 메소드");
	}
}
