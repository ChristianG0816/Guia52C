<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.sql.*" %>
 
<%
/* Paso 1) Obtener los datos del formulario */
String ls_isbn = request.getParameter("isbn");

 
/* Paso 2) Inicializar variables */
String ls_result = "Base de datos actualizada...";
String ls_query = "";
ServletContext context = request.getServletContext();
String path = context.getRealPath("/JSP_Grupo05/data");
String filePath= path+"\\datos.mdb";
String ls_dburl = "jdbc:odbc:Driver={MicroSoft Access Driver (*.mdb)};DBQ="+filePath;
String ls_usuario = "";
String ls_password = "";
String ls_dbdriver = "sun.jdbc.odbc.JdbcOdbcDriver";
 
/* Paso 3) Crear query&nbsp; */


ls_query = " delete from libros where isbn = ";
ls_query += "'" + ls_isbn + "'";

 

/* Paso4) Conexi�n a la base de datos */
Connection l_dbconn = null;
 
try {
Class.forName(ls_dbdriver);
/*&nbsp; getConnection(URL,User,Pw) */
l_dbconn = DriverManager.getConnection(ls_dburl,ls_usuario,ls_password);
 
/*Creaci�n de SQL Statement */
Statement l_statement = l_dbconn.createStatement();
/* Ejecuci�n de SQL Statement */
l_statement.execute(ls_query);
} catch (ClassNotFoundException e) {
ls_result = " Error creando el driver!";
ls_result += " <br/>" + e.toString();
} catch (SQLException e) {
ls_result = " Error procesando el SQL!";
ls_result += " <br/>" + e.toString();
} finally {
/* Cerramos */
try {
if (l_dbconn != null) {
l_dbconn.close();
}
} catch (SQLException e) {
ls_result = "Error al cerrar la conexi�n.";
ls_result += " <br/>" + e.toString();
}
}
%>
<html>
<head><title>Actualizando base</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <meta name="author" content="Miguel Angel Amaya Rodriguez">
    <meta name="author" content="Christian Javier Ayala Guerra">
    <meta name="author" content="Diego José Ayala Guerra">
    <meta name="author" content="Luis Alonso Cornejo Jiménez">
    <meta name="author" content="Carolina Isabel Pineda Delgado">
    <meta name="author" content="José Gustavo Pineda Delgado">
    <meta name="author" content="William Enrique Vásquez Mancia">
    <meta name="keywords" content="JSP, GUIA 52C">
    <meta name="description" content="Guia 52C eliminar.jsp">

    <link rel="stylesheet" href="CSS/libros.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
</head>
<body>
    <h1>ACTUALIZACION DE BASE DE DATOS</h1>
    <section id="mensaje">
        <p class="mensaje">
            La siguiente instruccion fue ejecutada:
        </p>
        <%=ls_query%><br/><br/>
        <p class="mensaje">
            El resultado fue:
        </p>
        <%=ls_result%>
        <br/><br/>
        <a href="libros.jsp" id="enlace" class="btn btn-outline-dark">Volver</a>
    </section>
</body>
</html>