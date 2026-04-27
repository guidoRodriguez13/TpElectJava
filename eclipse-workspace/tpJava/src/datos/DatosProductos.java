package datos;

import java.sql.Connection;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedList;

import entidades.Categoria;
import entidades.Marca;
import entidades.Persona;
import entidades.Producto;

public class DatosProductos {

	public LinkedList<Producto> listar() {
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			LinkedList<Producto> prods = new LinkedList<>();
			stmt = Conexion.getInstancia().getConnection().prepareStatement("SELECT p.idProducto , p.descripcion ,"
					+ " p.nombre , p.precio , p.stock , p.idMarca , m.nombreMarca AS nombreMarca ,"
					+ " p.idCategoria , c.nombreCat AS nombreCat from producto p"
					+ " JOIN marca m ON p.idMarca = m.idMarca "
					+ " JOIN categoria c ON p.idCategoria = c.idCategoria ");
			rs = stmt.executeQuery();

			while (rs != null && rs.next()) {
				Producto p = new Producto();
				Marca m = new Marca();
				Categoria c = new Categoria();

				p.setIdProducto(rs.getInt("idProducto"));
				p.setDescripcion(rs.getString("descripcion"));
				p.setNombre(rs.getString("nombre"));
				p.setPrecio(rs.getInt("precio"));
				p.setStock(rs.getInt("stock"));
				
				m.setIdMarca(rs.getInt("idMarca"));
				m.setNombre(rs.getString("nombreMarca"));

				c.setIdCategoria(rs.getInt("idCategoria"));
				c.setNombre(rs.getString("nombreCat"));
				
				p.setBrand(m);
				p.setCat(c);
				
				prods.add(p);
			}

			return prods;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null) rs.close();
				if (stmt != null) {
					stmt.close();
					Conexion.getInstancia().releaseConnection();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public Producto buscar(Producto p) { // Recibo un producto que tenga solo el idProducto
		ResultSet rs = null;
		PreparedStatement stmt = null;

		try {
			Producto prod = null;
			Marca m = new Marca();
			Categoria c = new Categoria();
			
			stmt = Conexion.getInstancia().getConnection().prepareStatement("SELECT p.idProducto , p.descripcion ,"
					+ " p.nombre , p.precio , p.stock , p.idMarca , m.nombreMarca AS nombreMarca ,"
					+ " p.idCategoria , c.nombreCat AS nombreCat from producto p "
					+ " JOIN marca m ON p.idMarca = m.idMarca "
					+ " JOIN categoria c ON p.idCategoria = c.idCategoria "
					+ " where idProducto = ?");
			
			stmt.setInt(1, p.getIdProducto()); // Asigno al 1er ? el valor (no arranca en 0)
			rs = stmt.executeQuery();

			if (rs != null && rs.next()) { //Consulta rs.next() no deberia estar?
				prod = new Producto(); // Creo aca porque sino encuentra debe devolver null
				prod.setIdProducto(rs.getInt("idProducto"));
				prod.setDescripcion(rs.getString("descripcion"));
				prod.setNombre(rs.getString("nombre"));
				prod.setPrecio(rs.getInt("precio"));
				prod.setStock(rs.getInt("stock"));

				m.setIdMarca(rs.getInt("idMarca"));
				m.setNombre(rs.getString("nombreMarca"));

				c.setIdCategoria(rs.getInt("idCategoria"));
				c.setNombre(rs.getString("nombreCat"));
								
				prod.setBrand(m);
				prod.setCat(c);
			}

			return prod;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			  try {
				  if (rs != null) rs.close();
				  if (stmt != null)
					  stmt.close();
				  	  Conexion.getInstancia().releaseConnection();
			} catch (SQLException e){
				e.printStackTrace();
			}	 
		}
	}

	public void alta(Producto p) {
		
		PreparedStatement stmt = null;
		ResultSet keyRS = null;
		
		try {
			stmt = Conexion.getInstancia().getConnection().prepareStatement(
					"insert into producto(nombre, descripcion, precio, stock, idMarca, idCategoria) " + "values(?,?,?,?,?,?)",
					Statement.RETURN_GENERATED_KEYS);
			// Si el orden es diferente en la bd, no importa
			// roundtriptime ida y vuelta hasta la bd
			stmt.setString(1, p.getNombre());
			stmt.setString(2, p.getDescripcion());
			stmt.setInt(3, p.getPrecio());
			stmt.setInt(4, p.getStock());
			stmt.setInt(5, p.getBrand().getIdMarca());
			stmt.setInt(6, p.getCat().getIdCategoria());

			stmt.executeUpdate(); // devuelve la cantidad de filas actualizadas
			keyRS = stmt.getGeneratedKeys();

			if (keyRS != null && keyRS.next()) {
				p.setIdProducto(keyRS.getInt(1));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally
		{try {
				if (keyRS != null) keyRS.close();
				if (stmt != null)
					stmt.close();
					Conexion.getInstancia().releaseConnection();
			  } catch (SQLException e) {
				  e.printStackTrace();
			  }	 
		}
	}

	public void baja(Producto p) {
		PreparedStatement stmt = null;

		Connection conn = Conexion.getInstancia().getConnection();

		try {
			stmt = conn.prepareStatement("DELETE from producto where idProducto = ?");

			stmt.setInt(1, p.getIdProducto());

			stmt.executeUpdate(); // mod a los datos

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {			
			try {
				if (stmt != null)
					stmt.close();
					Conexion.getInstancia().releaseConnection();
			 } catch (SQLException e) { e.printStackTrace();
			 }	 
		}
	}

	public void update(Producto p) {
		PreparedStatement stmt = null;

		try {
			stmt = Conexion.getInstancia().getConnection().prepareStatement(
					"UPDATE producto SET nombre = ?, descripcion = ?, precio = ?, stock = ?, idmarca = ?, idcategoria = ? where idProducto = ?");

			stmt.setString(1, p.getNombre());
			stmt.setString(2, p.getDescripcion());
			stmt.setInt(3, p.getPrecio());
			stmt.setInt(4, p.getStock());
			stmt.setInt(5, p.getBrand().getIdMarca());
			stmt.setInt(6, p.getCat().getIdCategoria());
			stmt.setInt(7, p.getIdProducto());

			stmt.executeUpdate(); // mod a los datos

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null)
					stmt.close();
					Conexion.getInstancia().releaseConnection();			 
			 } catch (SQLException e) { e.printStackTrace();
			 }	 
		}
	}
	
	public void updatePorCompra(int cant, int id) {
		System.out.println("entre al update");
		PreparedStatement stmt = null;

		try {
			stmt = Conexion.getInstancia().getConnection().prepareStatement(
					"UPDATE producto SET stock = stock-? WHERE idProducto = ?");

			stmt.setInt(1, cant); // Restar la cantidad vendida al stock
		    stmt.setInt(2, id);   // ID del producto

			stmt.executeUpdate(); // mod a los datos
			System.out.println("reste: "+cant+" al producto "+id);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null)
					stmt.close();
					Conexion.getInstancia().releaseConnection();			 
			 } catch (SQLException e) { e.printStackTrace();
			 }	 
		}
	}
	
	public LinkedList<Producto> listadoPorPrecioA() {
		Statement stmt = null;
		ResultSet rs = null;
		
		Connection conn = Conexion.getInstancia().getConnection();
		
		try {
			LinkedList<Producto> prods = new LinkedList<>();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT p.idProducto , p.descripcion , p.nombre , p.precio , p.stock , p.idMarca , m.nombreMarca AS nombreMarca , p.idCategoria , c.nombreCat AS nombreCat "
					+ " FROM producto p "
					+ " JOIN marca m ON p.idMarca = m.idMarca "
					+ " JOIN categoria c ON p.idCategoria = c.idCategoria "
					+ " ORDER BY precio ASC");
			//INCLUYO ASC EN LA CONSULTA PARA QUE SE ENTIENDA MEJOR ( VALOR DEFAULT )
			while (rs != null && rs.next()) {
				Producto p = new Producto();
				Marca m = new Marca();
				Categoria c = new Categoria();

				p.setIdProducto(rs.getInt("idProducto"));
				p.setDescripcion(rs.getString("descripcion"));
				p.setNombre(rs.getString("nombre"));
				p.setPrecio(rs.getInt("precio"));
				p.setStock(rs.getInt("stock"));
				
				m.setIdMarca(rs.getInt("idMarca"));
				m.setNombre(rs.getString("nombreMarca"));
				
				c.setIdCategoria(rs.getInt("idCategoria"));
				c.setNombre(rs.getString("nombreCat"));

				p.setBrand(m);
				p.setCat(c);
				
				prods.add(p);
			}

			return prods;
			
	} catch (SQLException e) {
		e.printStackTrace();
		return null;
	} finally {
		  try {
			  if (rs != null) rs.close();
			  if (stmt != null)
				  stmt.close();
			  	  Conexion.getInstancia().releaseConnection();
		} catch (SQLException e){
			e.printStackTrace();
		}	 
	}
}
	public LinkedList<Producto> listadoPorPrecioD() {
		Statement stmt = null;
		ResultSet rs = null;
		
		Connection conn = Conexion.getInstancia().getConnection();
		
		try {
			LinkedList<Producto> prods = new LinkedList<>();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT p.idProducto , p.descripcion , p.nombre , p.precio , p.stock , p.idMarca , m.nombreMarca AS nombreMarca , p.idCategoria , c.nombreCat AS nombreCat "
					+ " FROM producto p "
					+ " JOIN marca m ON p.idMarca = m.idMarca "
					+ " JOIN categoria c ON p.idCategoria = c.idCategoria "
					+ " ORDER BY precio DESC");
			
			while (rs != null && rs.next()) {
				Producto p = new Producto();
				Marca m = new Marca();
				Categoria c = new Categoria();

				p.setIdProducto(rs.getInt("idProducto"));
				p.setDescripcion(rs.getString("descripcion"));
				p.setNombre(rs.getString("nombre"));
				p.setPrecio(rs.getInt("precio"));
				p.setStock(rs.getInt("stock"));
				
				m.setIdMarca(rs.getInt("idMarca"));
				m.setNombre(rs.getString("nombreMarca"));
				
				c.setIdCategoria(rs.getInt("idCategoria"));
				c.setNombre(rs.getString("nombreCat"));

				p.setBrand(m);
				p.setCat(c);

				prods.add(p);
			}

			return prods;
	} catch (SQLException e) {
		e.printStackTrace();
		return null;
	} finally {
		  try {
			  if (rs != null) rs.close();
			  if (stmt != null) 
				  stmt.close();
			  	  Conexion.getInstancia().releaseConnection();
		} catch (SQLException e){
			e.printStackTrace();
		}	 
	}
}

	public LinkedList<Producto> getByCategoria(Categoria c) {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			LinkedList<Producto> prods = new LinkedList<>();			
			stmt = Conexion.getInstancia().getConnection().prepareStatement("SELECT p.idProducto , p.descripcion ,"
			+ " p.nombre , p.precio , p.stock , p.idMarca , m.nombreMarca AS nombreMarca ,"
			+ " p.idCategoria , c.nombreCat AS nombreCat from producto p "
			+ " JOIN marca m ON p.idMarca = m.idMarca "
			+ " JOIN categoria c ON p.idCategoria = c.idCategoria "
			+ " where p.idCategoria = ?");			
			
			stmt.setInt(1, c.getIdCategoria());
			rs = stmt.executeQuery();
			
			while (rs != null && rs.next()) {
				Producto p = new Producto();
				Marca m = new Marca();
				Categoria cat = new Categoria();

				p.setIdProducto(rs.getInt("idProducto"));
				p.setDescripcion(rs.getString("descripcion"));
				p.setNombre(rs.getString("nombre"));
				p.setPrecio(rs.getInt("precio"));
				p.setStock(rs.getInt("stock"));
				
				m.setIdMarca(rs.getInt("idMarca"));
				m.setNombre(rs.getString("nombreMarca"));

				cat.setIdCategoria(rs.getInt("idCategoria"));
				cat.setNombre(rs.getString("nombreCat"));
				
				p.setBrand(m);
				p.setCat(cat);
				
				prods.add(p);
			}

			return prods;
			
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null) rs.close();
				if (stmt != null) stmt.close();
				Conexion.getInstancia().releaseConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	//NUEVA FUNCION
	public List<Producto> getProductosDestacados() {
	    List<Producto> lista = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    Conexion conexion = Conexion.getInstancia();
	    
	    try {
	        conn = conexion.getConnection();
	        if (conn == null) return lista;
	        
	        // Podés definir qué productos son "destacados"
	        // Ejemplo: los últimos 4 productos agregados
	        String sql = "SELECT * FROM producto ASC LIMIT 3";
	        stmt = conn.prepareStatement(sql);
	        rs = stmt.executeQuery();
	        
	        while (rs.next()) {
	            Producto p = new Producto();
	            p.setIdProducto(rs.getInt("idProducto"));
	            p.setNombre(rs.getString("nombre"));
	            p.setDescripcion(rs.getString("descripcion"));
	            p.setPrecio(rs.getInt("precio"));
	            // ... otros campos
	            lista.add(p);
	        }
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (stmt != null) stmt.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        conexion.releaseConnection();
	    }
	    return lista;
	}
	
	public List<Producto> buscarAvanzado(int idCategoria, double precioMin, double precioMax) {
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    List<Producto> lista = new ArrayList<>();
	    
	    try { //Consulta a la BD para traer el filtro complejo
	    	if (idCategoria > 0) {
	    		stmt = Conexion.getInstancia().getConnection().prepareStatement(
	    			  "SELECT p.idProducto, p.descripcion, p.nombre, p.precio, p.stock, " +
	    	          "p.idMarca, m.nombreMarca AS nombreMarca, " +
	    	          "p.idCategoria, c.nombreCat AS nombreCat " +
	    	          "FROM producto p " +
	    	          "JOIN marca m ON p.idMarca = m.idMarca " +
	    	          "JOIN categoria c ON p.idCategoria = c.idCategoria " +
	    	          "WHERE p.idCategoria = ? AND p.precio >= ? AND p.precio <= ?");
	    	    
	    	    stmt.setInt(1, idCategoria);
	    	    stmt.setDouble(2, precioMin);
	    	    stmt.setDouble(3, precioMax);
	    	} else { //si categoria = 0
	    		stmt = Conexion.getInstancia().getConnection().prepareStatement(
	    	    	  "SELECT p.idProducto, p.descripcion, p.nombre, p.precio, p.stock, " +
	    	          "p.idMarca, m.nombreMarca AS nombreMarca, " +
	    	          "p.idCategoria, c.nombreCat AS nombreCat " +
	    	          "FROM producto p " +
	    	          "JOIN marca m ON p.idMarca = m.idMarca " +
	    	          "JOIN categoria c ON p.idCategoria = c.idCategoria " +
	    	          "WHERE p.precio >= ? AND p.precio <= ?");
	    	    
	    	    stmt.setDouble(1, precioMin);
	    	    stmt.setDouble(2, precioMax);
	    	}
	        
	        rs = stmt.executeQuery();
	        
	        while (rs.next()) {
	            Producto p = new Producto();
	            Marca m = new Marca();
	            Categoria c = new Categoria();
	            //Atribs del producto.
	            p.setIdProducto(rs.getInt("idProducto"));
	            p.setDescripcion(rs.getString("descripcion"));
	            p.setNombre(rs.getString("nombre"));
	            p.setPrecio(rs.getInt("precio"));
	            p.setStock(rs.getInt("stock"));
	            //Atribs de la marca
	            m.setIdMarca(rs.getInt("idMarca"));
	            m.setNombre(rs.getString("nombreMarca"));
	            //Atribs de la categoria
	            c.setIdCategoria(rs.getInt("idCategoria"));
	            c.setNombre(rs.getString("nombreCat"));
	            
	            p.setBrand(m);
	            p.setCat(c);
	            
	            lista.add(p);
	        }
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (stmt != null) stmt.close();
	            Conexion.getInstancia().releaseConnection();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    return lista;
	}
}
