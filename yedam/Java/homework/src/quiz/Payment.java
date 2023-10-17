package quiz;

public interface Payment {
	//상수 필드 - static final
	public final static double ONLINE_PAYMENT_RATIO = 0.05;
	public final static double OFFLINE_PAYMENT_RATIO = 0.03;
	
	public abstract int online(int price);
	public abstract int offline(int price);
	public abstract void showInfo();
	
	
}
