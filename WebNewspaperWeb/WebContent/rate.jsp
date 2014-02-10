<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.Arrays"%>
<%@ page import="javax.ejb.EJB"%>
<%@ page import="fr.miage.webnewspaper.bean.session.EJBLoginRemote"%>
<%@ page import="fr.miage.webnewspaper.bean.session.EJBArticleRemote"%>
<%@ page import="fr.miage.webnewspaper.bean.entity.User"%>
<%@ page import="fr.miage.webnewspaper.bean.entity.Article"%>
<%@ page import="fr.miage.webnewspaper.bean.entity.Reader"%>
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
<title>Noter un article</title>
</head>
<body>
		<%!@EJB
	EJBArticleRemote ejbArticle;%>
		<%
			if(!session.getAttribute("type").equals("R")){
				response.sendRedirect("logout.jsp");
			}
			try {
				Context context = new InitialContext();
				if (context != null) {
					ejbArticle = (EJBArticleRemote) context.lookup("java:global/WebNewspaper/WebNewspaperEJB/EJBArticle!fr.miage.webnewspaper.bean.session.EJBArticleRemote");
				}
			} catch (Exception e) {
				System.err.println(e.getMessage());
			}
			EJBLoginRemote ejbLogin = (EJBLoginRemote)session.getAttribute("ejbLogin");
			if(ejbLogin != null && ejbLogin.isLogged()){
				Long longId = new Long(Long.parseLong(request.getParameter("id")));
				System.err.println(request.getParameter("optionsRadios"));
				Integer intScore = new Integer(Integer.valueOf(request.getParameter("optionsRadios")));
				Reader reader = (Reader)ejbLogin.getUser();
				ejbArticle.rateArticle(longId, intScore, reader);
				ejbLogin.setUser(reader);
				session.setAttribute("user", reader);
				response.sendRedirect("view-article.jsp?id="+longId);
			}else{
				response.sendRedirect("login.jsp");
			}
		%>
</body>
</html>