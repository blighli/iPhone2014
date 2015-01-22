package yxl.easycountbg.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class EasyCountDao {

	public static Connection getEasyCountDBConnection() {
		String driver = "com.mysql.jdbc.Driver";
        String url = "jdbc:mysql://127.0.0.1:3306/easycount";
        String user = "root"; 
        String password = "root";
        Connection conn = null;

        try { 
        	Class.forName(driver);
        	conn = DriverManager.getConnection(url, user, password);

        	if(!conn.isClosed()) {
        		System.out.println("Succeeded connecting to the Database!");
        	}
        }catch (Exception ex){
        	ex.printStackTrace();
        }
        return conn;
	}
	
	public static ResultSet excuteQueryOper(String sql, Connection conn) {
		Statement statement;
		ResultSet rs=null;
		try {
			statement = conn.createStatement();
			rs = statement.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	return rs;
	}
	
	public static int excuteOper(String sql,Connection conn) {
		Statement statement;
		int res=0;
		try {
			statement=conn.createStatement();
			res=statement.executeUpdate(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}
}
