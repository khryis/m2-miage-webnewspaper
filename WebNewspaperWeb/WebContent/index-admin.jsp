<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.Arrays"%>
<%@ page import="javax.ejb.EJB"%>
<%@ page import="fr.miage.webnewspaper.bean.session.EJBLoginAdminRemote"%>
<%@ page import="java.util.Properties"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.Context"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Login</title>
<link href="css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
	<div class="container">
		<%!@EJB
			EJBLoginAdminRemote ejbLoginAdmin;
			String message = null;
		%>
		<%
			try {
				ejbLoginAdmin = (EJBLoginAdminRemote) session.getAttribute("ejbLoginAdmin");
				if(ejbLoginAdmin.isLogged()){
					response.sendRedirect("accueil-admin.jsp");
				}else{
					Properties props = new Properties();
					props.setProperty("org.omg.CORBA.ORBInitialHost", "localhost");
					props.setProperty("org.omg.CORBA.ORBInitialPort", "3700");
					Context context = new InitialContext(props);
					if (context != null) {
						ejbLoginAdmin = (EJBLoginAdminRemote) context.lookup("java:global/WebNewspaper/WebNewspaperEJB/EJBLoginAdmin!fr.miage.webnewspaper.bean.session.EJBLoginAdminRemote");
						session.setAttribute("ejbLoginAdmin", ejbLoginAdmin);
					}
				}
			} catch (Exception e) {
				System.err.println(e.getMessage());
			}
		%>
		<div>
			<h1>Bienvenue</h1>
			<a class="btn btn-default" href="create-account-admin.jsp">Créer un compte administrateur</a>
			<a class="btn btn-default" href="login-admin.jsp">Me connecter</a>
			
		</div>
	</div>
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>

</body>
</html>