package com.ptitshop.entities;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the order_details database table.
 * 
 */
@Entity
@Table(name="order_details")
@NamedQueries({
	@NamedQuery(name="OrderDetail.findAll", query="SELECT o FROM OrderDetail o"),
	@NamedQuery(name="OrderDetail.findByOrderId", query="SELECT o FROM OrderDetail o WHERE order.id=:orderId")
})
public class OrderDetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	private double discount;

	private double price;

	private int quantity;

	//bi-directional many-to-one association to Order
	@ManyToOne
	private Order order;

	//bi-directional many-to-one association to Product
	@ManyToOne
	private Product product;

	public OrderDetail() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public double getDiscount() {
		return this.discount;
	}

	public void setDiscount(double discount) {
		this.discount = discount;
	}

	public double getPrice() {
		return this.price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getQuantity() {
		return this.quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Order getOrder() {
		return this.order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public Product getProduct() {
		return this.product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

}