package com.yedam.oop;

public class BookApplication {

	public static void main(String[] args) {
		Book b1 = new Book("혼자 공부하는 자바", "학습서", "24000", "0001", "한빛 미디어");
		b1.getInfo();
		
		Book b2 = new Book("자바스크립트", "학습서", "15000", "0002", "어포스트");
		b2.getInfo();
		
		}

}
