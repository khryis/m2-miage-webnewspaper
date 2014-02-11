<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="fr.miage.webnewspaper.bean.entity.Journalist"%>
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
<title>Lecture d'un article</title>
<link href="css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
	<div class="container">
		<%!@EJB
	EJBArticleRemote ejbArticle;
	EJBLoginRemote ejbLogin;%>
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
			Article article = ejbArticle.getArticle(Long.valueOf(request.getParameter("id")));
			request.setAttribute("article", article);
			request.setAttribute("rates", ejbArticle.getRates(article));
			request.setAttribute("meanRate", ejbArticle.getMeanRates(article));
			request.setAttribute("comments", article.getComments());
		%>
		<div class="row">
			<a class="btn btn-default" href="accueil.jsp">Retour à l'accueil</a>
		</div>
		<hr/>
		<div class="row">
			<div class="panel panel-default">
				<div class="panel-heading">
					<span>Titre : ${requestScope.article.title}</span>
					<span>, écrit par ${requestScope.article.journalist.firstName} ${requestScope.article.journalist.lastName}</span>
					<p><span class="label label-success">${requestScope.meanRate}/5 (${fn:length(requestScope.rates)} votes)</span></p>
				</div>
				<div class="panel-body">
					<p>${article.content}</p>
				</div>
				<div class="panel-footer">
					<c:forEach items="${requestScope.comments}" var="comment">
						<div class="well">
							<p>${comment.writer.firstName} le <fmt:formatDate value="${comment.commentDate}" pattern="dd-MM-yyyy" /></p>
							<p>${comment.content}</p>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>

</body>
</html>