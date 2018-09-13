package Sample;

import java.io.IOException;
import java.io.FileReader;
import java.io.FileWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Testing
 */
/*@WebServlet("/")*/
public class Testing extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("In Get");
		RequestDispatcher view = request.getRequestDispatcher("/index.jsp");
		view.forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		/*
		 * System.out.println("In Post"); System.out.println("File Contents :\n" +
		 * request.getParameter("name"));
		 */
		String text1 = request.getParameter("name");
		String text = java.net.URLDecoder.decode(text1, "UTF-8");
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");

		StringBuffer sb = new StringBuffer("");

		try {
			FileWriter fw = new FileWriter("D://teja.txt");
			fw.write(text);
			fw.close();

			FileReader fr = new FileReader("D://output.txt");
			int i;

			while ((i = fr.read()) != -1) {
				/* System.out.print((char) i); */
				sb.append((char) i);
			}
			fr.close();
			/*
			 * String text11 = java.net.URLDecoder.decode(sb.toString(), "UTF-8");
			 * response.setContentType("text/plain");
			 * response.setCharacterEncoding("UTF-8");
			 */response.getWriter().write(sb.toString());

		} catch (Exception e) {
			System.out.println(e);
		}
		System.out.println("Success...");
	}

}
