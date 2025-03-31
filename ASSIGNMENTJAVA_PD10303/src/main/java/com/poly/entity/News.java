package com.poly.entity;

import java.util.Date;

public class News {
	private String id;
	private String title;
	private String content;
	private String image;
	private Date postedDate;
	private String author;
	private String authorName;
	private int viewCount;
	private Categories categoryid;
	private boolean home;
	private String extraDetails;

	public String getExtraDetails() {
		return extraDetails;
	}

	public void setExtraDetails(String extraDetails) {
		this.extraDetails = extraDetails;
	}

	public News(String extraDetails) {
		super();
		this.extraDetails = extraDetails;
	}

	public News() {
		super();
	}

	public News(String id, String title, String content, String image, Date postedDate, String author,
			String authorName, int viewCount, Categories categoryid, boolean home) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
		this.image = image;
		this.postedDate = postedDate;
		this.author = author;
		this.authorName = authorName;
		this.viewCount = viewCount;
		this.categoryid = categoryid;
		this.home = home;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Date getPostedDate() {
		return postedDate;
	}

	public void setPostedDate(Date postedDate) {
		this.postedDate = postedDate;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getAuthorName() {
		return authorName;
	}

	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public Categories getCategoryid() {
		return categoryid;
	}

	public void setCategoryid(Categories categoryid) {
		this.categoryid = categoryid;
	}

	public boolean isHome() {
		return home;
	}

	public void setHome(boolean home) {
		this.home = home;
	}

	@Override
	public String toString() {
		return "News [id=" + id + ", title=" + title + ", content=" + content + ", image=" + image + ", postedDate="
				+ postedDate + ", author=" + author + ", authorName=" + authorName + ", viewCount=" + viewCount
				+ ", categoryid=" + categoryid + ", home=" + home + "]";
	}

}
