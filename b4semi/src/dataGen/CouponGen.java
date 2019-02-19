package dataGen;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

public class CouponGen {
	
	public static ArrayList<String> createCoupon(Connection cn)
	{
		ArrayList<String> list = new ArrayList<String> ();
		
		String sql = "INSERT INTO COUPONMASTER VALUES (?,?,?,?,?)";
		PreparedStatement ps = null;
		String code;
		
		try {
			
		ps=cn.prepareStatement(sql);
		
		//쿠폰코드, 쿠폰명, 쿠폰할인율, 최소주문금액, 최대할인금액
		
		code="NEW-0.1-5000";
		ps.setString(1,code);
		ps.setString(2,"신규가입쿠폰");
		ps.setDouble(3,0.1);
		ps.setInt(4,10000);
		ps.setInt(5,5000);
		ps.executeUpdate();
		list.add(code);
		
		code="SHIP-FREE";
		ps.setString(1,code);
		ps.setString(2,"배송비 무료 쿠폰");
		ps.setDouble(3,0);
		ps.setInt(4,5000);
		ps.setInt(5,0);
		ps.executeUpdate();
		list.add(code);
		
		code="SHIP-FREE";
		ps.setString(1,code);
		ps.setString(2,"5000원 할인 쿠폰");
		ps.setDouble(3,0);
		ps.setInt(4,5000);
		ps.setInt(5,0);
		ps.executeUpdate();
		list.add(code);
		
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			try{
				ps.close();
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
		}
		return list;
	}

}