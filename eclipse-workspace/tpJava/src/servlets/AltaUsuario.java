package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

import entidades.Cliente;
import entidades.Persona;
import logic.ControladorCliente;
import logic.ControladorPersona;

@WebServlet("/AltaUsuario")
public class AltaUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AltaUsuario() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Persona per = new Persona();
		Persona p = new Persona();
		ControladorPersona cp = new ControladorPersona();
		per.setDni(Integer.parseInt(request.getParameter("dni")));
		
		per = cp.getByDni(per);
		
		if ( per == null ) {
			p.setNombre(request.getParameter("nombre"));
			p.setApellido(request.getParameter("apellido"));
			p.setDireccion(request.getParameter("direccion"));
			p.setDni(Integer.parseInt(request.getParameter("dni")));
			p.setTelefono(Long.parseLong(request.getParameter("telefono")));
			p.setEmail(request.getParameter("email"));
			//p.setPassword(request.getParameter("password"));
			
			//Hash para la contraseña del usuario y posterior guardado
			String passwordPlana = request.getParameter("password");
			String passwordHasheada = BCrypt.hashpw(passwordPlana, BCrypt.gensalt());
			p.setPassword(passwordHasheada);
			
			p.setEsAdmin(false);
			
			cp.alta(p);
		}else {
			p = null;
		}
		HttpSession misession = request.getSession();
		misession.setAttribute("p", p);
		
		response.sendRedirect("UsuarioAgregado.jsp");
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String apellido = request.getParameter("apellido");
		String dni = request.getParameter("dni");
		String nombre = request.getParameter("nombre");
		String telefono = request.getParameter("telefono");
		String email = request.getParameter("email");
		String direccion = request.getParameter("direccion");
		String contraseña = request.getParameter("password");
		
		doGet(request, response);
	}

}
