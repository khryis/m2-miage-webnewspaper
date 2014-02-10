package resources;

import java.io.IOException;

import javax.servlet.DispatcherType;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fr.miage.webnewspaper.bean.session.EJBLoginRemote;

/**
 * Servlet Filter implementation class FilterLogin
 */
@WebFilter(dispatcherTypes = { DispatcherType.REQUEST, DispatcherType.FORWARD, DispatcherType.ERROR}, 
		urlPatterns = { "/accueil.jsp", "/view-article.jsp", "/add-article.jsp",
						"/modify-article.jsp", "/read-article.jsp", "/subscribe.jsp",
						"/logout.jsp", "/rate.jsp", "/comment.jsp",})
public class FilterLogin implements Filter {

	private String contextPath;

	/**
	 * Default constructor.
	 */
	public FilterLogin() {
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		EJBLoginRemote ejbLogin = (EJBLoginRemote)req.getSession().getAttribute("ejbLogin");
		// Si sur une page privée alors qu'il n'as pas de session, redirect index
		if (ejbLogin == null || !ejbLogin.isLogged()) { 
			res.sendRedirect(contextPath + "/index.jsp");
		} else {
			// Si achat en cours
			Long articleToBuyId = (Long)req.getSession().getAttribute("articleToBuyId");
			if(articleToBuyId != null && articleToBuyId != 0){
				res.sendRedirect(contextPath + "/buy-article.jsp?id="+req.getSession().getAttribute("articleToBuyId"));
			}
			// Si arrive sur l'index alors qu'il a une session en cours
			if(req.getRequestURI().contains("index.jsp")){
				if (ejbLogin != null && ejbLogin.isLogged()) {
					res.sendRedirect(contextPath + "/accueil.jsp");
				}
			}
		}
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		contextPath = fConfig.getServletContext().getContextPath();
	}

}
