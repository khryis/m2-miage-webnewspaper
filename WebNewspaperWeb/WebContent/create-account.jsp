<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.Arrays"%>
<%@ page import="javax.ejb.EJB"%>
<%@ page
	import="fr.miage.webnewspaper.bean.session.EJBCreateAccountRemote"%>
<%@ page
	import="fr.miage.webnewspaper.bean.session.EJBLoginRemote"%>
<%@ page import="fr.miage.webnewspaper.bean.entity.User"%>
<%@ page import="java.util.Properties"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.Context"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII" />
<link href="css/bootstrap.min.css" rel="stylesheet" />
<title>Create account</title>
</head>

<body>
	<div class="container">
		<%!@EJB
	EJBCreateAccountRemote ejbCreateAccount;
	@EJB
	EJBLoginRemote ejbLogin;%>
		<%
			try {

				Properties props = new Properties();
				props.setProperty("org.omg.CORBA.ORBInitialHost", "localhost");
				props.setProperty("org.omg.CORBA.ORBInitialPort", "3700");
				Context context = new InitialContext(props);
				if (context != null) {
					ejbCreateAccount = (EJBCreateAccountRemote) context
							.lookup("java:global/WebNewspaper/WebNewspaperEJB/EJBCreateAccount!fr.miage.webnewspaper.bean.session.EJBCreateAccountRemote");
					ejbLogin = (EJBLoginRemote) context
							.lookup("java:global/WebNewspaper/WebNewspaperEJB/EJBLogin!fr.miage.webnewspaper.bean.session.EJBLoginRemote");
				}
			} catch (Exception e) {
				System.err.println(e.getMessage());
			}

			if (request.getMethod() == "POST") {
				User user = new User();
				if (request.getParameter("email") != null
						&& request.getParameter("password") != null) {
					if(ejbCreateAccount.createAccount(user)){
						session.setAttribute("ejbLogin", ejbLogin);
						response.sendRedirect("accueil.jsp");
					}
				}
			}
		%>
		<jsp:useBean id="EJBcreateAccount"
			class="fr.miage.webnewspaper.bean.entity.User" scope="request">
			<jsp:setProperty name="EJBcreateAccount" property="*" />
		</jsp:useBean>

		<form action="create-account.jsp" method="POST">
			<div class="form-group">
				<label>Adresse email</label> <input type="email"
					class="form-control" name="email" placeholder="Enter email">
			</div>
			<div class="form-group">
				<label>Password</label> <input type="password" name="password"
					class="form-control" placeholder="Password">
			</div>
			<div class="form-group">
				<label>Prénom</label> <input type="text" name="firstName"
					class="form-control">
			</div>
			<div class="form-group">
				<label>Nom</label> <input type="text" name="lastName"
					class="form-control">
			</div>
			<div class="form-group">
				<label>Adresse</label> <input type="text" name="address"
					class="form-control">
			</div>
			<div class="form-group">
				<label>Anniversaire</label> <input type="date" name="birthDate"
					class="form-control">
			</div>
			<button type="submit" class="btn btn-default">Se connecter</button>
		</form>
	</div>
</body>
</html>