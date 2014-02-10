<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.Arrays"%>
<%@ page import="javax.ejb.EJB"%>
<%@ page import="fr.miage.webnewspaper.bean.session.EJBLoginRemote"%>
<%@page import="fr.miage.webnewspaper.bean.session.EJBAccountRemote"%>
<%@ page import="fr.miage.webnewspaper.bean.entity.Reader"%>
<%@ page import="java.util.Properties"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Liste des Lecteurs</title>
<link href="css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
	<div class="container">
		<%!@EJB
	EJBAccountRemote ejbAccount;%>
		<%
			if(!session.getAttribute("type").equals("A")){
				response.sendRedirect("logout.jsp");
			}
			try {
				Context context = new InitialContext();
				if (context != null) {
					ejbAccount = (EJBAccountRemote) context
							.lookup("java:global/WebNewspaper/WebNewspaperEJB/EJBAccount!fr.miage.webnewspaper.bean.session.EJBAccountRemote");
				}
			} catch (Exception e) {
				System.err.println(e.getMessage());
			}
			String idString = request.getParameter("id");
			if( idString != null){
				Long longId = new Long(Long.valueOf(idString));
				ejbAccount.deleteUser(longId);
			}
			List<Reader> readers = ejbAccount.getAllReaders();
			request.setAttribute("readers", readers);
		%>
		<div class="row">
			<h1>Suppression de lecteurs</h1>
			<a class="btn btn-default" href="accueil.jsp">Retour à l'accueil</a>
		</div>
		<hr/>
		<div class="row">
			<div class="panel panel-default">
				<div class="panel-heading">
					<span>Liste des Lecteurs</span>
				</div>
				<div class="panel-body">
					<table class="table table-striped">
						<tr>
							<th>Nom</th>
							<th>Prénom</th>
							<th>Email</th>
							<th>Date d'inscription</th>
							<th></th>
						</tr>
						<c:forEach items="${requestScope.readers}" var="reader">
						<tr>
							<td>${reader.firstName}</td>
							<td>${reader.lastName}</td>
							<td>${reader.email}</td>
							<td><fmt:formatDate pattern="dd MMMMM YYYY" value="${reader.registrationDate}"/></td>
							<td>
								<a href="liste-reader.jsp?id=${reader.id}">
									<span class="glyphicon glyphicon-remove"></span>
								</a>
							</td>
						</tr>	
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>

</body>
</html>