package quiz;

public class CardPayment implements Payment{
	double cardRatio;
	
	CardPayment(double cardRatio){
		this.cardRatio = cardRatio;
	}
	@Override
	public int online(int price) {
		return (int)(price * ( 1 - (cardRatio + ONLINE_PAYMENT_RATIO))); 
		
	}
	@Override
	public int offline(int price) {
		return (int)(price * ( 1 - (cardRatio + OFFLINE_PAYMENT_RATIO))); 
	}
	@Override
	public void showInfo() {
		System.out.println("*** 카드로 결제 시 할인정보");
		System.out.println("온라인 결제시 총 할인율 : " + (cardRatio + Payment.ONLINE_PAYMENT_RATIO));
		System.out.println("오프라인 결제시 총 할인율 : " + (cardRatio + Payment.OFFLINE_PAYMENT_RATIO));
	}
}
