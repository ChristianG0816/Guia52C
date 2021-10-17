<%@page import="java.util.*,java.sql.*,net.ucanaccess.jdbc.*" contentType="application/json" pageEncoding="utf-8"%>{<%
    response.setStatus(200);
    //response.setContentType("application/json");
    String nombreArchivo = "libros.json";
    response.setHeader("Content-Disposition", "attachment; filename=" + nombreArchivo);
%><%!
    public Connection getConnection(String path) throws SQLException {
    String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
    String filePath= path+"\\datos.mdb";
    String userName="",password="";
    String fullConnectionString = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=" + filePath;

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
    String path = context.getRealPath("/JSPdatos_Grupo05/data");
    Connection conexion = getConnection(path);
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