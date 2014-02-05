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
			String message = null;
		%>
		<%
			try {

				Properties props = new Properties();
				props.setProperty("org.omg.CORBA.ORBInitialHost", "localhost");
				props.setProperty("org.omg.CORBA.ORBInitialPort", "3700");
				Context context = new InitialContext(props);
				if (context != null) {
					ejbLogin = (EJBLoginRemote) context
							.lookup("java:global/WebNewspaper/WebNewspaperEJB/EJBLogin!fr.miage.webnewspaper.bean.session.EJBLoginRemote");
					System.out.println("Est loggué : "
							+ Arrays.asList(ejbLogin.isLogged()));
					session.setAttribute("ejbLogin", ejbLogin);
				}
			} catch (Exception e) {
				System.err.println(e.getMessage());
			}
			
			if (request.getParameter("email") != null && !request.getParameter("email").isEmpty() 
					&& request.getParameter("password") != null && !request.getParameter("password").isEmpty()){
				if (ejbLogin.checkUser(request.getParameter("email"),request.getParameter("password"))){
					response.sendRedirect("accueil.jsp");
					System.out.println("Réussi");
				}else{
					System.out.println("Loupé");
					message = "Aucun n'utilisateur connu pour ces identifiants";
				}	
			}
			pageContext.setAttribute("message", message);
		%>
		<div>
			<h1>Ecran de connexion</h1>
			<c:if test="${! empty pageScope.message}">
				<span class='label label-warning'><c:out value="${pageScope.message}"></c:out></span>
			</c:if>
			<form action="login.jsp" method="POST">
				<div class="form-group">
					<label>Adresse email</label> <input type="email"
						class="form-control" name="email" placeholder="Enter email">
				</div>
				<div class="form-group">
					<label>Password</label> <input type="password" name="password" class="form-control"
						placeholder="Password">
				</div>
				<button type="submit" class="btn btn-default">Se connecter</button>
			</form>
			<a href="create-account.jsp">Créer un compte</a>
		</div>
	</div>
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>

</body>
</html>