package com.ptitshop.models;

import java.util.ArrayList;
import java.util.List;

import com.ptitshop.entities.Product;

public class CartList {
	private int totalProduct;
	private double totalPrice;
	private List<Cart> carts;

	public CartList() {
		super();
		this.totalProduct = 0;
		this.totalPrice = 0.0d;
		this.carts = new ArrayList<Cart>();
	}

	public CartList(int totalProduct, double totalPrice, List<Cart> carts) {
		super();
		this.totalProduct = totalProduct;
		this.totalPrice = totalPrice;
		this.carts = carts;
	}

	public void addCart(Cart cart) {
		if (carts == null ||carts.isEmpty()){
			totalProduct += cart.getQuantity();
			totalPrice += (cart.getProduct().getSalePrice() > 0.0d ? cart.getProduct().getSalePrice() : cart.getProduct().getPrice());
			carts = new ArrayList<Cart>();
			carts.add(cart);
		} else {
			boolean check = false;
			for (Cart c : carts) {
				if (c.getProduct().getId() == cart.getProduct().getId()) { 
					carts.get(carts.indexOf(c)).setQuantity(c.getQuantity() + cart.getQuantity());
					check = true;
					break;
				}
			}
			if (!check) carts.add(cart);
			
			totalProduct += cart.getQuantity();
			totalPrice += (cart.getProduct().getSalePrice() > 0.0d ? cart.getProduct().getSalePrice() : cart.getProduct().getPrice());
		}
	}

	public boolean removeCart(Product product) {
		if (carts != null && !carts.isEmpty())
			for (Cart c : carts)
				if (c.getProduct().getId() == product.getId()) {
					totalProduct -= c.getQuantity();
					totalPrice -= (c.getProduct().getSalePrice() > 0.0d ? c.getProduct().getSalePrice() : c.getProduct().getSalePrice());
					carts.remove(carts.indexOf(c));
					return true;
				}
		return false;
	}
	
	public void refreshAll(){
		this.totalProduct = 0;
		this.totalPrice = 0.0d;
		this.carts = new ArrayList<Cart>();
	}
	
	public String writeToJson(){
		
		/*JsonObject obj = new JsonObject();
		obj.addProperty("total_product", new Integer(totalProduct));
		obj.addProperty("total_price", new Double(totalPrice));
		
		JsonArray arr = new JsonArray();
		for (Cart cart : carts) {
			JsonObject item = new JsonObject();
			item.addProperty("quantity", new Integer(cart.getQuantity()));
			
		
		}*/
		
		String json = "";
		json = "{\"total_product\":" + totalProduct + ","
				+ "\"total_price\":" + "\"" + String.format("%.1f", totalPrice) + "\"" +  ","
				+ "\"cart_list\":[";
				for (int i = 0; i < carts.size(); i++) {
					Cart cart = carts.get(i);
					json += "{";
					json += 	("\"quantity\":" + cart.getQuantity() + "," );
					json += 	"\"product\":{";
					json += 		("\"id\":" + cart.getProduct().getId() + ",");
					json += 		("\"image\":\"" + cart.getProduct().getImage() + "\"" + "," );
					json += 		("\"name\":\"" + cart.getProduct().getName() + "\"" + ",");
					json += 		("\"price\":" + "\"" + String.format("%.1f", (cart.getProduct().getSalePrice() > 0.0d ? cart.getProduct().getSalePrice() : cart.getProduct().getPrice()))) + "\"";
					json += 	"}";
					json += "}";
					if (i < carts.size()-1) json += ",";
				}
		json += 	"]";
		json += "}";
		return json;
	}

	public int getTotalProduct() {
		return totalProduct;
	}

	public void setTotalProduct(int totalProduct) {
		this.totalProduct = totalProduct;
	}

	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public List<Cart> getCarts() {
		return carts;
	}

	public void setCarts(List<Cart> carts) {
		this.carts = carts;
	}

}
