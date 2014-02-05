<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.Arrays"%>
<%@ page import="javax.ejb.EJB"%>
<%@ page import="fr.miage.webnewspaper.bean.session.EJBLoginRemote"%>
<%@ page import="fr.miage.webnewspaper.bean.entity.User"%>
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
			EJBLoginRemote ejbLogin;
			String message = null;
		%>
		<%
			try {
				ejbLogin = (EJBLoginRemote) session.getAttribute("ejbLogin");
				if(ejbLogin.isLogged()){
					response.sendRedirect("accueil.jsp");
				}else{
					Properties props = new Properties();
					props.setProperty("org.omg.CORBA.ORBInitialHost", "localhost");
					props.setProperty("org.omg.CORBA.ORBInitialPort", "3700");
					Context context = new InitialContext(props);
					if (context != null) {
						ejbLogin = (EJBLoginRemote) context.lookup("java:global/WebNewspaper/WebNewspaperEJB/EJBLogin!fr.miage.webnewspaper.bean.session.EJBLoginRemote");
						session.setAttribute("ejbLogin", ejbLogin);
					}
				}
			} catch (Exception e) {
				System.err.println(e.getMessage());
			}
		%>
		<div>
			<h1>Bienvenue</h1>
			<a class="btn btn-default" href="create-account.jsp">Créer un compte</a>
			<a class="btn btn-default" href="login.jsp">Me connecter</a>
			
		</div>
	</div>
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>

</body>
</html>