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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Preview d'article</title>
<link href="css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
	<div class="container">
		<%!@EJB
	EJBArticleRemote ejbArticle;%>
		<%
			try {
				Context context = new InitialContext();
				if (context != null) {
					ejbArticle = (EJBArticleRemote) context
							.lookup("java:global/WebNewspaper/WebNewspaperEJB/EJBArticle!fr.miage.webnewspaper.bean.session.EJBArticleRemote");
				}
			} catch (Exception e) {
				System.err.println(e.getMessage());
			}
			Article article = ejbArticle.previewArticle(Long.valueOf(request.getParameter("id")));
			request.setAttribute("article", article);
			request.setAttribute("rates", ejbArticle.getRates(article));
			request.setAttribute("meanRate", ejbArticle.getMeanRates(article));
		%>
		<div class="row">
			<a class="btn btn-default" href="login.jsp">Me connecter</a>
			<a class="btn btn-default" href="index.jsp">Retour à l'index</a>
		</div>
		<hr/>
		<div class="row">
			<div class="panel panel-default">
				<div class="panel-heading">
					<span>Title : ${requestScope.article.title}</span>
					<span>, écrit par ${requestScope.article.journalist.firstName} ${requestScope.article.journalist.lastName}</span>
					<p>${requestScope.meanRate}/5 (${fn:length(requestScope.rates)})</p>
				</div>
				<div class="panel-body">
					<p>${article.content}</p>
				</div>
				<div class="panel-footer">
					<a class="btn btn-default" href="buy-article.jsp?id=${article.id}">Acheter l'article</a>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>

</body>
</html>