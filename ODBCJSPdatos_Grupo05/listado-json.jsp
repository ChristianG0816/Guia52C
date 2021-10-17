<%@page import="java.util.*,java.sql.*,net.ucanaccess.jdbc.*" contentType="application/json" pageEncoding="utf-8"%>{<%
    response.setStatus(200);
    //response.setContentType("application/json");
    String nombreArchivo = "libros.json";
    response.setHeader("Content-Disposition", "attachment; filename=" + nombreArchivo);
%><%!
    public Connection getConnection() throws SQLException {
    String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
    String userName="libros",password="books";
    String fullConnectionString = "jdbc:odbc:registro";

    Connection conn = null;
    try{
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
        conn = DriverManager.getConnection(fullConnectionString,userName,password);
    }
    catch (Exception e) {
        System.out.println("Error: " + e);
    }
        return conn;
    }
    %><%
    ServletContext context = request.getServletContext();
    Connection conexion = getConnection();
    if (!conexion.isClosed()){
        String isbn ="", titulo ="", autor= "",editorial= "",anio= "", sentencia="";
        sentencia = "select * from libros";
        Statement st = conexion.createStatement();
        ResultSet rs = st.executeQuery(sentencia);

        int i=1;
        while (rs.next())
        {
            isbn=rs.getString("isbn");
            titulo=rs.getString("titulo");
            autor=rs.getString("autor");
            editorial=rs.getString("editorial");
            anio=rs.getString("anio");
            %>
    "<%=i%>" : {
        "libro": {
            "isbn": "<%=isbn%>",
            "titulo": "<%=titulo%>",
            "autor": "<%=autor%>",
            "editorial": "<%=editorial%>",
            "anio": "<%=anio%>"
        }
    },
<%
            i++;
        }
        // cierre de la conexion
        conexion.close();
    }
%>
}