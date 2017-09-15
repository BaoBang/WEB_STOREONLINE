package com.ptitshop.models;

import java.util.List;

public class ResultPagination<E> {
	private int currentPage;
	private int totalPage;
	private List<E> list;

	public ResultPagination() {
		super();
	}

	public ResultPagination(int currentPage, int totalPage, List<E> list) {
		super();
		this.currentPage = currentPage;
		this.totalPage = totalPage;
		this.list = list;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public List<E> getList() {
		return list;
	}

	public void setList(List<E> list) {
		this.list = list;
	}

}
