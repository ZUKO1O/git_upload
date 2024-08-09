package com.cathaybk.practice.nt50340.b;

import java.math.BigDecimal;

public class Sales extends Employee {

	private int bonus;

	private int payment;

	@Override
	public void printInfo() {
		super.printInfo();
		System.out.printf("業績獎金： %s\n總計： %d\n", bonus, payment);
	}

	public Sales(String name, String department, int salary, int bonusOri) {
		super(name, department, salary);
		BigDecimal multiBig = new BigDecimal(0.05);
		BigDecimal bonusBig = new BigDecimal(bonusOri);
		BigDecimal salaryBig = new BigDecimal(salary);
		this.payment = bonusBig.multiply(multiBig).add(salaryBig).intValue();
		this.bonus = bonusBig.multiply(multiBig).intValue();
	}

	public int getBonus() {
		return bonus;
	}

	public int getPayment() {
		return payment;
	}

	public void setBonus(int bonus) {
		this.bonus = bonus;
	}

	public void setPayment(int payment) {
		this.payment = payment;
	}

}
