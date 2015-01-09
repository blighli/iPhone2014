package yxl.easycountbg.ws;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import yxl.easycountbg.dao.EasyCountDao;

@RestController
public class UserInfoWS {
	
	@RequestMapping(value="/log")
	public @ResponseBody String findPwdByName(@RequestParam(value="username",required=true) String username) {
		String sqlString="select * from userinfo where username='"+username+"'";
		Connection connection=EasyCountDao.getEasyCountDBConnection();
		ResultSet resultSet=EasyCountDao.excuteQueryOper(sqlString,connection);
		String pwd="";
		try {
			if (resultSet.next()) {
				pwd=resultSet.getString("password");
			}
			resultSet.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return pwd;
	}
	
	@RequestMapping(value="/reg")
	public int regUser(@RequestParam(value="username",required=true) String username,
			@RequestParam(value="password",required=true) String password) {
		String userSqlString="insert into userinfo(username,password) values('"+username+"','"+password+"')";
	    Connection connection=EasyCountDao.getEasyCountDBConnection();
		int res=EasyCountDao.excuteOper(userSqlString,connection);
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}
	
	@RequestMapping(value="/updatePwd")
	public int updatePwd(@RequestParam(value="username",required=true) String username,
			@RequestParam(value="password",required=true) String password) {
		String userSqlString="update userinfo set password='"+password+"' where username='"+username+"'";
	    Connection connection=EasyCountDao.getEasyCountDBConnection();
		int res=EasyCountDao.excuteOper(userSqlString,connection);
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println(res);
		return res;
	}
}
