package com.cathaybk.practice.nt50340.b;
/**
 * JAVA評量7
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

public class DataBase {

	private static final String CONN_ACCOUNT = "student";

	private static final String CONN_PASSWORD = "student123456";

	private static final String CONN_URL = "jdbc:oracle:thin:@//localhost:1521/XE";

	private static final String QUERY_ALL_SQL = "select MANUFACTURER, TYPE, MIN_PRICE, PRICE from STUDENT.CARS";

	private static final String QUERY_SQL = "select MANUFACTURER, TYPE, MIN_PRICE, PRICE from STUDENT.CARS where MANUFACTURER = ? and TYPE = ?";

	private static final String INSERT_SQL = "insert into STUDENT.CARS (MANUFACTURER, TYPE, MIN_PRICE, PRICE) values (?, ?, ?, ?)";

	private static final String UPDATE_SQL = "update STUDENT.CARS set MIN_PRICE = ?, PRICE = ? where MANUFACTURER = ? and TYPE = ?";

	private static final String DELETE_SQL = "delete from STUDENT.CARS where MANUFACTURER = ? and TYPE = ?";

	private static boolean reset = false;

	public static void main(String[] args) {
		// 第二部分
		Scanner scanner = new Scanner(System.in);
		ResultSet rs = null;
		List<Map<String, String>> carList = new ArrayList<>();
		StringBuilder sb = new StringBuilder();
		try (Connection conn = DriverManager.getConnection(CONN_URL, CONN_ACCOUNT, CONN_PASSWORD);
				PreparedStatement pstmt = conn.prepareStatement(QUERY_ALL_SQL);) {
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Map<String, String> carMap = new HashMap<>();
				carMap.put("MANUFACTURER", rs.getString("MANUFACTURER"));
				carMap.put("TYPE", rs.getString("TYPE"));
				carMap.put("MIN_PRICE", rs.getString("MIN_PRICE"));
				carMap.put("PRICE", rs.getString("PRICE"));
				carList.add(carMap);
			}
			for (Map<String, String> map : carList) {
				if (!map.isEmpty()) {
					sb.append("製造商：").append(map.get("MANUFACTURER")).append("，型號：").append(map.get("TYPE"))
							.append("，售價：$").append(map.get("PRICE")).append("，底價：$").append(map.get("MIN_PRICE"));
				}
				System.out.println(sb.toString());
				sb.setLength(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		// 第三部分
		do {
			reset = false;
			System.out.println("請選擇以下指令輸入：select、insert、update、delete");
			String command = scanner.next();
			switch (command) {
			case "select":
				reset = query(customImport("製造商", scanner), customImport("型號", scanner));
				break;
			case "insert":
				reset = insert(customImport("製造商", scanner), customImport("型號", scanner), customImport("底價", scanner),
						customImport("售價", scanner));
				break;
			case "update":
				reset = update(customImport("製造商", scanner), customImport("型號", scanner), customImport("底價", scanner),
						customImport("售價", scanner));
				break;
			case "delete":
				reset = delete(customImport("製造商", scanner), customImport("型號", scanner));
				break;
			default:
				System.out.println("輸入錯誤，請重新輸入");
				reset = true;
				break;
			}
		} while (reset);
		scanner.close();
	}

	private static boolean query(String set1, String set2) {
		try (Connection conn = DriverManager.getConnection(CONN_URL, CONN_ACCOUNT, CONN_PASSWORD);
				PreparedStatement pstmt = conn.prepareStatement(QUERY_SQL);) {
			pstmt.setString(1, set1);
			pstmt.setString(2, set2);
			ResultSet rs = pstmt.executeQuery();
			StringBuilder sb = new StringBuilder();
			if (rs.next()) {
				sb.append("查詢結果：\n").append("製造商：").append(rs.getString("MANUFACTURER")).append("，型號：")
						.append(rs.getString("TYPE")).append("，售價：").append(rs.getString("PRICE")).append("，底價：")
						.append(rs.getString("MIN_PRICE"));
			} else {
				System.out.println("查詢失敗，找不到對應的製造商與類型");
				return true;
			}
			System.out.println(sb.toString());
		} catch (Exception e) {
			System.out.println("查詢失敗，原因：" + e.getMessage());
			e.printStackTrace();
		}
		return false;
	}

	private static boolean insert(String set1, String set2, String set3, String set4) {
		PreparedStatement pstmt = null;
		try (Connection conn = DriverManager.getConnection(CONN_URL, CONN_ACCOUNT, CONN_PASSWORD);) {
			try {
				conn.setAutoCommit(false);
				pstmt = conn.prepareStatement(INSERT_SQL);
				pstmt.setString(1, set1);
				pstmt.setString(2, set2);
				pstmt.setString(3, set3);
				pstmt.setString(4, set4);
				pstmt.executeUpdate();
				conn.commit();
				System.out.println("新增成功");
				return false;
			} catch (Exception e) {
				System.out.print("新增失敗，原因：" + e.getMessage());
				try {
					conn.rollback();
					System.out.println("rollback 成功");
				} catch (SQLException sqle) {
					System.out.println("rollback 失敗，原因：" + sqle.getMessage());
				}
			}
		} catch (SQLException sqle) {
			sqle.printStackTrace();
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return true;
	}

	private static boolean update(String set1, String set2, String set3, String set4) {
		PreparedStatement pstmt = null;
		try (Connection conn = DriverManager.getConnection(CONN_URL, CONN_ACCOUNT, CONN_PASSWORD);) {
			try {
				conn.setAutoCommit(false);
				pstmt = conn.prepareStatement(UPDATE_SQL);
				pstmt.setString(1, set3);
				pstmt.setString(2, set4);
				pstmt.setString(3, set1);
				pstmt.setString(4, set2);
				conn.commit();
				if (pstmt.executeUpdate() < 1) {
					System.out.println("找不到對應的製造商與類型");
					return true;
				}
				System.out.println("更新成功");
				return false;
			} catch (Exception e) {
				System.out.println("更新失敗，原因：" + e.getMessage());
				try {
					conn.rollback();
					System.out.println("rollback 成功");
				} catch (SQLException sqle) {
					sqle.printStackTrace();
					System.out.println("rollback 失敗，原因：" + sqle.getMessage());
				}
			}
		} catch (SQLException sqle) {
			sqle.printStackTrace();
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return true;
	}

	private static boolean delete(String set1, String set2) {
		PreparedStatement pstmt = null;
		try (Connection conn = DriverManager.getConnection(CONN_URL, CONN_ACCOUNT, CONN_PASSWORD);) {
			try {
				conn.setAutoCommit(false);
				pstmt = conn.prepareStatement(DELETE_SQL);
				pstmt.setString(1, set1);
				pstmt.setString(2, set2);
				conn.commit();
				if (pstmt.executeUpdate() < 1) {
					System.out.println("找不到對應的製造商與類型");
					return true;
				}
				System.out.println("刪除成功");
				return false;
			} catch (Exception e) {
				System.out.println("刪除失敗，原因：" + e.getMessage());
				try {
					conn.rollback();
					System.out.println("rollback 成功");
				} catch (SQLException sqle) {
					System.out.println("rollback 失敗，原因：" + sqle.getMessage());
				}
			}
		} catch (SQLException sqle) {
			sqle.printStackTrace();
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return true;
	}

	private static String customImport(String in, Scanner scanner) {
		System.out.printf("請輸入%s：", in);
		return in = scanner.next();
	}
}
