<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.Arrays"%>
<%@ page import="javax.ejb.EJB"%>
<%@ page import="fr.miage.webnewspaper.bean.session.EJBArticleRemote"%>
<%@ page import="fr.miage.webnewspaper.bean.entity.Article"%>
<%@ page import="java.util.Properties"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.Context"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Acheter un article</title>
</head>
<body>
	<%!@EJB
	EJBArticleRemote ejbArticle;%>
	<%
		if(!session.getAttribute("type").equals("J")){
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

		Long longId = new Long(Long.valueOf(request.getParameter("id")));
		ejbArticle.validate(longId);
		response.sendRedirect("accueil.jsp");
	%>
</body>
</html>