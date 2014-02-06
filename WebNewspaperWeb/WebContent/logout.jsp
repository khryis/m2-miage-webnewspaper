<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.Arrays"%>
<%@ page import="javax.ejb.EJB"%>
<%@ page import="fr.miage.webnewspaper.bean.session.EJBLoginRemote"%>
<%@ page import="java.util.Properties"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.Context"%>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII" />
<link href="css/bootstrap.min.css" rel="stylesheet" />
<title>Logout</title>
</head>

<body>
	<div class="container">
		<%!@EJB
	EJBLoginRemote ejbLogin; %>
		<%
			// on nettoie la session
			session.removeAttribute("ejbLogin");
			session.removeAttribute("type");
			session.invalidate();
			response.sendRedirect("index.jsp");
		%>
	</div>
</body>
</html>