<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="fr.miage.webnewspaper.bean.entity.Journalist"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.Arrays"%>
<%@ page import="javax.ejb.EJB"%>
<%@ page import="fr.miage.webnewspaper.bean.session.EJBLoginRemote"%>
<%@ page import="fr.miage.webnewspaper.bean.session.EJBArticleRemote"%>
<%@ page import="fr.miage.webnewspaper.bean.entity.User"%>
<%@ page import="fr.miage.webnewspaper.bean.entity.Article"%>
<%@ page import="java.util.Properties"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Nouvelle article</title>
<link href="css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
	<div class="container">
		<%!@EJB
	EJBArticleRemote ejbArticle;%>
		<%
			if(!session.getAttribute("type").equals("J")){
				response.sendRedirect("logout.jsp");
			}
			try {
				// On ajuste les propriétés pour récupérer l'ejb distant
				Context context = new InitialContext();
				if (context != null) {
					ejbArticle = (EJBArticleRemote) context
							.lookup("java:global/WebNewspaper/WebNewspaperEJB/EJBArticle!fr.miage.webnewspaper.bean.session.EJBArticleRemote");
				}
			} catch (Exception e) {
				System.err.println(e.getMessage());
			}
			if(request.getMethod().equals("POST")){
				String title = request.getParameter("title");
				String content = request.getParameter("content");
				if(!title.isEmpty() && !content.isEmpty()){
					ejbArticle.addArticle(title, content, (Journalist)session.getAttribute("user"));
					response.sendRedirect("accueil.jsp");
				}
			}
		%>
		<div class="row">
			<h1>Ajouter un nouvelle Article</h1>
		</div>

		<div class="row">
			<a class="btn btn-default" href="accueil.jsp">Retour au tableau de bord</a>
		</div>
		<hr/>
		<form action="add-article.jsp" method="POST">
			<div class="form-group">
				<label>Titre</label> 
				<input type="text" class="form-control" name="title">
			</div>
			<div class="form-group">
				<label>Contenu</label> 
				<textarea name="content" class="form-control" rows="10"></textarea>
			</div>
			<button type="submit" class="btn btn-default">Ajouter</button>
		</form>
	</div>
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>

</body>
</html>