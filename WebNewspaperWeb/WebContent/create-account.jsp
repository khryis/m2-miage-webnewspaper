<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.Arrays"%>
<%@ page import="javax.ejb.EJB"%>
<%@ page
	import="fr.miage.webnewspaper.bean.session.EJBCreateAccountRemote"%>
<%@ page
	import="fr.miage.webnewspaper.bean.session.EJBLoginRemote"%>
<%@ page import="fr.miage.webnewspaper.bean.entity.User"%>
<%@ page import="java.util.Properties"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.Context"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII" />
<link href="css/bootstrap.min.css" rel="stylesheet" />
<title>Create account</title>
</head>

<body>
	<div class="container">
		<%!@EJB
	EJBCreateAccountRemote ejbCreateAccount;
	@EJB
	EJBLoginRemote ejbLogin;
	String message = null;%>
		<%
			try {

				Properties props = new Properties();
				props.setProperty("org.omg.CORBA.ORBInitialHost", "localhost");
				props.setProperty("org.omg.CORBA.ORBInitialPort", "3700");
				Context context = new InitialContext(props);
				if (context != null) {
					ejbCreateAccount = (EJBCreateAccountRemote) context
							.lookup("java:global/WebNewspaper/WebNewspaperEJB/EJBCreateAccount!fr.miage.webnewspaper.bean.session.EJBCreateAccountRemote");
					ejbLogin = (EJBLoginRemote) context
							.lookup("java:global/WebNewspaper/WebNewspaperEJB/EJBLogin!fr.miage.webnewspaper.bean.session.EJBLoginRemote");
				}
			} catch (Exception e) {
				System.err.println(e.getMessage());
			}

			if (request.getMethod() == "POST") {
				User user = new User();
				if (!request.getParameter("email").isEmpty()
						&& !request.getParameter("password").isEmpty()) {
					user.setAddress(request.getParameter("address"));
					user.setEmail(request.getParameter("email"));
					user.setPassword(request.getParameter("password"));
					//user.setBirthDate(request.getParameter("birthDate"));
					user.setFirstName(request.getParameter("firstName"));
					user.setLastName(request.getParameter("lastName"));
					if(ejbCreateAccount.createAccount(user)){
						if(ejbLogin.checkUser(request.getParameter("email"), request.getParameter("password"))){
							session.setAttribute("ejbLogin", ejbLogin);
							response.sendRedirect("accueil.jsp");
						}else{
							response.sendRedirect("index.jsp");
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
		<h1>Création de compte</h1>
		<c:if test="${! empty pageScope.message}">
			<span class='label label-warning'><c:out value="${pageScope.message}"></c:out></span>
		</c:if>
		<form action="create-account.jsp" method="POST">
			<div class="form-group">
				<label>Adresse email</label> <input type="email"
					class="form-control" name="email">
			</div>
			<div class="form-group">
				<label>Password</label> <input type="password" name="password"
					class="form-control">
			</div>
			<div class="form-group">
				<label>Prénom</label> <input type="text" name="firstName"
					class="form-control">
			</div>
			<div class="form-group">
				<label>Nom</label> <input type="text" name="lastName"
					class="form-control">
			</div>
			<div class="form-group">
				<label>Adresse</label> <input type="text" name="address"
					class="form-control">
			</div>
			<div class="form-group">
				<label>Anniversaire</label> <input type="date" name="birthDate"
					class="form-control">
			</div>
			<button type="submit" class="btn btn-default">Se connecter</button>
		</form>
		<a href="accueil.jsp">Ecran d'accueil</a>
	</div>
</body>
</html>