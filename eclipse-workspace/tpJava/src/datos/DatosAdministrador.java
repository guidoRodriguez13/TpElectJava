package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;

import entidades.Administrador;
import entidades.Persona;

public class DatosAdministrador {

	public LinkedList<Persona> listar(){
		Statement stmt = null;
		ResultSet rs = null;
				
		try {
		LinkedList<Persona> pers = new LinkedList<>();
		stmt = Conexion.getInstancia().getConnection().createStatement();
		rs = stmt.executeQuery("select * from persona");
		
		while(rs != null && rs.next()) {
			Persona p = new Persona();
			
			p.setIdPersona(rs.getInt("id"));
			p.setNombre(rs.getString("nombre"));
			p.setApellido(rs.getString("apellido"));
			p.setDni(Integer.parseInt(rs.getString("dni")));
			p.setTelefono(Long.parseLong(rs.getString("telefono")));
			p.setDireccion(rs.getString("direccion"));
			p.setEmail(rs.getString("email"));
			p.setEsAdmin(rs.getBoolean("esAdmin"));
			
			pers.add(p);
		}
		
		return pers;
		
		}catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null) rs.close();
				if (stmt != null)
					stmt.close();
					Conexion.getInstancia().releaseConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public Administrador buscar(Administrador a) { //Recibo un admin que tenga solo el id
		ResultSet rs = null;
		PreparedStatement stmt = null;
				
		try {
		Administrador admin = null;
		stmt = Conexion.getInstancia().getConnection().prepareStatement("select * from persona where id = ?");
		stmt.setInt(1, a.getIdPersona()); // Asigno al 1er ? el valor (no arranca en 0)
		rs = stmt.executeQuery();
		
		if (rs != null && rs.next()) {
			admin = new Administrador(); //Creo per aca porque sino encuentra debe devolver null
			admin.setIdPersona(rs.getInt("id"));
			admin.setNombre(rs.getString("nombre"));
			admin.setApellido(rs.getString("apellido"));
			admin.setDni(rs.getInt("dni"));
			admin.setTelefono(rs.getLong("telefono"));
			admin.setDireccion(rs.getString("direccion"));
			admin.setEmail(rs.getString("email"));
			admin.setEsAdmin(rs.getBoolean("esAdmin"));
			
			}
		
		return admin;
		
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if (rs != null) rs.close();
				if (stmt != null)
					stmt.close();
					Conexion.getInstancia().releaseConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void alta(Persona p) {
		PreparedStatement stmt = null;
		ResultSet keyRS = null;
	  		
		try {
			stmt = Conexion.getInstancia().getConnection().prepareStatement(
					"insert into persona(nombre, apellido, dni, telefono, direccion, email, esAdmin) "
					+ "values(?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
			// Si el orden es diferente en la bd, no importa 
			//roundtriptime ida y vuelta hasta la bd
			stmt.setString(1, p.getNombre());
			stmt.setString(2, p.getApellido());
			stmt.setInt(3, p.getDni());
			stmt.setLong(4, p.getTelefono());
			stmt.setString(5, p.getDireccion());
			stmt.setString(6, p.getEmail());
			stmt.setBoolean(7, p.isEsAdmin());
		
			stmt.executeUpdate(); //devuelve la cantidad de filas actualizadas
			keyRS = stmt.getGeneratedKeys();
			
			if(keyRS != null && keyRS.next()) {
				p.setIdPersona(keyRS.getInt(1));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();				
		} finally {
			try {
				if (keyRS != null) keyRS.close();
				if (stmt != null)
					stmt.close();
					Conexion.getInstancia().releaseConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void baja(Persona p) {
		PreparedStatement stmt = null;
	  		
		try {
			stmt = Conexion.getInstancia().getConnection().prepareStatement("select * from persona where id = ?");
			
			stmt.setString(2, p.getNombre());
			stmt.setString(3, p.getApellido());
			stmt.setInt(4, p.getDni());
			stmt.setLong(5, p.getTelefono());
			stmt.setString(6, p.getDireccion());
			stmt.setString(7, p.getEmail());
			stmt.setBoolean(8, p.isEsAdmin());
			
			stmt.executeUpdate(); //mod a los datos
			
		} catch (SQLException e) {
			e.printStackTrace();				
		} finally {
			try {
				if (stmt != null)
					stmt.close();
					Conexion.getInstancia().releaseConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void update(Persona p) {
		PreparedStatement stmt = null;
		  		
		try {
			stmt = Conexion.getInstancia().getConnection().prepareStatement("update persona set nombre = ?, apellido = ?,"
					+ "dni = ?" + ", telefono = ?, direccion = ?, email = ?,"
					+ "esAdmin = ? where id = ?");
			
			stmt.setString(1, p.getNombre());
			stmt.setString(2, p.getApellido());
			stmt.setInt(3, p.getDni());
			stmt.setLong(4, p.getTelefono());
			stmt.setString(5, p.getDireccion());
			stmt.setString(6, p.getEmail());
			stmt.setBoolean(7, p.isEsAdmin());
			stmt.setInt(8, p.getIdPersona());
		
			stmt.executeUpdate(); //mod a los datos
			
		} catch (SQLException e) {
			e.printStackTrace();				
		} finally {
			try {
				if (stmt != null) 
					stmt.close();
					Conexion.getInstancia().releaseConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
