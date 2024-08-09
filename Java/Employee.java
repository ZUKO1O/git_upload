package com.cathaybk.practice.nt50340.b;

public class Employee implements IWork {

	private String name;

	private String department;

	private int salary;

	@Override
	public void printInfo() {
		System.out.println("薪資單");
		System.out.printf("姓名： %s 工作部門： %s\n月薪：%d\n", name, department, salary);
	}

	public Employee(String name, String department, int salary) {
		this.name = name;
		this.department = department;
		this.salary = salary;
	}

	public String getName() {
		return name;
	}

	public String getDepartment() {
		return department;
	}

	public int getSalary() {
		return salary;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public void setSalary(int salary) {
		this.salary = salary;
	}

}
