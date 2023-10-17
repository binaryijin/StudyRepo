package com.yedam.poly;

public class ChildExample {

	public static void main(String[] args) {
		//부모-자식 간의 자동타입변환
		//1) 부모 변수명 = new 자식생성자()
		//2) 자식 변수명 = new 자식생성자()
		//	 부모 변수명2 = 변수명;
		//Child(자식)의 생성자로 객체를 생성하고
		//이 객체를 Parent(부모)의 객체에 담아준다.
		
		//타입변환 + 오버라이딩 = 다 형 성
		//부모 클래스에 있는 내용을 사용을 하되,
		//만약 자식클래스에 부모 메소드가 재정의(오버라이딩)이 되어 있다면
		//부모 클래스에 있는 내용을 사용하지 않고!!! 자식 클래스의 메소드를 사용
		//위에 내용을 활용을 해서 하나의 타입(부모)으로 된 객체를 여러 개를 생성
		//하나의 부모에 여러 자식이 존재 -> 다양한 객체를 생성 -> 다형성
		
		Parent p1 = new Child();
		p1.method1();
		p1.method2();
		p1.field = "parent";
//		p1.field2 = "child";
//		p1.method3();
		
		p1 = new Child02();
		p1.method1();
		p1.method2();
		p1.field = "parent";
	}

}
