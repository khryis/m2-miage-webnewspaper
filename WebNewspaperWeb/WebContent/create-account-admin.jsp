<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.Arrays"%>
<%@ page import="javax.ejb.EJB"%>
<%@ page
	import="fr.miage.webnewspaper.bean.session.EJBCreateAccountAdminRemote"%>
<%@ page
	import="fr.miage.webnewspaper.bean.session.EJBLoginAdminRemote"%>
<%@ page import="fr.miage.webnewspaper.bean.entity.Administrator"%>
<%@ page import="java.util.Properties"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.Context"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII" />
<link href="css/bootstrap.min.css" rel="stylesheet" />
<title>Create account for admin</title>
</head>

<body>
	<div class="container">
		<%!@EJB
	EJBCreateAccountAdminRemote ejbCreateAccountAdmin;
	@EJB
	EJBLoginAdminRemote ejbLoginAdmin;
	String message = null;%>
		<%
			try {

				Properties props = new Properties();
				props.setProperty("org.omg.CORBA.ORBInitialHost", "localhost");
				props.setProperty("org.omg.CORBA.ORBInitialPort", "3700");
				Context context = new InitialContext(props);
				if (context != null) {
					ejbCreateAccountAdmin = (EJBCreateAccountAdminRemote) context
							.lookup("java:global/WebNewspaper/WebNewspaperEJB/EJBCreateAccountAdmin!fr.miage.webnewspaper.bean.session.EJBCreateAccountAdminRemote");
					ejbLoginAdmin = (EJBLoginAdminRemote) context
							.lookup("java:global/WebNewspaper/WebNewspaperEJB/EJBLoginAdmin!fr.miage.webnewspaper.bean.session.EJBLoginAdminRemote");
				}
			} catch (Exception e) {
				System.err.println(e.getMessage());
			}

			if (request.getMethod() == "POST") {
				Administrator admin = new Administrator();
				if (!request.getParameter("email").isEmpty()
						&& !request.getParameter("password").isEmpty()) {
					admin.setEmail(request.getParameter("email"));
					admin.setPassword(request.getParameter("password"));
					if(ejbCreateAccountAdmin.createAccount(admin)){
						if(ejbLoginAdmin.checkAdmin(request.getParameter("email"), request.getParameter("password"))){
							session.setAttribute("ejbLoginAdmin", ejbLoginAdmin);
							response.sendRedirect("accueil-admin.jsp");
						}else{
							response.sendRedirect("index-admin.jsp");
						}
					}else{
						message = "Création du compte impossible";
					}
				}else{
					message = "Vous devez au moins renseigner un email et un mot de passe";
				}
			}
			pageContext.setAttribute("message", message);
		%>
		<h1>Création de compte pour un administrateur</h1>
		<c:if test="${! empty pageScope.message}">
			<span class='label label-warning'><c:out value="${pageScope.message}"></c:out></span>
		</c:if>
		<form action="create-account-admin.jsp" method="POST">
			<div class="form-group">
				<label>Adresse email</label> <input type="email"
					class="form-control" name="email">
			</div>
			<div class="form-group">
				<label>Password</label> <input type="password" name="password"
					class="form-control">
			</div>
			<button type="submit" class="btn btn-default">Se connecter</button>
		</form>
		<a href="accueil-admin.jsp">Ecran d'accueil</a>
	</div>
</body>
</html>