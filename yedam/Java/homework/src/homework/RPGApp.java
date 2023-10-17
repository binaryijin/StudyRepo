package homework;

public class RPGApp {

	public static void main(String[] args) {
		RPGgame rpg = new RPGgame();
		rpg.leftUpButton();
		rpg.leftDownButton();
		rpg.changeMode();
		rpg.rightUpButton();
		rpg.rightDownButton();
		rpg.leftDownButton();
		rpg.changeMode();
		rpg.rightDownButton();
		
		System.out.println("======================");
		
		ArcadeGame Arc = new ArcadeGame();
		Arc.leftUpButton();
		Arc.rightUpButton();
		Arc.leftDownButton();
		Arc.changeMode();
		Arc.rightUpButton();
		Arc.leftUpButton();
		Arc.rightDownButton();
	}

}
