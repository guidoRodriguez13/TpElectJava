package datos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

	private String controladorBD = "com.mysql.cj.jdbc.Driver";
	private static String anfitrion = "localhost";
	private static String puerto = "3306";
	private static String usuario = "root";
	private static String contrasena = "admin";
	private static String tipoBD = "mysql";
	private static String bd = "tpjava";

	private static Conexion instancia;
	private Connection conn;
	private int conexiones = 0;

	private Conexion(){
		try {
			Class.forName(controladorBD);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();		
		}
	}

	public static Conexion getInstancia() {
		if (instancia == null) {
			instancia = new Conexion();
		}
		return instancia;
	}
	
	public Connection getConnection() {
	    try {
	        if (conn == null || conn.isClosed()) {
	            conn = DriverManager.getConnection("jdbc:mysql://" + anfitrion + ":" + puerto + "/" + bd, usuario, contrasena);
	            conexiones++;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return conn;
	}

	public void releaseConnection(){
		try {
			conexiones--;
			if (conexiones<=0) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}