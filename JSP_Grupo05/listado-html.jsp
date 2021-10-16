<%@page import="java.util.*,java.sql.*,net.ucanaccess.jdbc.*" contentType="text/html" pageEncoding="utf-8"%><!DOCTYPE>
<html>
<head>
    <title>LIBROS</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="author" content="Miguel Angel Amaya Rodriguez">
    <meta name="author" content="Christian Javier Ayala Guerra">
    <meta name="author" content="Diego José Ayala Guerra">
    <meta name="author" content="Luis Alonso Cornejo Jiménez">
    <meta name="author" content="Carolina Isabel Pineda Delgado">
    <meta name="author" content="José Gustavo Pineda Delgado">
    <meta name="author" content="William Enrique Vásquez Mancia">
    <meta name="keywords" content="XML, JSP, CSS, HTML, TXT">
    <meta name="description" content=", Guía 52C html">
</head>
<body>
<%
    response.setStatus(200);
    //response.setContentType("application/json");
    String nombreArchivo = "libros.html";
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
    String path = context.getRealPath("/JSP_Grupo05/data");
    Connection conexion = getConnection(path);
    if (!conexion.isClosed()){
        String isbn ="", titulo ="", autor= "",editorial= "",anio= "", sentencia="";
        sentencia = "select * from libros";
        Statement st = conexion.createStatement();
        ResultSet rs = st.executeQuery(sentencia);
%><table>
    <tr>
        <td>Num.</td>
        <td>ISBN</td>
        <td>Titulo</td>
        <td>Autor</td>
        <td>Editorial</td>
        <td>Anio Publicacion</td>
    </tr><%
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
        <td><%=i%></td>
        <td><%=isbn%></td>
        <td><%=titulo%></td>
        <td><%=autor%></td>
        <td><%=editorial%></td>
        <td><%=anio%></td>
    </tr><%
        i++;
    }
%>
</table>
<%
    // cierre de la conexion
    conexion.close();
    }
%></body>
<html>