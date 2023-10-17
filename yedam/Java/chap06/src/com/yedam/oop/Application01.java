package com.yedam.oop;

public class Application01 {

	//실행 클래스
	public static void main(String[] args) {
		//Car Class -> 객체
		Car myCar = new Car(); //Car Class 타입, 변수 = 객체생성, 생성자;
		//dot,, .
		System.out.println(myCar.company);
		System.out.println(myCar.price);
		System.out.println(myCar.name);
		
		//클래스 외부에서 객체를 생성하고 필드를 호출하여 데이터 입력
		myCar.company = "현대";
		myCar.price = 1234;
		myCar.name = "소나타";
		System.out.println("==객체 필드 데이터 입력==");
		System.out.println(myCar.company);
		System.out.println(myCar.price);
		System.out.println(myCar.name);
		
		Car yourCar = new Car();
		System.out.println("MyCar와 YourCar 비교");
		System.out.println(myCar.company);
		System.out.println(yourCar.company);
		
		System.out.println("==Korean Class를 활용한 객체 생성==");
		
//		Korean k1 = new Korean(); //오류 -> Korean클래스에는 두개의 매개변수를 가지는 생성자만 존재함
		
		Korean k1 = new Korean("박자바", "01125-321321");
		System.out.println(k1.nation);
		System.out.println(k1.name);
		System.out.println(k1.ssn);
		
		System.out.println("==생성자 오버로딩을 활용한 객체 생성==");
		
		//매개변수가 하나인 생성자 활용
		Car oneCar = new Car("소나타");
		System.out.println("oneCar의 필드 name : "+ oneCar.name);
		
//		Car threeCar = new Car("그랜저", 3000, "현대");
//		System.out.println("ThreeCar의 필드 : " + threeCar.name);
//		System.out.println("ThreeCar의 필드 : " + threeCar.price);
//		System.out.println("ThreeCar의 필드 : " + threeCar.company);
		
		oneCar.run();
		System.out.println(oneCar.info());
	}

}
