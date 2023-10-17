package com.yedam.reference;

public class StringRef {

	public static void main(String[] args) {
		//heap 100번지 => "yedam"
		String strVal1 = "yedam";
		String strVal2 = "yedam";
		//두 문자열의 주소값 비교
		if(strVal1 == strVal2) {
			System.out.println("strVal1과 strVal2는 메모리 주소 동일");
		}else {
			System.out.println("strVal1과 strVal2는 메모리 주소 다름");			
		}
		
		//두 문자열의 데이터 비교
		if(strVal1.equals(strVal2)) {
			System.out.println("strVal1과 strVal2는 데이터가 동일");			
		}else {
			System.out.println("strVal1과 strVal2는 데이터가 다름");			
		}
		
		//new 연산자를 활용해서 String의 새로운 객체 생성
		//heap에 객체 생성
		//heap에 문자열을 넣을 수 있는 공간을 만든다
		
		String strVal3 = new String("yedam"); //새로운 공간(200번지)
		String strVal4 = new String("yedam"); //새로운 공간(300번지)
		
		//객체간 주소 비교(==)
		if(strVal3 == strVal4) {
			System.out.println("strVal3과 strVal4는 메모리 주소 동일");
		}else {
			System.out.println("strVal3과 strVal4는 메모리 주소 다름");
		}
		
		//객체간 데이터 비교
		if(strVal3.equals(strVal4)) {
			System.out.println("strVal3과 strVal4는 데이터 동일");
		}else {
			System.out.println("strVal3과 strVal4는 데이터 다름");
		}
		
		if(strVal1 == strVal3) {
			System.out.println("strVal1과 strVal3은 메모리 주소 동일");
		}else {
			System.out.println("strVal1과 strVal3은 메모리 주소 다름");
		}
		
		
		
	}

}
