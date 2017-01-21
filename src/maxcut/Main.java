package maxcut;

public class Main {

	public static void main(String[] args) {
		int amount = 1;
		int nodes = 5;
		int maxWeight = 5;
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
