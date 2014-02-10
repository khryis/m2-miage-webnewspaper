<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.Arrays"%>
<%@ page import="javax.ejb.EJB"%>
<%@ page import="fr.miage.webnewspaper.bean.session.EJBArticleRemote"%>
<%@ page import="fr.miage.webnewspaper.bean.session.EJBAccountRemote"%>
<%@ page import="fr.miage.webnewspaper.bean.entity.Article"%>
<%@ page import="fr.miage.webnewspaper.bean.entity.User"%>
<%@ page import="fr.miage.webnewspaper.bean.entity.Journalist"%>
<%@ page import="java.util.Properties"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="css/bootstrap.min.css" rel="stylesheet" />
<title>Accueil</title>
</head>
<body>
	<div class="container">
		<%!@EJB
	EJBArticleRemote ejbArticle;
		@EJB
	EJBAccountRemote ejbAccount;%>
		<%
			try {
				// On ajuste les propriétés pour récupérer l'ejb distant
				Context context = new InitialContext();
				if (context != null) {
					ejbArticle = (EJBArticleRemote) context
							.lookup("java:global/WebNewspaper/WebNewspaperEJB/EJBArticle!fr.miage.webnewspaper.bean.session.EJBArticleRemote");
					ejbAccount = (EJBAccountRemote)context.lookup("java:global/WebNewspaper/WebNewspaperEJB/EJBAccount!fr.miage.webnewspaper.bean.session.EJBAccountRemote");
				}
			} catch (Exception e) {
				System.err.println(e.getMessage());
			}
			User u = (User)session.getAttribute("user");
			List<Article> articles = new ArrayList<Article>();
			String type = (String)session.getAttribute("type"); 
			if(type != null){
				if(type.equals("R")){
					articles = ejbArticle.getAll();
					request.setAttribute("articles", articles);
				}else if(session.getAttribute("type").equals("J")){
					articles = ejbArticle.getJournalistArticle((Journalist)u);
					request.setAttribute("articles", articles);
					if(((Journalist)u).getIsChiefEditor()){
						List<Article>allArticles = ejbArticle.getAll();
						request.setAttribute("allArticles", allArticles);
					}
				}else if(session.getAttribute("type").equals("A")){
					articles = ejbArticle.getAll();
					request.setAttribute("articles", articles);
					List<Journalist> journalists = ejbAccount.getAllJournalists();
					request.setAttribute("journalists", journalists);
				}
			}
		%>


		<!-- ----------------------------  -->
		<!--  Page Accueil Pour un Reader  -->
		<c:if test="${sessionScope.type == 'R' }">
			<div class="row">
				<p class="lead">Bienvenu Lecteur ${sessionScope.user.firstName}
					${sessionScope.user.lastName}</p>
				<c:if test="${sessionScope.subscription != null}">
					<p>
						Abonné jusqu'au
						<fmt:formatDate
							value="${sessionScope.subscription.subscriptionEndDate}"
							pattern="dd-MM-yyyy" />
					</p>
				</c:if>
			</div>

			<div class="row">
				<c:if test="${sessionScope.subscription == null}">
					<a class="btn btn-default" href="subscribe.jsp">M'abonner</a>
				</c:if>
				<a class="btn btn-default" href="logout.jsp">Me déconnecter</a>
			</div>
			<hr />
			<div class="row">
				<div class="col-md-6">
					<div class="panel panel-default">
						<div class="panel-heading">Derniers articles</div>
						<div class="panel-body">
							<ul>
								<c:forEach items="${requestScope.articles}" var="article">
									<c:if test="${article.isValidated}">
										<li><a href="view-article.jsp?id=${article.id}">${article.title}</a></li>
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
										<li><a href="view-article.jsp?id=${article.id}">${article.title}</a></li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</c:if>
		<!-- ---------------------------------  -->


		<!-- ---------------------------------  -->
		<!--  Page Accueil Pour un Journaliste  -->
		<c:if test="${sessionScope.type == 'J'}">
			<c:if test="${!sessionScope.user.isChiefEditor}">
				<div class="row">
					<p class="lead">Bienvenu Journaliste
						${sessionScope.user.firstName} ${sessionScope.user.lastName}</p>
				</div>

				<div class="row">
					<ul class="list-inline">
						<li><a class="btn btn-default" href="logout.jsp">Me
								déconnecter</a></li>
						<li><a class="btn btn-default" href="add-article.jsp">Ajouter
								un article</a></li>
					</ul>
				</div>

				<div class="row well">
					<div class="col-md-6">
						<div class="panel panel-default">
							<div class="panel-heading">Mes Articles</div>
							<div class="panel-body">
								<c:forEach items="${requestScope.articles}" var="article">
									<c:if test="${article.isValidated}">
										<div class="row">
											<span class="col-md-5">${article.title}</span> <a
												class="col-md-offset-1 col-md-1"
												href="read-article.jsp?id=${article.id}"><span
												class="glyphicon glyphicon-search"></span></a>
											<c:if test="${sessionScope.user.isChiefEditor}">
												<a class="col-md-1"
													href="delete-article.jsp?id=${article.id}"><span
													class="glyphicon glyphicon-Remove"></span></a>
											</c:if>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="panel panel-default">
							<div class="panel-heading">Articles non validé</div>
							<div class="panel-body">
								<c:forEach items="${requestScope.articles}" var="article">
									<c:if test="${not article.isValidated}">
										<div class="row">
											<span class="col-md-5">${article.title}</span> <a
												class="col-md-offset-1 col-md-1"
												href="read-article.jsp?id=${article.id}"><span
												class="glyphicon glyphicon-search"></span></a> <a
												class="col-md-1" href="modify-article.jsp?id=${article.id}"><span
												class="glyphicon glyphicon-pencil"></span></a>
											<c:if test="${sessionScope.user.isChiefEditor}">
												<a class="col-md-1"
													href="delete-article.jsp?id=${article.id}"><span
													class="glyphicon glyphicon-Remove"></span></a>
											</c:if>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${sessionScope.user.isChiefEditor}">
				<div class="row">
					<p class="lead">Bienvenu Editeur en Chef
						${sessionScope.user.firstName} ${sessionScope.user.lastName}</p>
				</div>

				<div class="row">
					<ul class="list-inline">
						<li><a class="btn btn-default" href="logout.jsp">Me
								déconnecter</a></li>
						<li><a class="btn btn-default" href="add-article.jsp">Ajouter
								un article</a></li>
					</ul>
				</div>

				<div class="row well">
					<div class="col-md-6">
						<div class="panel panel-default">
							<div class="panel-heading">Tout les Articles</div>
							<div class="panel-body">
								<c:forEach items="${requestScope.allArticles}" var="article">
									<c:if test="${article.isValidated}">
										<div class="row">
											<span class="col-md-5">${article.title}</span> <a
												class="col-md-offset-1 col-md-1"
												href="read-article.jsp?id=${article.id}"><span
												class="glyphicon glyphicon-search"></span></a> <a
												class="col-md-1" href="delete-article.jsp?id=${article.id}"><span
												class="glyphicon glyphicon-remove"></span></a>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="panel panel-default">
							<div class="panel-heading">Tout les Articles non validé</div>
							<div class="panel-body">
								<c:forEach items="${requestScope.allArticles}" var="article">
									<c:if test="${not article.isValidated}">
										<div class="row">
											<span class="col-md-5">${article.title}</span> <a
												class="col-md-offset-1 col-md-1"
												href="read-article.jsp?id=${article.id}"><span
												class="glyphicon glyphicon-search"></span></a> <a
												class="col-md-1" href="modify-article.jsp?id=${article.id}"><span
												class="glyphicon glyphicon-pencil"></span></a> <a
												class="col-md-1"
												href="validate-article.jsp?id=${article.id}"><span
												class="glyphicon glyphicon-ok"></span></a> <a class="col-md-1"
												href="delete-article.jsp?id=${article.id}"><span
												class="glyphicon glyphicon-remove"></span></a>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</c:if>
		</c:if>
		<!-- ------------------------------------  -->


		<!-- ------------------------------------  -->
		<!--  Page Accueil Pour un Administrateur  -->
		<c:if test="${sessionScope.type == 'A'}">
			<div class="row">
				<p class="lead">Bienvenu Administrateur
					${sessionScope.user.firstName} ${sessionScope.user.lastName}</p>
			</div>

			<div class="row">
				<a class="btn btn-default" href="add-journalist.jsp">Ajouter un journaliste</a>
				<a class="btn btn-default" href="liste-reader.jsp">Supprimer un Lecteur</a>
				<a class="btn btn-default" href="logout.jsp">Me déconnecter</a>
			</div>
			<hr/>
			<div class="row">
				<div class="col-md-6">
					<div class="panel panel-default">
						<div class="panel-heading">Articles en Ligne (Validés)</div>
						<div class="panel-body">
							<c:forEach items="${requestScope.articles}" var="article">
								<c:if test="${article.isValidated}">
									<div class="row">
										<span class="col-md-6">${article.title}</span> <a
											class="col-md-offset-3 col-md-2"
											href="article-comments.jsp?id=${article.id}"><span
											class="glyphicon glyphicon-search">Commentaires</span></a>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="panel panel-default">
						<div class="panel-heading">Liste des journalistes actifs</div>
						<div class="panel-body">
							<c:forEach items="${requestScope.journalists}" var="journalist">
								<c:if test="${journalist.status == 'actif'}">
									<div class="row">
										<span class="col-md-8">${journalist.firstName}
											${journalist.lastName}</span> <a class="col-md-offset-2 col-md-2"
											href="modify-journalist.jsp?id=${journalist.id}"><span
											class="glyphicon glyphicon-pencil"></span></a>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</c:if>
		<!-- ------------------------------------  -->
	</div>
</body>
</html>