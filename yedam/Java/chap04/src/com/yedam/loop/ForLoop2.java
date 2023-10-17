package com.yedam.loop;

public class ForLoop2 {

	public static void main(String[] args) {
		//중첩 for문
//		for() {
//			for() {
//			
//			}
//		}
		
		//2단 ~ 9단 출력
		for(int k=2; k<=9; k++) {
			for(int i=1; i<=9; i++) {
			System.out.println(k + " * " + i + " = " + (k * i));
			}
		}
		
//		*
//		**
//		***
//		****
//		*****
		for(int i=1; i<=5; i++) {
			for(int j=0; j<i; j++) {
				System.out.print("*");
			}
			System.out.println();
		}
		
//		*****
//		****
//		***
//		**
//		*
		System.out.println();
		
		for(int i=5; i>=0; i--) {
			for(int j=i; j>0; j--) {
				System.out.print("*");
			}
			System.out.println();
		}
	}

}
