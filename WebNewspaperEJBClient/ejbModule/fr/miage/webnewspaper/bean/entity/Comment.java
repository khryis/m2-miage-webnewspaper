package fr.miage.webnewspaper.bean.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="COMMENT")
public class Comment implements Serializable{

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String content;
	@Temporal(value=TemporalType.DATE)
	private Date commentDate;
	
	@OneToOne(fetch = FetchType.EAGER)
	private Reader writer;
	@OneToOne(fetch = FetchType.EAGER)
	private Article ofArticle;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCommentDate() {
		return commentDate;
	}
	public void setCommentDate(Date commentDate) {
		this.commentDate = commentDate;
	}
	public Reader getWriter() {
		return writer;
	}
	public void setWriter(Reader writer) {
		this.writer = writer;
	}
	public Article getOfArticle() {
		return ofArticle;
	}
	public void setOfArticle(Article ofArticle) {
		this.ofArticle = ofArticle;
	}
}