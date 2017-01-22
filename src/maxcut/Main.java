package maxcut;

public class Main {

	public static void main(String[] args) {
		int amount = 10;
		int nodes = 100;
		int maxWeight = 25;
		double[] edgeProbability = {0.5, 1};
		
		for (double prob : edgeProbability) {
			for (int weight = 1; weight <= maxWeight; weight = weight<5 ? 5 : weight+5) {
				for (int n = 5; n <= nodes; n+=5) {
					for (int a = 0; a < amount; a++) {
						GraphGenerator.generate(n, prob, weight, a);
					}
				}
			}
		}
	}

}
