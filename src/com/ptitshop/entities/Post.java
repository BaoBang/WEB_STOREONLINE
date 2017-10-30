package com.ptitshop.entities;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the posts database table.
 * 
 */
@Entity
@Table(name="posts")
@NamedQueries({
	@NamedQuery(name="Post.findAll", query="SELECT p FROM Post p ORDER BY p.publishDate DESC"),
	@NamedQuery(name="Post.getTotalPage", query="SELECT COUNT(p) FROM Post p"),
	@NamedQuery(name="Post.findBySlug", query="SELECT p FROM Post p WHERE p.slug=:slug"),
	@NamedQuery(name="Post.findByStatus", query="SELECT p FROM Post p WHERE p.status=:status ORDER BY p.publishDate DESC"),
	@NamedQuery(name="Post.getTotalPageByStatus", query="SELECT COUNT(p) FROM Post p WHERE p.status=:status"),
	@NamedQuery(name="Post.findRecentlyAddedPosts", query="SELECT p FROM Post p ORDER BY p.publishDate DESC"),
	@NamedQuery(name="Post.getTotalPosts", query="SELECT COUNT(p) FROM Post p")
})
public class Post implements Serializable {
	private static final long serialVersionUID = 1L;
	
	public static final int STATUS_HIDDEN = 0;
	public static final int STATUS_PUBLISH = 1;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	@Lob
	private String content;

	@Lob
	private String description;

	private String image;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="last_edit")
	private Date lastEdit;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="publish_date")
	private Date publishDate;

	private String slug;

	private int status;

	private String title;

	private int views;

	//bi-directional many-to-one association to Account
	@ManyToOne
	private Account account;

	public Post() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImage() {
		return this.image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Date getLastEdit() {
		return this.lastEdit;
	}

	public void setLastEdit(Date lastEdit) {
		this.lastEdit = lastEdit;
	}

	public Date getPublishDate() {
		return this.publishDate;
	}

	public void setPublishDate(Date publishDate) {
		this.publishDate = publishDate;
	}

	public String getSlug() {
		return this.slug;
	}

	public void setSlug(String slug) {
		this.slug = slug;
	}

	public int getStatus() {
		return this.status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getViews() {
		return this.views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public Account getAccount() {
		return this.account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

}