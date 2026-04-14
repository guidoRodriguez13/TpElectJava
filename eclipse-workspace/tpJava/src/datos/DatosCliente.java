package datos;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import entidades.Cliente;

public class DatosCliente {

	public Cliente buscar(Cliente c) { //Recibo un Cliente que tenga solo el id
		ResultSet rs = null;
		PreparedStatement stmt = null;
		
		try {
		Cliente cli = null;
		stmt = Conexion.getInstancia().getConnection().prepareStatement("select * from persona where id = ?");
		stmt.setInt(1, c.getIdPersona()); // Asigno al 1er ? el valor (no arranca en 0)
		rs = stmt.executeQuery();
		
		if (rs != null && rs.next()) {
			cli = new Cliente();
			cli.setIdPersona(rs.getInt("id"));
			cli.setNombre(rs.getString("nombre"));
			cli.setApellido(rs.getString("apellido"));
			cli.setDni(rs.getInt("dni"));
			cli.setTelefono(rs.getInt("telefono"));
			cli.setDireccion(rs.getString("direccion"));
			cli.setEmail(rs.getString("email"));
			cli.setEsAdmin(rs.getBoolean("esAdmin"));
			
			}
		return cli;
		
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if (rs != null) rs.close();
				if (stmt != null) stmt.close();
				Conexion.getInstancia().releaseConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public void alta(Cliente c) {
		PreparedStatement stmt = null;
		ResultSet keyRS = null;
		
		try {
			stmt = Conexion.getInstancia().getConnection().prepareStatement(
					"insert into persona(nombre, apellido, dni, telefono, direccion, email, esAdmin, password) "
					+ "values(?,?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
			// Si el orden es diferente en la bd, no importa 
			//roundtriptime ida y vuelta hasta la bd
			stmt.setString(1, c.getNombre());
			stmt.setString(2, c.getApellido());
			stmt.setInt(3, c.getDni());
			stmt.setLong(4, c.getTelefono());
			stmt.setString(5, c.getDireccion());
			stmt.setString(6, c.getEmail());
			stmt.setBoolean(7, c.isEsAdmin());
			stmt.setString(8, c.getPassword());
		
			stmt.executeUpdate(); //devuelve la cantidad de filas actualizadas
			keyRS = stmt.getGeneratedKeys();
			
			if(keyRS != null && keyRS.next()) {
				c.setIdPersona(keyRS.getInt(1));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();				
		} finally {
			try {
				if (keyRS != null) keyRS.close();
				if (stmt != null) stmt.close();
				Conexion.getInstancia().releaseConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}		
	}	
}
