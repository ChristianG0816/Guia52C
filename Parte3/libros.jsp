<%@page contentType="text/html" pageEncoding="iso-8859-1" import="java.sql.*,net.ucanaccess.jdbc.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Actualizar, Eliminar, Crear registros.</title>

    <meta name="author" content="Miguel Angel Amaya Rodriguez">
    <meta name="author" content="Christian Javier Ayala Guerra">
    <meta name="author" content="Diego José Ayala Guerra">
    <meta name="author" content="Luis Alonso Cornejo Jiménez">
    <meta name="author" content="Carolina Isabel Pineda Delgado">
    <meta name="author" content="José Gustavo Pineda Delgado">
    <meta name="author" content="William Enrique Vásquez Mancia">
    <meta name="keywords" content="JSP, GUIA 52C">
    <meta name="description" content="Guia 52C libros.jsp">

<link rel="stylesheet" href="CSS/libros.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
</head>

<body>
  <h1>MANTENIMIENTO DE LIBROS</h1>
  <section>
    <!--  LOGICA DE CONEXION CON LA BASE DE DATOS -->
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
<!--  LOGICA DE ACTUALIZAR -->
<%
   String varisbn = request.getParameter("isbn");
   String vartitulo = request.getParameter("titulo");
   String varautor = request.getParameter("autor");
   String vareditorial = request.getParameter("editorial");
   String varanio = request.getParameter("anio");
   String varchecked = request.getParameter("checked");
   String varTitulo= request.getParameter("Titulo");
   String varAutor= request.getParameter("Autor");
   String varBuscar = request.getParameter("buscar");
   String actualizar="actualizar";
   //Estos dos son de ordenar
   String va = request.getParameter("var");
   String var = "1";
   if(varisbn==null&&vartitulo==null&&varchecked==null){
      varisbn="";
      vartitulo="";
      varautor="";
      vareditorial="";
      varanio="";
      varchecked="";
   }
%>


<form action="matto.jsp" method="post" name="formActualizar" class="formActualizar">
  <table name="tCampos" class="tCampos">
    <tbody>
      <tr><td colspan="2" class="eDescargas"><label>Descargar<label></td></tr>
      <tr>
        <td><label>ISBN</label><input type="text" Autofocus name="isbn" value="<%=varisbn%>" pattern="[0-9]{13}" required title="Debe ingresar 13 digitos"/></td>
        <td><a href="listado-csv.jsp" download="libros.csv" class="btn btn-outline-dark">Listado CSV</a></td>
      </tr>
      <tr>
        <td><label>Titulo</label><input type="text" name="titulo"  value="<%=vartitulo%>" pattern="[a-zA-Z0-9\,]{0,50}" title="Solo debe ingresar texto y maximo 50 caracteres"/></td>
        <td><a href="listado-txt.jsp" download="libros.txt" class="btn btn-outline-dark">Listado txt</a></td>
      </tr>
      <tr>
        <td><label>Autor</label><input type="text" name="autor" value="<%=varautor%>" pattern="[a-zA-Z\,]{0,50}" title="Solo debe ingresar texto sin acento y maximo 50 caracteres"/></td>
        <td><a href="listado-xml.jsp" download="libros.xml" class="btn btn-outline-dark">Listado XML</a></td>
      </tr>
      <!-- INICIO EJERCICIO 7 -->
      <tr><td><label>Editorial</label><select type="text" name="editorial"/>
          <%
          ServletContext context1 = request.getServletContext();
          String path1 = context1.getRealPath("/Parte3/data");
          Connection conexion1 = getConnection(path1);
            if (!conexion1.isClosed()){
              String a="";
              if(va==null){
                  a = " order by editorial asc";
              }else{
                  a = " order by editorial desc";
              }
              String sentencia1 = "select * from editorial"+a;
              Statement st1 = conexion1.createStatement();
              ResultSet rs1 = st1.executeQuery(sentencia1);
              // Ponemos los resultados en un select de html
              int i=1;
              while (rs1.next()){
                  vareditorial=rs1.getString("editorial");
                  out.println("<option>");
                  %>
                  <%=vareditorial%>
                  <%
                  i++;
              }
              out.println("</option>");
              // cierre de la conexion1
              conexion1.close();
            }
          %></td>
          <td><a href="listado-json.jsp" download="libros.json" class="btn btn-outline-dark">Listado txt</a></td>
      </tr>
      <tr>
      <td><label>Anio de publicacion</label><input type="date" name="anio" class="inputDate" value="<%=varanio%>" min="1000-01-01" max="2021-12-31"/></td>
      <td><a href="listado-html.jsp" download="libros.html" class="btn btn-outline-dark">Listado txt</a></td>
      </tr>
      <!-- FIN EJERCICIO 7 -->
      <tr><td class="rBtn"><label>Action </label>
        <%if(varchecked.equals(actualizar)){%>
          <input type="radio" name="Action" class="radio" value="Actualizar" checked /> Actualizar
          <input type="radio" name="Action" class="radio" value="Eliminar" /> Eliminar
          <input type="radio" name="Action" class="radio" value="Crear"/> Crear
        <%}else{%>
          <input type="radio" name="Action" class="radio" value="Actualizar"/> Actualizar
          <input type="radio" name="Action" class="radio" value="Eliminar" /> Eliminar
          <input type="radio" name="Action" class="radio" value="Crear" checked/> Crear
        <%}%></td>
      </tr>
      <tr><td><input type="SUBMIT" value="ACEPTAR" class="btn btn-outline-dark"/></td></tr>
    </tbody>
  </table>
</form>
<br>
<!-- Formulario -- Ejercicio 3 -->
<form name="formBuscar" class="formBuscar" action="libros.jsp" method="get">
  <table class="tBbusqueda">
    <tbody>
      <tr>
        <td><label>Titulo a buscar</label><input type ="text" name="Titulo" required name ="Titulo" pattern="[a-zA-Z0-9\,]{0,30}" title="Solo debe ingresar texto"/></td>
        <td><label>Autor a buscar </label><input type ="text" name="Autor" required name ="Autor" pattern="[a-zA-Z\,]{0,30}" title="Solo debe ingresar texto sin acento"/></td>
        <td><input type="SUBMIT" name="buscar" value="BUSCAR" class="btn btn-outline-dark"/></td>
      </tr>
    </tbody>
  </table>
  <br>
  <%
  ServletContext context = request.getServletContext();
  String path = context.getRealPath("/Parte3/data");
  System.out.println(path);
  Connection conexion = getConnection(path);
    if (!conexion.isClosed()){
      String isbn ="", titulo ="", autor= "",editorial= "",anio= "", site= ""+request.getRequestURL(), b="", sentencia="";
      //Ejercicio 02
      if(va==null){
        b = " order by titulo desc";
      }
      else{
        b = " order by titulo asc";
      }
      if(varBuscar != null){
        sentencia = "SELECT * FROM libros where titulo = " + "'" + varTitulo + "'" +" OR autor = "  + "'" + varAutor + "'" + b;
      }else{
        sentencia = "select * from libros"+ b;
      }
      Statement st = conexion.createStatement();
      ResultSet rs = st.executeQuery(sentencia);
      // Ponemos los resultados en un table de html
      out.println("<table class=\"table table-striped\">");
      %>
        <thead class="table-dark">
        <tr class="trEncabezado"><td>Num.</td><td>ISBN</td><td><style>#titu{text-decoration: none;color:white;}</style><a href="<%=site%>?var=<%=var%>" id="titu"> Titulo</a></td><td>Autor</td><td>Editorial</td><td>Anio Publicacion</td><td>Accion</td></tr>
        </thead>
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
        <td class="tdNum"> <%=i%> </td>
        <td class="tdIsbn"><%=isbn%></td>
        <td class="tdTitulo"><%=titulo%></td>
        <td class="tdAutor"><%=autor%></td>
        <td class="tEditorial"><%=editorial%></td>
        <td class="tdAnio"><%=anio%></td>
        
        <!--EJERCICIO 4-->
        <td class="tdAccion">
          <a href="<%=site%>?isbn=<%=isbn%>&titulo=<%=titulo%>&autor=<%=autor%>&editorial=<%=editorial%>&anio=<%=anio%>&checked=<%=actualizar%>" class="btn btn-outline-dark">Actualizar</a>
           
          <a href="eliminar.jsp?isbn=<%=isbn%>" class="btn btn-outline-dark">Eliminar</a></td>
        </td>
        </tr>
        <%
        i++;
      }
      out.println("</table>");
      // cierre de la conexion
      conexion.close();
    }
  %>
</form>
  </section>
  <script src="https://kit.fontawesome.com/f9e5d5f13a.js" crossorigin="anonymous"></script>
</body>
</html>
