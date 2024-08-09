package com.cathaybk.practice.nt50340.b;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.List;

public class HRMain {

	public static void main(String[] args) {

		String url = "C:\\Users\\Admin\\Desktop\\output.csv";
		File outFile = new File(url);
		List<Employee> employeeList = new ArrayList<>();

		employeeList.add(new Sales("張志城", "信用卡部", 35000, 6000));
		employeeList.add(new Sales("林大鈞", "保代部", 38000, 4000));
		employeeList.add(new Supervisor("李中白", "資訊部", 65000));
		employeeList.add(new Supervisor("林小中", "理財部", 80000));
		for (Employee employee : employeeList) {
			employee.printInfo();
		}

		try (BufferedWriter writeOut = new BufferedWriter(
				new OutputStreamWriter(new FileOutputStream(outFile), "UTF-8"))) {

			for (Employee employee : employeeList) {
				int payment = 0;
				if (employee instanceof Supervisor) {
					payment = ((Supervisor) employee).getPayment();
					writeOut.write(((Supervisor) employee).getName() + "," + payment + "\r");
				} else if (employee instanceof Sales) {
					payment = ((Sales) employee).getPayment();
					writeOut.write(((Sales) employee).getName() + "," + payment + "\r");
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
