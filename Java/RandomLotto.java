package com.cathaybk.practice.nt50340.b;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

public class RandomLotto {

	public static void main(String[] args) {

		Random rand = new Random();
		List<Integer> num = new ArrayList<>();
		while (num.size() < 6) {
			int randNum = rand.nextInt(49) + 1;
			if (!num.contains(randNum)) {
				num.add(randNum);
			}
		}

		System.out.print("排序前：");
		printNum(num);
		Collections.sort(num);
		System.out.print("排序後：");
		printNum(num);
	}

	public static void printNum(List<Integer> list) {
		for (Integer onlyNum : list) {
			System.out.print(onlyNum + " ");
		}
		System.out.println();
	}

}
