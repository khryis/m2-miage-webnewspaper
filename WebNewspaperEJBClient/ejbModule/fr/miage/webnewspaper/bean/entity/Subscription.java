package fr.miage.webnewspaper.bean.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.eclipse.persistence.annotations.CascadeOnDelete;

@Entity
@Table(name = "SUBSCRIPTION")
@NamedQueries({
		@NamedQuery(name = "Subscription.findAll", query = "SELECT s FROM Subscription s"),
		@NamedQuery(name = "Subscription.findById", query = "SELECT s FROM Subscription s WHERE s.id = :id"),
		@NamedQuery(name = "Subscription.findByUserId", query = "SELECT s FROM Subscription s WHERE s.reader = :reader"), })
@CascadeOnDelete
public class Subscription implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	@Temporal(value = TemporalType.DATE)
	private Date subscriptionDate;
	@Temporal(value = TemporalType.DATE)
	private Date subscriptionEndDate;
	@OneToOne(fetch = FetchType.EAGER, orphanRemoval=true, mappedBy="subscription", cascade={CascadeType.ALL})
	@CascadeOnDelete
	private Reader reader;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Date getSubscriptionDate() {
		return subscriptionDate;
	}

	public void setSubscriptionDate(Date subscriptionDate) {
		this.subscriptionDate = subscriptionDate;
	}

	public Date getSubscriptionEndDate() {
		return subscriptionEndDate;
	}

	public void setSubscriptionEndDate(Date subscriptionEndDate) {
		this.subscriptionEndDate = subscriptionEndDate;
	}

	public Reader getReader() {
		return reader;
	}

	public void setReader(Reader reader) {
		this.reader = reader;
	}

}
