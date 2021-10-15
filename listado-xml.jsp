<%@page contentType="text/html" pageEncoding="iso-8859-1" import="java.sql.*,net.ucanaccess.jdbc.*" %>
<%
    response.setHeader("Content-Type", "text/xml");
    response.setHeader("Content-Disposition","Attachment; filename= libros.xml");
%>