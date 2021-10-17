<%@page import="java.util.*, java.sql.*,net.ucanaccess.jdbc.*" contentType="text/csv;application/vnd.ms-excel"%><%
    response.setStatus(200);
    String nombreArchivo = "libros.csv";
    response.setHeader("Content-disposition", "attachment;filename=" + nombreArchivo);
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
        out.println("Num.;ISBN;T�tulo;Autor;Editorial;A�o Publicaci�n");
        int i=1;
        while (rs.next())
        { 
            isbn=rs.getString("isbn");
            titulo=rs.getString("titulo");
            autor=rs.getString("autor");
            editorial=rs.getString("editorial");
            anio=rs.getString("anio");
            out.println(i+";"+isbn+";"+titulo+";"+autor+";"+editorial+";"+anio);
            i++;
        }
        // cierre de la conexion
        conexion.close();
    }
%>
