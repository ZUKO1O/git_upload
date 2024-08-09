package com.cathaybk.practice.nt50340.b;

public class NineNineTable {

	public static void main(String[] args) {

		int num = 9;

		for (int i = 1; i < num + 1; i++) {
			for (int j = 1; j < num; j++) {
				int result = (j + 1) * i;
				System.out.printf("%d*%d=%s ", j + 1, i, String.format("%2d", result));
			}
			System.out.println();
		}

	}

}
