package com.cathaybk.practice.nt50340.b;
/**
 * JAVA評量2
 */
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class RandomLotto2 {

	public static int totalNum = 49;
	public static int pickNum = 6;

	public static void main(String[] args) {
		List<Integer> numberList = new ArrayList<>();
		List<Integer> randomList = new ArrayList<>();
		for (int i = 0; i < totalNum; i++) {
			numberList.add(i, i + 1);
		}
		Collections.shuffle(numberList);
		for (int i = 0; i < pickNum; i++) {
			randomList.add(i, numberList.get(i));
		}
		System.out.print("排序前：");
		printNum(randomList);
		Collections.sort(randomList);
		System.out.print("排序後：");
		printNum(randomList);
	}

	public static void printNum(List<Integer> list) {
		for (Integer onlyNum : list) {
			System.out.print(onlyNum + " ");
		}
		System.out.println();
	}
}
