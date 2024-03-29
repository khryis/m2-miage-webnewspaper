<?xml version="1.0" encoding="UTF-8" ?>
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
<title>Index du site</title>
<link href="css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
	<div class="container">
		<%!@EJB
	EJBArticleRemote ejbArticle;%>
		<%
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
			List<Article> articles = ejbArticle.getAll();
			request.setAttribute("articles", articles);
		%>
		<div class="row">
			<h1>Bienvenue</h1>
		</div>

		<div class="row">
			<a class="btn btn-default" href="login.jsp">Me connecter</a> <a
				class="btn btn-default" href="create-account.jsp">Créer un
				compte</a>
		</div>
		<hr/>
		<div class="row">
			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">Derniers articles</div>
					<div class="panel-body">
						<ul>
							<c:forEach items="${requestScope.articles}" var="article">
								<c:if test="${article.isValidated}">
									<li><a href="preview-article.jsp?id=${article.id}">${article.title}</a></li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">Liste des articles</div>
					<div class="panel-body">
						<ul>
							<c:forEach items="${requestScope.articles}" var="article">
								<c:if test="${article.isValidated}">
									<li><a href="preview-article.jsp?id=${article.id}">${article.title}</a></li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>

</body>
</html>