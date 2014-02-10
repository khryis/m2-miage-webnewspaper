<?xml version="1.0" encoding="UTF-8" ?>

<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Arrays"%>
<%@page import="javax.ejb.EJB"%>
<%@page import="fr.miage.webnewspaper.bean.session.EJBAccountRemote"%>
<%@page import="fr.miage.webnewspaper.bean.session.EJBLoginRemote"%>
<%@page import="fr.miage.webnewspaper.bean.entity.Journalist"%>
<%@page import="java.util.Properties"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII" />
<link href="css/bootstrap.min.css" rel="stylesheet" />
<title>Création d'un Journaliste</title>
</head>

<body>
	<div class="container">
		<%!@EJB
		EJBAccountRemote ejbAccount;
		@EJB
		EJBLoginRemote ejbLogin;
		String message = null;%>
		<%
			if(!session.getAttribute("type").equals("A")){
				response.sendRedirect("logout.jsp");
			}	
			try {
				Context context = new InitialContext();
				if (context != null) {
					ejbLogin = (EJBLoginRemote) context
							.lookup("java:global/WebNewspaper/WebNewspaperEJB/EJBLogin!fr.miage.webnewspaper.bean.session.EJBLoginRemote");
					ejbAccount = (EJBAccountRemote) context
							.lookup("java:global/WebNewspaper/WebNewspaperEJB/EJBAccount!fr.miage.webnewspaper.bean.session.EJBAccountRemote");
				}
			} catch (Exception e) {
				System.err.println(e.getMessage());
			}
			if (request.getMethod() == "POST") {
				Journalist journalist = new Journalist();
				// si au moins email, mot de passe est rempli, on crée un user pour envoyer à la méthode create de l'EJB
				if (!request.getParameter("email").isEmpty()
						&& !request.getParameter("password").isEmpty()) {
					journalist.setAddress(request.getParameter("address"));
					journalist.setEmail(request.getParameter("email"));
					journalist.setPassword(request.getParameter("password"));
					//user.setBirthDate(request.getParameter("birthDate"));
					journalist.setFirstName(request.getParameter("firstName"));
					journalist.setLastName(request.getParameter("lastName"));
					if(request.getParameter("firstName").equals("true")){
						journalist.setIsChiefEditor(true);	
					}
					try {
						// on essaie de créer un compte
						ejbAccount.createAccountJournalist(journalist);
						response.sendRedirect("accueil.jsp");
					} catch (Exception e) {
						message = "Création impossible";
						System.err.println(e.getMessage());
					}
				} else {
					message = "Vous devez au moins renseigner un email et un mot de passe";
				}

			}
			request.setAttribute("message", message);
		%>
		<a class="btn btn-default" href="accueil.jsp">Retour à l'index</a>
		<h1>Création d'un Journaliste</h1>
		<c:if test="${requestScope.message != null}">
			<span class="label label-warning">${requestScope.message}</span>
		</c:if>
		<form action="add-journalist.jsp" method="POST">
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
			<div class="radio">
				<label><input type="radio" name="optionsRadios"
					id="optionsRadios1" value="false">Journaliste</label>
			</div>
			<div class="radio">
				<label><input type="radio" name="optionsRadios"
					id="optionsRadios2" value="true">Rédacteur en chef</label>
			</div>
			<button type="submit" class="btn btn-default">Ajouter le
				journaliste</button>
		</form>
	</div>
</body>
</html>