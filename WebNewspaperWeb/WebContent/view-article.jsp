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
<title>Consultation d'un article</title>
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
			Article article = ejbArticle.readArticle(Long.valueOf(request.getParameter("id")), (Reader)session.getAttribute("user"));
			request.setAttribute("article", article);
			request.setAttribute("rates", ejbArticle.getRates(article));
			request.setAttribute("meanRate", ejbArticle.getMeanRates(article));
			request.setAttribute("comments", article.getComments());
			EJBLoginRemote ejbLogin = (EJBLoginRemote)session.getAttribute("ejbLogin");
			Reader reader = (Reader)ejbLogin.getUser();
			for(Article art : reader.getBuyArticles()){
				if(art.getId().equals(article.getId())){
					request.setAttribute("buyArticle", "true");
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
					<span>Title : ${requestScope.article.title}</span>
					<span>, écrit par ${requestScope.article.journalist.firstName} ${requestScope.article.journalist.lastName}</span>
					<p>${requestScope.meanRate}/5 (${fn:length(requestScope.rates)})</p>
				</div>
				<div class="panel-body">
					<p>${article.content}</p>
				</div>
				<div class="panel-footer">
					<c:if test="${sessionScope.subscription == null and !requestScope.buyArticle}">
						<div class="well">
							<a class="btn btn-default" href="buy-article.jsp?id=${article.id}">Acheter l'article</a>
						</div>
					</c:if>
					<c:if test="${sessionScope.subscription != null or requestScope.buyArticle}">
						<form class="well" action="rate.jsp?id=${article.id}" method="POST">
							<div class="radio-inline">
								<label><input type="radio" name="optionsRadios" id="optionsRadios1" value="1">1</label>
							</div>
							<div class="radio-inline">
							  	<label><input type="radio" name="optionsRadios" id="optionsRadios2" value="2">2</label>
							</div>
							<div class="radio-inline">
							  	<label><input type="radio" name="optionsRadios" id="optionsRadios3" value="3">3</label>
							</div>
							<div class="radio-inline">
							  	<label><input type="radio" name="optionsRadios" id="optionsRadios4" value="4">4</label>
							</div>
							<div class="radio-inline">
							  	<label><input type="radio" name="optionsRadios" id="optionsRadios5" value="5">5</label>
							</div>
							<input type="submit" class="btn btn-default" value="Noter l'article" />
						</form>
					</c:if>	
					<c:forEach items="${requestScope.comments}" var="comment">
						<div class="well">
							<p>${comment.writer.firstName} le <fmt:formatDate value="${comment.commentDate}" pattern="dd MMM yyyy" /></p>
							<p>${comment.content}</p>
						</div>
					</c:forEach>
					
					<c:if test="${sessionScope.subscription != null or requestScope.buyArticle == 'true'}">
						<form action="comment.jsp?id=${article.id}" method="POST">
							<div class="form-group">
								<label>Commentaire</label> 
								<textarea class="form-control" rows="3" name="comment"></textarea>
							</div>
							<input type=submit class="btn btn-default" value="Ajouter le commentaire"/>
						</form>
					</c:if>	
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>

</body>
</html>