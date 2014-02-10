<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.Arrays"%>
<%@ page import="javax.ejb.EJB"%>
<%@ page
	import="fr.miage.webnewspaper.bean.session.EJBCreateAccountRemote"%>
<%@ page
	import="fr.miage.webnewspaper.bean.session.EJBLoginRemote"%>
<%@ page import="fr.miage.webnewspaper.bean.entity.Reader"%>
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
				Context context = new InitialContext();
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
				Reader reader = new Reader();
				// si au moins email, mot de passe est rempli, on crée un user pour envoyer à la méthode create de l'EJB
				if (!request.getParameter("email").isEmpty()
						&& !request.getParameter("password").isEmpty()) {
					reader.setAddress(request.getParameter("address"));
					reader.setEmail(request.getParameter("email"));
					reader.setPassword(request.getParameter("password"));
					//user.setBirthDate(request.getParameter("birthDate"));
					reader.setFirstName(request.getParameter("firstName"));
					reader.setLastName(request.getParameter("lastName"));
					
					try{
						// on essaie de créer un compte
						if(ejbCreateAccount.createAccountReader(reader)){
							//si crée, on envoi l'utilisateur à l'accueil 
							if(ejbLogin.checkUser(request.getParameter("email"), request.getParameter("password"))){
								session.setAttribute("ejbLogin", ejbLogin);
								session.setAttribute("type", ejbLogin.getTypeOfUser());
								response.sendRedirect("accueil.jsp");
							}else{
								// sinon retour à l'index
								response.sendRedirect("index.jsp");
							}
						}else{
							message = "Création du compte impossible";
						}
					}catch(Exception e){
						message = "Email déjà existant, création impossible";
					}
				}else{
					message = "Vous devez au moins renseigner un email et un mot de passe";
				}
				
			}
			request.setAttribute("message", message);
		%>
		<a class="btn btn-default" href="accueil.jsp">Retour à l'index</a>
		<h1>Création de compte</h1>
		<c:if test="${requestScope.message != null}">
			<span class='label label-warning'><c:out value="${requestScope.message}"></c:out></span>
			<c:remove var="message" scope="request"/>
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
	</div>
</body>
</html>