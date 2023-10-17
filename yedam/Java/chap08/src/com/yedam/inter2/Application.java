package com.yedam.inter2;

public class Application {

	public static void main(String[] args) {
		//A(I) <- B <- C
		A a = new B();
		a.info();
		
		a = new C();
		a.info();
	}

}
