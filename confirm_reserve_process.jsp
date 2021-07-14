<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.connection.DatabaseConnection"%>
<%
	int price = 0;
	int total = 0;
	int total2 = 0;
	int finalTotal;
	int room_no = Integer.parseInt(request.getParameter("room_no"));
	int piece = Integer.parseInt(request.getParameter("piece"));
	int extra_art = Integer.parseInt(request.getParameter("extra_art"));
	Connection con = DatabaseConnection.getConnection();
	Statement statement = con.createStatement();
	ResultSet resultset = statement.executeQuery("SELECT * FROM travel NATURAL JOIN guest NATURAL JOIN room WHERE id='"+ session.getAttribute("travel_id") + "'");
	while (resultset.next()) {
		price = resultset.getInt(17);
		total = price * piece;
		total2 = 800 * extra_art;
		finalTotal = total + total2;
		Statement st = con.createStatement();
		int update = st.executeUpdate("update travel set room_no='" + room_no + "',piece='" + piece+ "',extra_art='" + extra_art + "',bill='" + finalTotal + "',status='OrderIn' where id='"+ session.getAttribute("travel_id") + "'");
		response.sendRedirect("checkin.jsp");
	}
%>