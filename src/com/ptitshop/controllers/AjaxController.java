package com.ptitshop.controllers;

import java.io.IOException;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.ptitshop.dao.AccountDAO;
import com.ptitshop.dao.BrandDAO;
import com.ptitshop.dao.CategoryDAO;
import com.ptitshop.dao.PostDAO;
import com.ptitshop.dao.ProductDAO;
import com.ptitshop.dao.ProductDetailDAO;
import com.ptitshop.dao.ProductImageDAO;
import com.ptitshop.dao.PromotionDAO;
import com.ptitshop.entities.Account;
import com.ptitshop.entities.Brand;
import com.ptitshop.entities.Category;
import com.ptitshop.entities.Post;
import com.ptitshop.entities.Product;
import com.ptitshop.entities.ProductImage;
import com.ptitshop.entities.Promotion;
import com.ptitshop.models.Cart;
import com.ptitshop.models.CartList;
import com.ptitshop.utils.Constants;
import com.ptitshop.utils.BCryptEncoder;

@Controller
@Transactional
@EnableWebMvc
@RequestMapping(value = "/ajax")
public class AjaxController {

	@Autowired
	private ProductDAO productDAO;
	@Autowired
	private AccountDAO accountDAO;
	@Autowired
	private BrandDAO brandDAO;
	@Autowired
	private PostDAO postDAO;
	@Autowired
	private CategoryDAO categoryDAO;
	@Autowired
	private ProductImageDAO productImageDAO;
	@Autowired
	private PromotionDAO promotionDAO;
	@Autowired
	private ProductDetailDAO productDetailDAO;

	/*******************************************************************************************/
	/**************************************** TAM **********************************************/
	/*******************************************************************************************/
	@ResponseBody
	@RequestMapping(value = { "/add-to-cart" }, method = RequestMethod.GET)
	public String addToCartAJAX(HttpServletRequest request,
			@RequestParam(name = "product_id", required = true) int productId,
			@RequestParam(name = "quantity", required = false, defaultValue = "1") int quantity) {

		System.out.println("## AJAX add-to-cart: " + productId);

		Product product = productDAO.findById(productId);
		if (product.getProductDetail().getQuantity() >= quantity) {

			Cart cart = new Cart(quantity, product);

			HttpSession session = request.getSession();

			CartList cartList = (CartList) session.getAttribute("CART_LIST");
			if (cartList == null)
				cartList = new CartList();

			cartList.addCart(cart);
			session.setAttribute("CART_LIST", cartList);
			return product.getName();
		} else {
			return "false";
		}
	}

	@ResponseBody
	@RequestMapping(value = "/remove-product-from-cart", method = RequestMethod.GET)
	public String removeProductFromCarts(HttpServletRequest request,
			@RequestParam(name = "product_id", required = true) int productId) {

		System.out.println("## AJAX reomve from carts: " + productId);
		Product product = productDAO.findById(productId);
		if (product != null) {
			HttpSession session = request.getSession();
			CartList cartList = (CartList) session.getAttribute("CART_LIST");
			if (cartList != null) {
				boolean result = cartList.removeCart(product);
				if (result)
					return "true";
			}
		}
		return "false";
	}

	@RequestMapping(value = "/cart-list", method = RequestMethod.GET)
	public String getCartList(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		CartList cartList = (CartList) session.getAttribute("CART_LIST");
		model.addAttribute("cart_list", cartList);
		return "/includes/_cart-list";
	}
	
	@ResponseBody
	@RequestMapping(value = "/get-total-product")
	public String getTotalProductInCart(HttpServletRequest request) {
		HttpSession session = request.getSession();
		CartList cartList = (CartList) session.getAttribute("CART_LIST");
		return String.valueOf(cartList.getTotalProduct());
	}
	
	@ResponseBody
	@RequestMapping(value = "/get-total-price")
	public String getTotalPriceInCart(HttpServletRequest request) {
		HttpSession session = request.getSession();
		CartList cartList = (CartList) session.getAttribute("CART_LIST");
		return "<fmt:formatNumber value=\""+ cartList.getTotalPrice() +"\" type=\"currency\"/>";
	}
	

	@ResponseBody
	@RequestMapping(value = { "/delete-post-with-ajax" }, method = RequestMethod.GET)
	public String deletePostWithAjax(@RequestParam(required = true, name = "post_id") int postId) {
		Post post = postDAO.findById(postId);
		if (post != null) {
			postDAO.delete(post);
			return "true";
		}
		return "false";
	}

	@ResponseBody
	@RequestMapping(value = { "/delete-caregory-with-ajax" }, method = RequestMethod.GET)
	public String deleteCategoryWithAjax(@RequestParam(required = true, name = "category_id") int categoryId) {
		Category category = categoryDAO.findById(categoryId);
		if (category != null) {
			categoryDAO.delete(category);
			return "true";
		}
		return "false";
	}

	/*******************************************************************************************/
	/*************************************** BANG **********************************************/
	/*******************************************************************************************/

	@ResponseBody
	@RequestMapping(value = "/check-user-name", method = RequestMethod.GET)
	public String checkUserName(HttpServletResponse response,
			@RequestParam(name = "username", required = true) String userName) throws IOException {
		if (accountDAO.checkUserName(userName) || userName.equals("")) {
			// return "<img src=\"/PTiTShop/images/not-available.png\"/>";
			return "not-available";
		} else {
			// return "<img src=\"/PTiTShop/images/available.png\"/>";
			return "available";
		}
	}

	@ResponseBody
	@RequestMapping(value = "/check-password-confirm", method = RequestMethod.GET)
	public String checkPassWordComfirm(HttpServletResponse response,
			@RequestParam(name = "password", required = true) String password,
			@RequestParam(name = "passwordComfirm", required = true) String passwordConfirm) throws IOException {
		
		if (password.compareTo("") == 0 && passwordConfirm.compareTo("") == 0) {
			return "not-available";
		}
		if (password.compareTo(passwordConfirm) != 0) {
			return "not-available";
		} else {
			return "available";
		}
	}

	@ResponseBody
	@RequestMapping(value = "/check-password", method = RequestMethod.GET)
	public String checkPassWord(HttpServletResponse response,
			@RequestParam(name = "password", required = true) String password) throws IOException {
		if (password.equals("")) {
			return "not-available";
		} else {
			return "available";
		}
	}

	@ResponseBody
	@RequestMapping(value = "/check-name", method = RequestMethod.GET)
	public String checkName(HttpServletResponse response,
			@RequestParam(name = "lastname", required = true) String lastName) throws IOException {

		if (lastName.equals("")) {
			return "not-available";
		} else {
			return "available";
		}
	}

	@ResponseBody
	@RequestMapping(value = "/check-old-password", method = RequestMethod.GET)
	public String checkOldPassWord(HttpServletResponse response,
			@RequestParam(name = "username", required = true) String userName,
			@RequestParam(name = "password", required = true) String password) throws IOException {
		Account user = accountDAO.findByUserName(userName);
		BCryptEncoder encoder = new BCryptEncoder();
		if (user != null) {

			if (encoder.matches(password, user.getPasswordHash()))
				return "available";
		}
		return "not-available";

	}

	@ResponseBody
	@RequestMapping(value = "/remove-brand", method = RequestMethod.GET)
	public String removeBrand(HttpServletRequest request,
			@RequestParam(name = "brand_id", required = true) int brandId) {

		System.out.println("## AJAX reomve from csdl: " + brandId);
		Brand brand = brandDAO.findById(brandId);
		if (brand != null) {

			boolean result = brandDAO.remove(brand);
			if (result)
				return "true";
		}
		return "false";
	}

	@ResponseBody
	@RequestMapping(value = "/remove-product", method = RequestMethod.GET)
	public String removeProduct(HttpServletRequest request,
			@RequestParam(name = "product_id", required = true) int productId) {

		System.out.println("## AJAX reomve from csdl: " + productId);
		Product product = productDAO.findById(productId);
		if (product != null) {

			List<ProductImage> images = productImageDAO.findByProducDetailtId(product.getProductDetail().getId());
			boolean resultImages = false;
			for (ProductImage image : images) {
				System.out.println("id: " + image.getId());
				resultImages = productImageDAO.remove(image);
				if (!resultImages)
					return "false";
			}
			boolean result = productDAO.remove(product);
			if (!result)
				return "false";
			boolean resultDetail = productDetailDAO.remove(product.getProductDetail());
			if (!resultDetail)
				return "false";
			return "true";
		}
		return "false";
	}

	@ResponseBody
	@RequestMapping(value = "/remove-promotion", method = RequestMethod.GET)
	public String removePromotion(HttpServletRequest request,
			@RequestParam(name = "promotion_id", required = true) int promotionId) {

		System.out.println("## AJAX reomve from csdl: " + promotionId);
		Promotion promotion = promotionDAO.findById(promotionId);
		if (promotion != null) {

			boolean result = promotionDAO.remove(promotion);
			if (result)
				return "true";
		}
		return "false";
	}

	@SuppressWarnings("el-syntax")
	@ResponseBody
	@RequestMapping(value = "/search")
	public String search(HttpServletResponse response, HttpServletRequest request,
			@RequestParam(name = "inputdata", required = true, defaultValue = "") String inputData) throws IOException {
		if (inputData.equals("")) {
			return "";
		}
		List<Product> resultSearchList = productDAO.searchByName(inputData);
		String html = "";
		if (resultSearchList.size() > 0) {
			html += "<div id='number-of-result-search'>" + resultSearchList.size() + "</div>";
		}
		html += "<ul>";
		int index = 0;
		for (Product p : resultSearchList) {
			html += "<li><a class=\"link\" href=\"product?product_id="+p.getId() +"\"><p><img src=\"" + p.getImage() + "\"alt=\"" + p.getName() + "\" ></p><div><h3>"
					+ p.getName() + "</h3><del class=\"search-price\">"+String.format("%,d",(int)p.getPrice())+"</del><span class=\"search-price\">"+String.format("%,d",(int) p.getSalePrice())+"</span></div></a></li>";
			if (++index == 5)
				break;
		}
		html += "</ul>";
		if (resultSearchList.size() > 5) {
			html += "<div><a class=\"link\" href=\"" + request.getContextPath() + "/search?q=" + inputData + "\">Xem thêm</a></div>";
		}
		return html;

	}
}
