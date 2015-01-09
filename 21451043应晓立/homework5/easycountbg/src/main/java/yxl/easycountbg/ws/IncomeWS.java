package yxl.easycountbg.ws;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import yxl.easycountbg.dao.EasyCountDao;
import yxl.easycountbg.model.Record;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

@RestController
public class IncomeWS {
	
	@RequestMapping(value="/income/listbyday")
	public @ResponseBody String getIncomeList(@RequestParam(value="username",required=true) String username,
			@RequestParam(value="year",required=true) int year,
			@RequestParam(value="month",required=true) int month,
			@RequestParam(value="day",required=true) int day) {
		String sqlString="select * from income where username='"+username+"' and year="+year+" and month="+month+" and day="+day;
		System.out.println(sqlString);
		Connection connection=EasyCountDao.getEasyCountDBConnection();
		ResultSet resultSet=EasyCountDao.excuteQueryOper(sqlString, connection);
		JSONArray recordJsonArray=new JSONArray();
		try {
			while(resultSet.next()) {
				Map<String, Object> map=new HashMap<String, Object>();
				map.put("id", resultSet.getInt("id"));
				map.put("accountType",resultSet.getInt("accountType"));
				map.put("addTime",resultSet.getString("addTime"));
				map.put("day",resultSet.getInt("day"));
				map.put("des",resultSet.getString("des"));
				map.put("money",resultSet.getFloat("money"));
				map.put("month",resultSet.getInt("month"));
				map.put("type",resultSet.getInt("type"));
				map.put("username",resultSet.getString("username"));
				map.put("year",resultSet.getInt("year"));
				recordJsonArray.add(JSON.toJSON(map));
			}
			System.out.println(recordJsonArray.toJSONString());
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		return recordJsonArray.toJSONString();
	}
	
	@RequestMapping(value="/income/add")
	public String addIncomeRecord(@RequestParam(value="record",required=true) String recordStr) {
		System.out.println(recordStr);
		JSONObject recordJsonObject=JSONObject.parseObject(recordStr);
		System.out.println(recordJsonObject);
		Record record=(Record)JSONObject.toJavaObject(recordJsonObject, Record.class);
		String sqlString="insert into income(username,addTime,money,des,type,accountType,year,month,day) values('"
		                  +record.getUsername()+"','"+record.getAddTime()+"',"+record.getMoney()+",'"+record.getDes()+"',"+record.getType()+","+record.getAccountType()+","+record.getYear()+","+record.getMonth()+","+record.getDay()+")";
		Connection connection=EasyCountDao.getEasyCountDBConnection();
		EasyCountDao.excuteOper(sqlString, connection);
		
		String queryString="select * from income order by id desc limit 1 ";
		ResultSet res=EasyCountDao.excuteQueryOper(queryString, connection);
		int id=0;
		try {
			if (res.next()) {
				id=res.getInt("id");
				System.out.println(id);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return String.valueOf(id);
	}
	
	@RequestMapping(value="/income/edit")
	public String editIncomeRecord(@RequestParam(value="record",required=true) String recordStr) {
		System.out.println(recordStr);
		JSONObject recordJsonObject=JSONObject.parseObject(recordStr);
		System.out.println(recordJsonObject);
		Record record=(Record)JSONObject.toJavaObject(recordJsonObject, Record.class);
		String sqlString="update income set money="+record.getMoney()+",des='"+record.getDes()+"',type="+record.getType()+",accountType="+record.getAccountType()+" where id="+record.getId();
		Connection connection=EasyCountDao.getEasyCountDBConnection();
		int res=EasyCountDao.excuteOper(sqlString, connection);
		if (res>0) {
			return "1";
		}
		return "0";
	}
	
	@RequestMapping(value="/income/delete")
	public String deleteIncomeRecord(@RequestParam(value="id",required=true) int id) {
		System.out.println(id);
		String sqlString="delete from income where id="+id;
		Connection connection=EasyCountDao.getEasyCountDBConnection();
		int res=EasyCountDao.excuteOper(sqlString, connection);
		if (res>0) {
			return "1";
		}
		return "0";
	}
	
	@RequestMapping(value="/income/countByYear")
	public @ResponseBody String countByYear(@RequestParam(value="username",required=true) String username,
			@RequestParam(value="year",required=true) int year){
		String sqlString="select type,sum(money) as sum from income where username='"+username+"' and year="+year+" group by type";
		System.out.println(sqlString);
		Connection connection=EasyCountDao.getEasyCountDBConnection();
		ResultSet resultSet=EasyCountDao.excuteQueryOper(sqlString, connection);
		JSONArray recordJsonArray=new JSONArray();
		try {
			while(resultSet.next()) {
				Map<String, Object> map=new HashMap<String, Object>();
				map.put("type", resultSet.getInt("type"));
				map.put("sum",resultSet.getFloat("sum"));
				recordJsonArray.add(JSON.toJSON(map));
			}
			System.out.println(recordJsonArray.toJSONString());
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		return recordJsonArray.toJSONString();
	}
	
	@RequestMapping(value="/income/countByMonth")
	public @ResponseBody String countByMonth(@RequestParam(value="username",required=true) String username,
			@RequestParam(value="year",required=true) int year,
			@RequestParam(value="month",required=true) int month){
		String sqlString="select type,sum(money) as sum from income where username='"+username+"' and year="+year+" and month="+month+" group by type";
		System.out.println(sqlString);
		Connection connection=EasyCountDao.getEasyCountDBConnection();
		ResultSet resultSet=EasyCountDao.excuteQueryOper(sqlString, connection);
		JSONArray recordJsonArray=new JSONArray();
		try {
			while(resultSet.next()) {
				Map<String, Object> map=new HashMap<String, Object>();
				map.put("type", resultSet.getInt("type"));
				map.put("sum",resultSet.getFloat("sum"));
				recordJsonArray.add(JSON.toJSON(map));
			}
			System.out.println(recordJsonArray.toJSONString());
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		return recordJsonArray.toJSONString();
	}
	
	@RequestMapping(value="/income/countByDay")
	public @ResponseBody String countByDay(@RequestParam(value="username",required=true) String username,
			@RequestParam(value="year",required=true) int year,
			@RequestParam(value="month",required=true) int month,
			@RequestParam(value="day",required=true) int day){
		String sqlString="select type,sum(money) as sum from income where username='"+username+"' and year="+year+" and month="+month+" and day="+day+" group by type";
		System.out.println(sqlString);
		Connection connection=EasyCountDao.getEasyCountDBConnection();
		ResultSet resultSet=EasyCountDao.excuteQueryOper(sqlString, connection);
		JSONArray recordJsonArray=new JSONArray();
		try {
			while(resultSet.next()) {
				Map<String, Object> map=new HashMap<String, Object>();
				map.put("type", resultSet.getInt("type"));
				map.put("sum",resultSet.getFloat("sum"));
				recordJsonArray.add(JSON.toJSON(map));
			}
			System.out.println(recordJsonArray.toJSONString());
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		return recordJsonArray.toJSONString();
	}	
}
