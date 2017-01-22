package maxcut;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

public class GraphGenerator {
	
	private static int nodes, maxWeight, nr;
	private static double edgeProbability;
	
	public static void main(String[] args) {
		generate(args);
	}
	
	public static void generate(String[] args) {
		if (args.length < 4) {
			System.out.println("Generator requires 4 parameters:");
			System.out.println("  number of nodes");
			System.out.println("  edge probability");
			System.out.println("  max. weight of the edges");
			System.out.println("  id (for multiple instances with the same settings)");
			return;
		}
		
		for (int i = 0; i < args.length; i++) {
			try {
				nodes = Integer.parseInt(args[0]);
				edgeProbability = Double.parseDouble(args[1]);
				maxWeight = Integer.parseInt(args[2]);
				nr = Integer.parseInt(args[3]);
			} catch(Exception e) {
				System.out.println("Couldn't parse all arguments: ");
				System.out.println("  " + e);
				return;
			}
		}
		if (check()) {
			generate();
		}
	}
	
	public static void generate(int nds, double edgeprobability, int maxweight, int id) {
		nodes = nds;
		edgeProbability = edgeprobability;
		maxWeight = maxweight;
		nr = id;
		
		if (check()) {
			//generate();
			generateMatrix();
		}
	}
	
	private static boolean check() {
		if (edgeProbability < 0 || edgeProbability > 1) {
			System.out.println("Please pick an edge probability between 0 and 1.");
			return false;
		}
		
		if (nodes < 0 || maxWeight < 0 || nr < 0) {
			System.out.println("Please use positive numbers as arguments.");
			return false;
		}
		return true;
	}
	
	private static void generate() {
		//construct the filename
		String filename = getFilename();
		
		//write the file
		PrintWriter out = null;
		try {
			out = new PrintWriter(new BufferedWriter(new FileWriter(filename)));
		} catch (IOException e) {
			e.printStackTrace();
			return;
		}
		
		out.println(nodes);
		
		int weight;
		double random;
		for (int n1 = 1; n1 < nodes; n1++) {
			for (int n2 = 0; n2 < n1; n2++) {
				if (n1 == n2)
					continue;
				random = Math.random();
				if (random < edgeProbability) {
					weight = (int) (Math.random() * maxWeight + 1);
					out.println(n1 + " " + n2 + " " + weight);
				}
			}
		}
		out.flush();
		out.close();
	}
	
	private static void generateMatrix() {
		int[][] matrix = new int[nodes][nodes];
		
		int weight;
		double random;
		for (int i = 0; i < nodes; i++) {
			for (int j = i+1; j < nodes; j++) {
				random = Math.random();
				if (random < edgeProbability) {
					weight = (int) (Math.random() * maxWeight + 1);
					matrix[i][j] = weight;
					//matrix[j][i] = weight;
				}
			}
		}
		
		//construct the filename
		String filename = getFilename();
		
		System.out.println("Writing: " + filename);
		
		//write the file
		PrintWriter out = null;
		try {
			out = new PrintWriter(new BufferedWriter(new FileWriter(filename)));
		} catch (IOException e) {
			e.printStackTrace();
			return;
		}
		
		for (int i = 0; i < nodes; i++) {
			for (int j = 0; j < nodes; j++) {
					out.print(matrix[i][j] + " ");
			}
			out.println();
		}
		out.flush();
		out.close();
	}
	
	private static String getFilename() {
		//construct the filename
		String edge = ""+edgeProbability;
		edge = edge.replaceFirst("\\.", "");
		if (edge.length() > 5)
			edge = edge.substring(0, 6);
		String id = String.format("%02d", nr);
		return "graphs/maxcut_"+nodes+"_"+edge+"_"+maxWeight+"_instance_"+id; 
	}
}