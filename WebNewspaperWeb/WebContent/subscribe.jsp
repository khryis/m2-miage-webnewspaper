<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.Arrays"%>
<%@ page import="javax.ejb.EJB"%>
<%@ page import="fr.miage.webnewspaper.bean.session.EJBLoginRemote"%>
<%@ page import="fr.miage.webnewspaper.bean.session.EJBArticleRemote"%>
<%@ page import="fr.miage.webnewspaper.bean.entity.User"%>
<%@ page import="fr.miage.webnewspaper.bean.entity.Reader"%>
<%@ page import="fr.miage.webnewspaper.bean.entity.Article"%>
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
<title>Souscription à un abonnement</title>
<link href="css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
	<div class="container">
		<%!@EJB
	EJBArticleRemote ejbArticle;%>
		<%
			if(!session.getAttribute("type").equals("R")){
				response.sendRedirect("logout.jsp");
			}
			try {
				Context context = new InitialContext();
				if (context != null) {
					ejbArticle = (EJBArticleRemote) context
							.lookup("java:global/WebNewspaper/WebNewspaperEJB/EJBArticle!fr.miage.webnewspaper.bean.session.EJBArticleRemote");
				}
			} catch (Exception e) {
				System.err.println(e.getMessage());
			}
			Reader reader = (Reader)session.getAttribute("user");
			if(request.getMethod().equals("POST")){
				if(!request.getParameter("optionsRadios").isEmpty()){
					EJBLoginRemote ejbLogin = (EJBLoginRemote)session.getAttribute("ejbLogin");
					ejbLogin.subscribe(Integer.valueOf(request.getParameter("optionsRadios")));
					response.sendRedirect("accueil.jsp");
				}
			}
		%>
		<div class="row">
			<a class="btn btn-default" href="accueil.jsp">Retour à l'accueil</a>
		</div>
		<hr/>
		<div class="row">
			<div class="panel panel-default">
				<div class="panel-heading">
					<p>Page d'abonnement</p>
				</div>
				<div class="panel-body">
					<form class="well" action="subscribe.jsp" method="POST">
						<div class="radio">
							<label><input type="radio" name="optionsRadios" id="optionsRadios1" value="1">1 jour</label>
						</div>
						<div class="radio">
						  	<label><input type="radio" name="optionsRadios" id="optionsRadios2" value="2">1 semaine</label>
						</div>
						<div class="radio">
						  	<label><input type="radio" name="optionsRadios" id="optionsRadios3" value="3">1 mois</label>
						</div>
						<div class="radio">
						  	<label><input type="radio" name="optionsRadios" id="optionsRadios4" value="4">1 an</label>
						</div>
						<input type="submit" class="btn btn-default" value="M'abonner" />
					</form>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>

</body>
</html>