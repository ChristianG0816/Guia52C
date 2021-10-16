<%@page import="java.util.*,java.sql.*,net.ucanaccess.jdbc.*"%>
<%@page contentType="application/xml"%>
<%
    response.setStatus(200);
    String nombreArchivo = "libros.txt";
    response.setHeader("Content-Disposition", "attachment; filename=" + nombreArchivo);
%>
<%!
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
%>
<%
ServletContext context = request.getServletContext();
String path = context.getRealPath("/data");
Connection conexion = getConnection(path);
   if (!conexion.isClosed()){
      String isbn ="", titulo ="", autor= "",editorial= "",anio= "", sentencia="";
    sentencia = "select * from libros";
      Statement st = conexion.createStatement();
      ResultSet rs = st.executeQuery(sentencia);
      // Ponemos los resultados en un table de html
      int i=1;
      while (rs.next()){
         isbn=rs.getString("isbn");
         titulo=rs.getString("titulo");
         autor=rs.getString("autor");
         editorial=rs.getString("editorial");
         anio=rs.getString("anio");
         %>   
Numero: <%=i%>
ISBN: <%=isbn%>
Titulo: <%=titulo%>
Actor: <%=autor%>
Editorial: <%=editorial%>
Anio de Publicacion: <%=anio%>    
<%
         i++;
      }
      // cierre de la conexion
      conexion.close();
}
%>
   