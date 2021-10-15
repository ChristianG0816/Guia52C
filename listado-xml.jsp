<%@page import="java.util.*,java.sql.*,net.ucanaccess.jdbc.*"%>
<%@page contentType="application/xml"%>
<%
   response.setStatus(200);
    String nombreArchivo = "libros.xml";
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
<html>
<head>
<title>Actualizar, Eliminar, Crear registros.</title>
</head>
<body>
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
      out.println("<table border=\"1\">");
      %>
         <tr><td>Num.</td><td>ISBN</td><td>Titulo</td></td><td>Autor</td><td>Editorial</td><td>A�o Publicaci�n</td></tr>
      <%
      int i=1;
      while (rs.next())
      {
         isbn=rs.getString("isbn");
         titulo=rs.getString("titulo");
         autor=rs.getString("autor");
         editorial=rs.getString("editorial");
         anio=rs.getString("anio");
         %>
         <tr>
         <td> <%=i%> </td>
         <td><%=isbn%></td>
         <td><%=titulo%></td>
         <td><%=autor%></td>
         <td><%=editorial%></td>
         <td><%=anio%></td>
         
         </tr>
         <%
         i++;
      }
      out.println("</table>");
      // cierre de la conexion
      conexion.close();
}
%>
 </body>