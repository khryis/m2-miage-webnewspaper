package fr.miage.webnewspaper.bean.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

@Entity
@Table(name="ADMINISTRATOR")
@NamedQueries({
    @NamedQuery(name="Administrator.findAll",
                query="SELECT a.id, a.email FROM Administrator a"),
    @NamedQuery(name="Administrator.findByEmail",
                query="SELECT a FROM Administrator a WHERE a.email = :email"),
}) 
public class Administrator {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	@Column(unique=true)
	private String email;
	private String password;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String p) {
		password = p;
	}
	
	
}
