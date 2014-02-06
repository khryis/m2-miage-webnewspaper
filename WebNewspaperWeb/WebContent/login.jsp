<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.Arrays"%>
<%@ page import="javax.ejb.EJB"%>
<%@ page import="fr.miage.webnewspaper.bean.session.EJBLoginRemote"%>
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
	String message = null;%>
		<%
			try {

				// On ajuste les propriétés pour récupérer l'ejb distant
				Properties props = new Properties();
				props.setProperty("org.omg.CORBA.ORBInitialHost", "localhost");
				props.setProperty("org.omg.CORBA.ORBInitialPort", "3700");
				Context context = new InitialContext(props);
				if (context != null) {
					ejbLogin = (EJBLoginRemote) context
							.lookup("java:global/WebNewspaper/WebNewspaperEJB/EJBLogin!fr.miage.webnewspaper.bean.session.EJBLoginRemote");
					// on stock l'ejb stateful dans la session
					session.setAttribute("ejbLogin", ejbLogin);
					// on stock le type d'utilisateur de la session
					session.setAttribute("type", ejbLogin.getTypeOfUser());
				}
			} catch (Exception e) {
				System.err.println(e.getMessage());
			}

			//On vérifie bien les champs rempli par l'utilisateur
			if (request.getParameter("email") != null
					&& !request.getParameter("email").isEmpty()){
				if(request.getParameter("password") != null
						&& !request.getParameter("password").isEmpty()) {
					// on va voir si c'est un utilisateur valide
					if (ejbLogin.checkUser(request.getParameter("email"),
							request.getParameter("password"))) {
						//l'utilisateur est connecté
						response.sendRedirect("accueil.jsp");
					} else {
						message = "Aucun n'utilisateur connu pour ces identifiants";
					}
				}else{
					message = "Veuillez entrer un mot de passe";
				}
			}
					
			request.setAttribute("message", message);
		%>
		<div>
			<a class="btn btn-default" href="index.jsp">Retour à l'index</a> 
			<h1>Ecran de connexion</h1>
			<c:if test="${requestScope.message != null}">
				<span class='label label-warning'>
					<c:out value="${requestScope.message}"></c:out>
				</span>
			</c:if>
			<form action="login.jsp" method="POST">
				<div class="form-group">
					<label>Adresse email</label> <input type="email"
						class="form-control" name="email" placeholder="Enter email">
				</div>
				<div class="form-group">
					<label>Password</label> <input type="password" name="password"
						class="form-control" placeholder="Password">
				</div>
				<button type="submit" class="btn btn-default">Se connecter</button>
				<a class="btn btn-default" href="create-account.jsp">Créer un compte</a> 
			</form>
		</div>
	</div>
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>

</body>
</html>