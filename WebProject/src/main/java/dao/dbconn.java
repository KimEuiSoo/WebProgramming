package dao;

import dto.Product;
import dto.ProductResponse;
import java.net.*;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.*;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;

public class dbconn {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public dbconn() {
		try {
			String url = "jdbc:mysql://localhost:3306/dyprojectdb";
			String user = "root";
			String password = "1234";

			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, password);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int login(String userID, String userPW) {
		String SQL = "SELECT user_pw FROM Account WHERE user_id = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (rs.getString(1).equals(userPW))
					return 1;
				else
					return 0;
			}
			return -1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}

	public int register(Account user) {
		String SQL = "INSERT INTO Account VALUES(?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPW());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public List<ProductResponse> PhotoList(String orderType) {
		List<ProductResponse> list = new ArrayList<ProductResponse>();
		try {
			String sql = "select * from product ORDER BY register_date DESC;";
			if (orderType.contains("popular"))
				sql = "select * from product ORDER BY hits DESC;";
			pstmt = conn.prepareStatement(sql);
			// 쿼리 생성
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ProductResponse card = new ProductResponse();
				card.setProductName(rs.getString("product_name"));
				Blob image = rs.getBlob("file_name");

				if (image != null) {
					InputStream in = image.getBinaryStream();
					card.setImage(image.getBytes(1, (int) image.length()));
				}
				card.setProductCode(rs.getString("product_code"));
				list.add(card);
			}
			dbclose();
		} catch (Exception e) {
			e.printStackTrace();
			dbclose();
		}
		return list;
	}

	public ProductResponse PhotoCard(String code) {
		ProductResponse card = new ProductResponse();
		try {
			String sql = "select * from product where product_code = '" + code + "';";
			pstmt = conn.prepareStatement(sql);
			// 쿼리 생성
			rs = pstmt.executeQuery();
			if (rs.next()) {
				card.setUserId(rs.getString("user_id"));
				card.setProductName(rs.getString("product_name"));
				card.setImage(rs.getBytes("file_name"));
				card.setDetailInfo(rs.getString("detail_info"));
				card.setProductCode(rs.getString("product_code"));
				card.setRegisterDate(rs.getDate("register_date"));
				card.setHits(rs.getInt("hits"));

				String update = "update product set hits = " + (rs.getInt("hits") + 1) + " Where product_code = '"
						+ code + "';";
				pstmt = conn.prepareStatement(update);
				// 쿼리 생성
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
			dbclose();
		}

		return card;
	}

	public int PhotoCardDownload(String code, HttpServletResponse resp) throws ServletException {
		try {
			String sql = "select file_name, product_name from product where product_code = '" + code + "';";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String filename = rs.getNString("product_name") + ".png";
				Blob image = rs.getBlob("file_name");

				resp.setHeader("Content-Type", "application/octet-stream");
				resp.setHeader("Access-Control-Allow-Origin", "*");
				resp.setHeader("Content-Length", String.valueOf(image.length()));
				resp.setHeader("Cache-Control", "no-store");
				resp.setHeader("Content-disposition",
						"attachment; filename=\"" + URLEncoder.encode(filename, "UTF-8") + "\"");
				ServletOutputStream out = resp.getOutputStream();
				out.write(image.getBytes(1, (int) image.length()));
				out.flush();
				dbclose();
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
			dbclose();
		}
		return -1;
	}

	public int PhotoDelete(String code) {
		try {
			String sql = "Delete from product where product_code = '"+code+"';";
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
			dbclose();
			return 1;
		}catch(Exception e) {
			e.printStackTrace();
			dbclose();
		}
		
		return -1;
	}

	public int productRegister(Product item) {
		String sql = "insert into Product values(?,?,?,?,?,?,?)";
		try {
			File imgfile = new File(item.getFileName());
			FileInputStream fin = new FileInputStream(imgfile);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, item.getUserId());
			pstmt.setString(2, item.getProductCode());
			pstmt.setString(3, item.getProductName());
			pstmt.setString(4, item.getDetailInfo());
			pstmt.setString(5, item.getRegisterDate());
			pstmt.setBinaryStream(6, fin, (int) imgfile.length());
			pstmt.setInt(1, 0);
			pstmt.executeUpdate();
			dbclose();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			dbclose();
		}
		return -1;
	}

	public void dbclose() {
		try {
			if (conn != null)
				conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
