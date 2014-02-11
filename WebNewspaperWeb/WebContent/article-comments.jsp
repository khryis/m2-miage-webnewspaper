<?xml version="1.0" encoding="UTF-8" ?>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.Arrays"%>
<%@ page import="javax.ejb.EJB"%>
<%@ page import="fr.miage.webnewspaper.bean.session.EJBLoginRemote"%>
<%@ page import="fr.miage.webnewspaper.bean.session.EJBArticleRemote"%>
<%@ page import="fr.miage.webnewspaper.bean.entity.User"%>
<%@page import="fr.miage.webnewspaper.bean.entity.Administrator"%>
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
<title>Consultation des commentaires d'un article</title>
<link href="css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
	<div class="container">
		<%!@EJB
	EJBArticleRemote ejbArticle;%>
		<%
			if(session != null){
				if(!(session.getAttribute("type").toString().equals("A"))){
					response.sendRedirect("logout.jsp");
				}
			}	
			try {
				Context context = new InitialContext();
				if (context != null) {
					ejbArticle = (EJBArticleRemote) context.lookup("java:global/WebNewspaper/WebNewspaperEJB/EJBArticle!fr.miage.webnewspaper.bean.session.EJBArticleRemote");
				}
			} catch (Exception e) {
				System.err.println(e.getMessage());
			}
			
			String idString = request.getParameter("del");
			if( idString != null){
				Long longId = new Long(Long.valueOf(idString));
				ejbArticle.deleteComment(longId);
			}
			
			Article article = ejbArticle.getArticle(Long.valueOf(request.getParameter("id")));
			request.setAttribute("article", article);
			request.setAttribute("comments", article.getComments());
		%>
		<div class="row">
			<a class="btn btn-default" href="accueil.jsp">Retour à l'accueil</a>
		</div>
		<hr/>
		<div class="row">
			<div class="panel panel-default">
				<div class="panel-heading">
					<span>Title : ${requestScope.article.title}</span>
					<span>, écrit par ${requestScope.article.journalist.firstName} ${requestScope.article.journalist.lastName}</span>
				</div>
				<div class="panel-body">
					<p>${article.content}</p>
				</div>
				<div class="panel-footer">
					<c:forEach items="${requestScope.comments}" var="comment">
						<div class="well">
							<p>${comment.writer.firstName} le <fmt:formatDate value="${comment.commentDate}" pattern="dd MMM yyyy" /></p>
							<p>${comment.content}</p>
							<a class="btn btn-default" href="article-comments.jsp?id=${article.id}&del=${comment.id}">Supprimer ce commentaire</a>
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