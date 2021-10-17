<%@page import="java.util.*,java.sql.*,net.ucanaccess.jdbc.*" contentType="application/xml" pageEncoding="utf-8"%><?xml version="1.0" standalone="yes"?>
<?xml-stylesheet type="text/css" href="CSS/style.css" ?>
    <biblioteca>
    <encabezado>
        <tituloP>Mantenimiento de Libros.</tituloP>
    </encabezado>
    <libros><%
    response.setStatus(200);
    String nombreArchivo = "libros.xml";
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
      String isbn ="", titulo ="", autor= "", editorial= "", anio= "", sentencia="";
      sentencia = "select * from libros";
      Statement st = conexion.createStatement();
      ResultSet rs = st.executeQuery(sentencia);
      %>
        <tabla>
            <cabecera>
                <numeros>Num.</numeros>
                <isbns>ISBN</isbns>
                <titulos>Titulo</titulos>
                <autores>Autor</autores>
                <editoriales>Editorial</editoriales>
                <anios>Año Publicación</anios>
            </cabecera><%
   int i=1;
   while (rs.next())
      {
         isbn=rs.getString("isbn");
         titulo=rs.getString("titulo");
         autor=rs.getString("autor");
         editorial=rs.getString("editorial");
         anio=rs.getString("anio");
          %>
            <libro>
                <numero><%=i%></numero>
                <isbn><%=isbn%></isbn>
                <titulo><%=titulo%></titulo>
                <autor><%=autor%></autor>
                <editorial><%=editorial%></editorial>
                <anio><%=anio%></anio>
            </libro><%
         i++;
      }
   // cierre de la conexion
   conexion.close();
   }
      %>
        </tabla>
    </libros>
</biblioteca>
