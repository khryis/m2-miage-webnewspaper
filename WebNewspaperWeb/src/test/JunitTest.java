package test;

import static org.junit.Assert.*;

import org.junit.Test;

import java.util.Properties;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import fr.miage.webnewspaper.bean.entity.Administrator;
import fr.miage.webnewspaper.bean.entity.Article;
import fr.miage.webnewspaper.bean.entity.Journalist;
import fr.miage.webnewspaper.bean.entity.Reader;
import fr.miage.webnewspaper.bean.entity.User;

import fr.miage.webnewspaper.bean.session.EJBAccountRemote;
import fr.miage.webnewspaper.bean.session.EJBArticleRemote;
import fr.miage.webnewspaper.bean.session.EJBLoginRemote;

public class JunitTest {

	private User userTest = new User();
	private Properties props = new Properties();
	
	private EJBLoginRemote ejbLogin;
	private EJBAccountRemote ejbAccount;
	private EJBArticleRemote ejbArticle;
	
	private String jndiArticle = "java:global/WebNewspaper/WebNewspaperEJB/EJBArticle!fr.miage.webnewspaper.bean.session.EJBArticleRemote";
	private String jndiLogin = "java:global/WebNewspaper/WebNewspaperEJB/EJBLogin!fr.miage.webnewspaper.bean.session.EJBLoginRemote";
	private String jndiAccount = "java:global/WebNewspaper/WebNewspaperEJB/EJBCreateAccount!fr.miage.webnewspaper.bean.session.EJBAccountRemote";
	
	private void init(){
		props.setProperty("org.omg.CORBA.ORBInitialHost", "localhost");
		props.setProperty("org.omg.CORBA.ORBInitialPort", "36334");
	}
	
	private void initUser(){	
		userTest.setFirstName("candice");
		userTest.setLastName("cruchten");
		userTest.setEmail("candice@gmail.com");
		userTest.setPassword("password");
		userTest.setAddress("candice address");
	}
	
	/* 
	 * 
	 * Test des fonctions de connexion
	 * 
	 */
	@Test
	public void checkUserTest(){
		boolean result;
		
		init();
		try {
			Context context = new InitialContext(props);
			
			if (context != null) {
				ejbLogin = (EJBLoginRemote) context
						.lookup(this.jndiLogin);
			
				result = ejbLogin.checkUser("test", "test");
				assert(result);
			}
		} catch (NamingException e) {
			e.printStackTrace();
		}		
	}
	
	
	/* 
	 * 
	 * Test des fonctions de création de compte
	 * 
	 */
	@Test
	public void createAccountReaderTest(){
		boolean result;
		Reader r = new Reader();
		initUser();
		
		r.setId(userTest.getId());
		r.setFirstName(userTest.getFirstName());
		r.setLastName(userTest.getLastName());
		r.setAddress(userTest.getAddress());
		r.setEmail(userTest.getEmail());
		r.setPassword(userTest.getPassword());
				
		init();
		try {
			Context context = new InitialContext(props);
			
			if (context != null) {
				ejbCreateAccount = (EJBCreateAccountRemote) context
						.lookup(this.jndiCreate);
				
				result = ejbCreateAccount.createAccountReader(r);
				assert(result);
			}
		} catch (NamingException e) {
			e.printStackTrace();
		}
		
	}
	
	@Test
	public void createAccountJournalistTest(){
		boolean result;
		Journalist j = new Journalist();
		
		j.setId(userTest.getId());
		j.setFirstName(userTest.getFirstName());
		j.setLastName(userTest.getLastName());
		j.setAddress(userTest.getAddress());
		j.setEmail(userTest.getEmail());
		j.setPassword(userTest.getPassword());
				
		
		init();
		try {
			Context context = new InitialContext(props);
			
			if (context != null) {
				ejbCreateAccount = (EJBCreateAccountRemote) context
						.lookup(this.jndiCreate);
				
				result = ejbCreateAccount.createAccountJournalist(j);
				assert(result);
			}
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void createAccountAdministratorTest(){
		boolean result;
		Administrator a = new Administrator();
		
		a.setId(userTest.getId());
		a.setFirstName(userTest.getFirstName());
		a.setLastName(userTest.getLastName());
		a.setAddress(userTest.getAddress());
		a.setEmail(userTest.getEmail());
		a.setPassword(userTest.getPassword());
				
		
		init();
		try {
			Context context = new InitialContext(props);
			
			if (context != null) {
				ejbAccount = (EJBAccountRemote) context
						.lookup(this.jndiAccount);
				
				result = ejbAccount.createAccountAdministrator(a);
				assert(result);
			}
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 
	 * Tests des fonctions concernant un article
	 * 
	 */
	
	@Test
	public void getArticleTest(){
		long id = 0;
		Article result;
		Article verif = new Article();
		
		verif.setId(id);
		verif.setTitle("test");
		verif.setContent("test");
		verif.setCreationDate(new Date());
		verif.setIsValidated(true);
		
		init();
		try{
			Context context = new InitialContext(props);
			
			if(context != null){
				ejbArticle = (EJBArticleRemote) context.lookup(this.jndiArticle);
				
				result = ejbArticle.getArticle(id);
				assert(result.equals(true));
			}
		}catch(NamingException e){
			e.printStackTrace();
		}
	}

}
