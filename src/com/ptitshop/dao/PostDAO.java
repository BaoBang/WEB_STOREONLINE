package com.ptitshop.dao;

import java.util.List;

import com.ptitshop.entities.Post;

public interface PostDAO {
	public List<Post> findAll();
	public List<Post> findAllByPagination(int page);
	public int getTotalPage();
	public Post findById(int postId);
	public Post findBySlug(String slug);
	public List<Post> findByStatus(int status, int page);
	public int getTotalPageByStatus(int status);
	public List<Post> getTopByStatus(int status);
	
	public void updateNumberView(Post post);
	public void add(Post post);
	public void update(Post post);
	public void delete(Post post);
	
	public List<Post> findRecentlyAddedPosts(int quantity);
	public int getTotalPosts();
}
