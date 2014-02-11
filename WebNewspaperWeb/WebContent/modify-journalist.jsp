<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="fr.miage.webnewspaper.bean.entity.Journalist"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.Arrays"%>
<%@ page import="javax.ejb.EJB"%>
<%@ page import="fr.miage.webnewspaper.bean.session.EJBLoginRemote"%>
<%@page import="fr.miage.webnewspaper.bean.session.EJBAccountRemote"%>
<%@ page import="fr.miage.webnewspaper.bean.entity.User"%>
<%@ page import="java.util.Properties"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Modifier article</title>
<link href="css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
	<div class="container">
		<%!@EJB
	EJBAccountRemote ejbAccount;%>
		<%
			if (!session.getAttribute("type").equals("A")) {
				response.sendRedirect("logout.jsp");
			}
			try {
				// On ajuste les propriétés pour récupérer l'ejb distant
				Context context = new InitialContext();
				if (context != null) {
					ejbAccount = (EJBAccountRemote) context.lookup("java:global/WebNewspaper/WebNewspaperEJB/EJBAccount!fr.miage.webnewspaper.bean.session.EJBAccountRemote");
				}
			} catch (Exception e) {
				System.err.println(e.getMessage());
			}

			Long longId = new Long(Long.valueOf(request.getParameter("id")));
			if (request.getMethod().equals("POST")) {
				String email = request.getParameter("email");
				String firstName = request.getParameter("firstName");
				String lastName = request.getParameter("lastName");
				String isChief = request.getParameter("isChief");
				String status = request.getParameter("status");
				

				if (!email.isEmpty() && !isChief.isEmpty() && !status.isEmpty() && !firstName.isEmpty()) {
					Journalist journalist = (Journalist)ejbAccount.getUser(longId);
					journalist.setEmail(email);
					journalist.setFirstName(firstName);
					journalist.setLastName(lastName);
					journalist.setStatus(status);
					if(isChief.equals("true")){
						journalist.setIsChiefEditor(true);	
					}else{
						journalist.setIsChiefEditor(false);
					}
					ejbAccount.updateJournalist(journalist);
					response.sendRedirect("accueil.jsp");
				}
			}
			Journalist journalist = (Journalist)ejbAccount.getUser(longId);
			request.setAttribute("journalist", journalist);
		%>

		<a class="btn btn-default" href="accueil.jsp">Retour à l'index</a>
		<h1>Modifier le Journalist : ${requestScope.journalist.firstName} ${requestScope.journalist.lastName}</h1>
		<div class="row">
			<div class="col-md-6">		
				<form action="modify-journalist.jsp?id=${requestScope.journalist.id}" method="POST">
					<div class="form-group">
						<label>Adresse email</label> <input type="email" class="form-control" name="email" value="${requestScope.journalist.email}" />
					</div>
					<div class="form-group">
						<label>Prénom</label> <input type="text" class="form-control" name="firstName" value="${requestScope.journalist.firstName}" />
					</div>
					<div class="form-group">
						<label>Nom</label> <input type="text" class="form-control" name="lastName" value="${requestScope.journalist.lastName}" />
					</div>
					<div class="form-group">
						<select class="form-control" name="isChief">
							<c:choose>
								<c:when test="${requestScope.journalist.isChiefEditor}">
									<option value="true" selected>Editeur en Chef</option>
									<option value="false">Journaliste</option>
								</c:when>
								<c:otherwise>
									<option value="false" selected>Journaliste</option>
									<option value="true" >Editeur en Chef</option>
								</c:otherwise>
							</c:choose>
						</select>
					</div>
					<div class="form-group">
						<select class="form-control" name="status">
							<c:choose>
								<c:when test="${requestScope.journalist.status == 'actif'}">
									<option value="actif" selected>Actif</option>
									<option value="inactif">Inactif</option>
								</c:when>
								<c:otherwise>
									<option value="inactif" selected>Inactif</option>
									<option value="actif">Actif</option>
								</c:otherwise>
							</c:choose>
						</select>
					</div>
					<button type="submit" class="btn btn-default">Modifier le journaliste</button>
				</form>
			</div>	
		</div>	
	</div>
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>

</body>
</html>