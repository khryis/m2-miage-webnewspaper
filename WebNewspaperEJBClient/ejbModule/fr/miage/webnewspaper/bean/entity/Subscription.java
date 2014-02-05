package fr.miage.webnewspaper.bean.entity;

import java.util.Date;

public class Subscription {
	private Long id;
	private Date subscriptionDate;
	private Date subscriptionEndDate;
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
	
	
}
