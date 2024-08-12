package com.cathaybk.practice.nt50340.b;
/**
 * JAVA評量5
 */
import java.time.LocalDate;
import java.util.Scanner;

public class Calender {

	public static void main(String[] args) {

		Scanner scanner = new Scanner(System.in);
		int month = 0;
		do {
			System.out.print("輸入介於1-12之間的整數m：");
			if (!scanner.hasNextInt()) {
				scanner.next();
			} else {
				month = scanner.nextInt();
			}
		} while (month < 1 || month > 12);

		LocalDate firstDate = LocalDate.of(2024, month, 1);
		int dayMonth = firstDate.lengthOfMonth();
		int dayWeek = firstDate.getDayOfWeek().getValue();
		System.out.printf("       2024年%d月\n", month);
		System.out.println("---------------------");
		System.out.println("日  一  二  三  四  五  六");
		System.out.println("=====================");
		
		for (int i = 0; i < dayWeek % 7; i++) {
			System.out.print("   ");
		}
		
		for (int i = 1; i <= dayMonth; i++) {
			System.out.printf("%2d ", i);
			if ((i + dayWeek) % 7 == 0) {
				System.out.println();
			}
		}
		scanner.close();
	}
}
