package quiz;

public class TossCard extends Card {

	String company ="Toss";
	String cardStaff;
	
	public TossCard(String cardNo, int validDate, int cvc, String cardStaff) {
		super(cardNo, validDate, cvc);
		this.cardStaff = cardStaff;
	}
	public void showCardInfo() {
		System.out.println("카드정보 - Card NO, " + cardNo + "\n담당직원 - " + cardStaff + ", " + company);
	}
}
