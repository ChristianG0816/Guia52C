<%@page import="java.util.*,java.sql.*,net.ucanaccess.jdbc.*" contentType="application/xml"%><%
    response.setStatus(200);
    String nombreArchivo = "libros.txt";
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
      while (rs.next()){
         isbn=rs.getString("isbn");
         titulo=rs.getString("titulo");
         autor=rs.getString("autor");
         editorial=rs.getString("editorial");
         anio=rs.getString("anio");
         
         out.println("N�mero: "+i);
         out.println("ISBN: "+isbn);
         out.println("Titulo: "+titulo);
         out.println("Actor: "+autor);
         out.println("Editorial: "+editorial);
         out.println("A�o de Publicaci�n: : "+anio+"\n");

         i++;
      }
      // cierre de la conexion
      conexion.close();
}
%>
   