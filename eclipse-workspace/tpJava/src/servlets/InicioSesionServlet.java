package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;
import javax.servlet.http.HttpSession;
import entidades.Persona;
import logic.ControladorPersona;

@WebServlet("/InicioSesionServlet")
public class InicioSesionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public InicioSesionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("FormularioInicioSesion.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// Busco parámetros del formulario
				String email = request.getParameter("email");
				String password = request.getParameter("password");
				
				//Valido que no sean null
				if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
					response.sendRedirect("FormularioInicioSesion.jsp?error=vacio");
					return;
				}
				
				//Valido con el controlador
				ControladorPersona cp = new ControladorPersona();
				Persona usuario = cp.validarLogin(email, password);
				
				//Si es válido, guardo en sesión y lo redirijo sino vuelvo al login con error
				if (usuario != null) {
					HttpSession session = request.getSession();
					session.setAttribute("usuario", usuario);
					response.sendRedirect("index.jsp");
				} else {
					response.sendRedirect("FormularioInicioSesion.jsp?error=true");
				}
		}

}
