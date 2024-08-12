package com.cathaybk.practice.nt50340.b;
/**
 * JAVA評量6
 */
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

public class Cars {

	public static String URL_IN = "C:\\Users\\Admin\\Desktop\\cars.csv";

	public static String URL_OUT = "C:\\Users\\Admin\\Desktop\\cars2.csv";

	public static void main(String[] args) {
		// 第一部分
		BufferedReader readCars = null;
		BufferedWriter writeOut = null;
		String line = null;
		List<Map<String, String>> carList = new ArrayList<>();
		File outFile = new File(URL_OUT);

		try {
			readCars = new BufferedReader(new InputStreamReader(new FileInputStream(URL_IN)));
			writeOut = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outFile), "UTF-8"));
			line = readCars.readLine();
			String title[] = line.split(",");

			while ((line = readCars.readLine()) != null) {
				String content[] = line.split(",");
				Map<String, String> carMap = new HashMap<>();
				for (int i = 0; i < title.length; i++) {
					carMap.put(title[i], content[i].trim());
				}
				carList.add(carMap);
			}

			Collections.sort(carList, new Comparator<Map<String, String>>() {

				@Override
				public int compare(Map<String, String> m1, Map<String, String> m2) {
					int compare = m2.get("Price").compareTo(m1.get("Price"));
					if (compare != 0) {
						return compare;
					}
					return m2.get("Min.Price").compareTo(m1.get("Min.Price"));
				}
			});

			writeOut.write(String.join(",", title) + "\n");
			for (Map<String, String> cars : carList) {
				for (int i = 0; i < title.length; i++) {
					writeOut.write(cars.get(title[i]) + ",");
				}
				writeOut.newLine();
			}

			// 第二部分
			Collections.sort(carList, new Comparator<Map<String, String>>() {

				@Override
				public int compare(Map<String, String> m1, Map<String, String> m2) {
					int compare = m1.get("Manufacturer").compareTo(m2.get("Manufacturer"));
					if (compare != 0) {
						return compare;
					}
					return m1.get("Type").compareTo(m2.get("Type"));
				}
			});
			Set<String> manufacturerSet = new TreeSet<>();
			BigDecimal totalMinPrice = BigDecimal.ZERO;
			BigDecimal totalPrice = BigDecimal.ZERO;
			System.out.printf("%-13s%-8s%8s%7s\n", "Manufacturer", "Type", "Min.Price", "Price");
			for (Map<String, String> cars : carList) {
				manufacturerSet.add(cars.get("Manufacturer"));
			}
			for (int i = 0; i < manufacturerSet.size(); i++) {
				BigDecimal subTotalMinPrice = BigDecimal.ZERO;
				BigDecimal subTotalPrice = BigDecimal.ZERO;
				for (Map<String, String> cars : carList) {
					if (cars.get("Manufacturer").equals(manufacturerSet.toArray()[i])) {
						System.out.printf("%-13s%-8s%8s%7s\n", cars.get("Manufacturer"), cars.get("Type"),
								cars.get("Min.Price"), cars.get("Price"));
						subTotalMinPrice = subTotalMinPrice.add(new BigDecimal(cars.get("Min.Price")));
						subTotalPrice = subTotalPrice.add(new BigDecimal(cars.get("Price")));
						totalMinPrice = totalMinPrice.add(new BigDecimal(cars.get("Min.Price")));
						totalPrice = totalPrice.add(new BigDecimal(cars.get("Price")));
					}
				}
				System.out.printf("%-20s%8s%7s\n", "小計", subTotalMinPrice, subTotalPrice);
			}
			System.out.printf("%-20s%8s%7s\n", "合計", totalMinPrice, totalPrice);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (readCars != null) {
					readCars.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if (writeOut != null) {
					writeOut.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

}
