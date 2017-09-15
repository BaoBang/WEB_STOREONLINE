package com.ptitshop.controllers;

import java.security.Principal;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.ptitshop.dao.AccountDAO;
import com.ptitshop.dao.AccountProfileDAO;
import com.ptitshop.dao.BrandDAO;
import com.ptitshop.dao.CategoryDAO;
import com.ptitshop.dao.OrderDAO;
import com.ptitshop.dao.OrderDetailDAO;
import com.ptitshop.dao.PostDAO;
import com.ptitshop.dao.ProductDAO;
import com.ptitshop.dao.ProductImageDAO;
import com.ptitshop.entities.Account;
import com.ptitshop.entities.AccountProfile;
import com.ptitshop.entities.Brand;
import com.ptitshop.entities.Category;
import com.ptitshop.entities.Order;
import com.ptitshop.entities.OrderDetail;
import com.ptitshop.entities.Post;
import com.ptitshop.entities.Product;
import com.ptitshop.entities.ProductImage;
import com.ptitshop.models.Cart;
import com.ptitshop.models.CartList;
import com.ptitshop.models.ResultPagination;
import com.ptitshop.utils.Constants;
import com.ptitshop.utils.MD5Hash;

@Controller
@Transactional
@EnableWebMvc
public class MainController {
	
	@Autowired
	private AccountDAO accountDAO;
	
	@Autowired
	private AccountProfileDAO accountProfileDAO;

	@Autowired
	private BrandDAO brandDAO;
	
	@Autowired
	private CategoryDAO categoryDAO;
	
	@Autowired
	private OrderDAO orderDAO;
	
	@Autowired
	private OrderDetailDAO orderDetailDAO;
	
	@Autowired
	private ProductDAO productDAO;
	
	@Autowired
	private ProductImageDAO productImageDAO;
	
	@Autowired
	private PostDAO postDAO;
	
	private void loadData(Model model){
		List<Category> categoryList = categoryDAO.findByStatus(Category.STATUS_PUBLISH);
		List<Brand> brandList = brandDAO.findByStatus(Brand.STATUS_PUBLISH);
	
		model.addAttribute("category_list", categoryList);
		model.addAttribute("brand_list", brandList);
	}
	
	/*******************************************************************************************/
	/************************************ ERROR PAGE *******************************************/
	/*******************************************************************************************/
	@RequestMapping(value="/404", method=RequestMethod.GET)
	public String error404() {
		return "404";
	}
	
	@RequestMapping(value="/403", method=RequestMethod.GET)
	public String error403() {
		return "403";
	}
	/*******************************************************************************************/
	/************************************* ACCOUNT *********************************************/
	/*******************************************************************************************/
	@RequestMapping(value={"/login"}, method=RequestMethod.GET)
	public String login(Model model){
		loadData(model);
		return "login";
	}
	
	@RequestMapping(value = { "/logout" }, method = RequestMethod.GET)
	public String logout(Model model, HttpServletRequest request, Principal principal) {
		loadData(model);

		return "login";
	}
	
	@RequestMapping(value = { "/register" }, method = RequestMethod.GET)
	public String register(Model model, HttpServletRequest request,
			@RequestParam(required = false, name = "username", defaultValue = "") String userName,
			@RequestParam(required = false, name = "firstname", defaultValue = "") String firstName,
			@RequestParam(required = false, name = "lastname", defaultValue = "") String lastName,
			@RequestParam(required = false, name = "passWord", defaultValue = "") String passWord,
			@RequestParam(required = false, name = "passWordComfirm", defaultValue = "") String passWordComfirm) {
		loadData(model);

		if (request.getParameter("btnSubmit") != null) {

			Account user = new Account();
			user.setLastName(firstName);
			user.setFirstName(lastName);
			user.setUserName(userName);
			user.setSalt(MD5Hash.getSalt());
			user.setPasswordHash(MD5Hash.MD5Encrypt(passWord + user.getSalt()));
			user.setRole(Constants.DEFAULT_ROLE);
			user.setId(Constants.DEUFAULT_ID);
			user.setAvatar(Constants.DEFAULT_AVATAR);
			user.setCreatedAt(new Date());
			user.setStatus(Constants.DEFAULT_STATUS);
			AccountProfile accountProfile = new AccountProfile();
			accountProfile.setGender(Constants.DEFAULT_GENDER);
			accountProfileDAO.insert(accountProfile);
			user.setAccountProfile(accountProfile);
			accountDAO.insert(user);
			return "login";
		}

		return "register";
	}
	
	@RequestMapping(value = "/profile")
	public String profile(Model model,HttpServletRequest request,
			@RequestParam(name = "username", defaultValue = "", required = false) String userName,
			@RequestParam(name = "lastname", defaultValue = "", required = false) String lastName,
			@RequestParam(name = "firstname", defaultValue = "", required = false) String firstName,
			@RequestParam(name = "gender", defaultValue = "1" , required = false) int gender,
			@RequestParam(name = "phone", defaultValue = "", required = false) String phone,
			@RequestParam(name = "address",defaultValue = "", required = false) String address,
			@RequestParam(name = "email", defaultValue = "", required = false) String email,
			@RequestParam(name = "biography", defaultValue = "", required = false) String biography,
			@RequestParam(name = "new-pass", defaultValue = "", required = false) String password
			){
		
		loadData(model);
		String profileMessage = "";
		if(request.getParameter("submit-info") != null){
			Account user = accountDAO.findByUserName(userName);
			if(user != null){
				AccountProfile accountProfile = user.getAccountProfile();
				user.setFirstName(firstName);
				user.setLastName(lastName);
				accountProfile.setAddress(address);
				accountProfile.setBiography(biography);
				accountProfile.setEmail(email);
				System.out.println("gender " + gender);
				accountProfile.setGender(gender);
				accountProfile.setPhone(phone);
				user.setAccountProfile(accountProfile);
				accountProfileDAO.update(accountProfile);
				accountDAO.update(user);
				profileMessage = "Cập nhật thành công";
			}else{
				profileMessage = "Cập nhật thất bại";
			}
		}

		if(request.getParameter("submit-pass") != null){
			Account user = accountDAO.findByUserName(userName);
			if(user != null){
				String passwordHash = MD5Hash.MD5Encrypt(password + user.getSalt());
				user.setPasswordHash(passwordHash);
				accountDAO.update(user);
				profileMessage = "Cập nhật thành công";
			}else{
				profileMessage = "Cập nhật thất bại";
			}
		}
		Account user = accountDAO.findByUserName(userName);
		model.addAttribute("user",user);
		System.out.println("User gender " + user.getAccountProfile().getGender());
		model.addAttribute("profileMessage",profileMessage);
		return "profile";
	}
	
	/*******************************************************************************************/
	/************************************* HOME PAGE *******************************************/
	/*******************************************************************************************/
	@RequestMapping(value={"/home"}, method=RequestMethod.GET)
	public String home(Model model){
		loadData(model);
		List<Product> phones = productDAO.getTopProductByCategoryId(Constants.PHONE_CATEGORY_ID, Product.STATUS_PUBLISH);
		List<Product> tablets = productDAO.getTopProductByCategoryId(Constants.TABLET_CATEGORY_ID, Product.STATUS_PUBLISH);
		List<Product> laptops = productDAO.getTopProductByCategoryId(Constants.LAPTOP_CATEGORY_ID, Product.STATUS_PUBLISH);
		List<Post> posts = postDAO.getTopByStatus(Post.STATUS_PUBLISH);
		model.addAttribute("phones", phones);
		model.addAttribute("tablets", tablets);
		model.addAttribute("laptops", laptops);
		model.addAttribute("posts",posts);
		return "index";
	}
	
	/*******************************************************************************************/
	/********************************* PRODUCT PAGE ********************************************/
	/*******************************************************************************************/
	@RequestMapping(value = "/product", method = RequestMethod.GET)
	public String product(Model model, @RequestParam(required = false, name = "product_id") int productId) {
		Product product = productDAO.findById(productId);
		if (product == null)
			return "redirect:/404";
		else {

			List<ProductImage> productImages = productImageDAO.findByProducDetailtId(product.getProductDetail().getId());
			model.addAttribute("product", product);
			model.addAttribute("productImages", productImages);
			loadData(model);
		}
		return "product";
	}
	
	
	/*******************************************************************************************/
	/********************************* CATEGORY PAGE *******************************************/
	/*******************************************************************************************/
	@RequestMapping(value="/category/{slug}", method=RequestMethod.GET)
	public String category(
			Model model, 
			@PathVariable("slug") String slug,
			@RequestParam(required=false, name="order_by", defaultValue=Constants.SORT_BY_PRODUCT_PRICE_ASC) String orderBy,
			@RequestParam(required=false, name="brand_id", defaultValue=Constants.SORT_BY_PRODUCT_BRAND_NONE) int brandId){
		return categoryPagination(model, slug, orderBy, brandId, 1);
	}
	
	@RequestMapping(value="/category/{slug}/page-{page}", method=RequestMethod.GET)
	public String categoryPagination(
			Model model, 
			@PathVariable("slug") String slug,
			@RequestParam(required=false, name="order_by", defaultValue=Constants.SORT_BY_PRODUCT_PRICE_ASC) String orderBy,
			@RequestParam(required=false, name="brand_id", defaultValue=Constants.SORT_BY_PRODUCT_BRAND_NONE) int brandId, 
			@PathVariable("page") int page) {
		Category category = categoryDAO.findBySlug(slug);
		if (category == null)
			return "redirect:/404";
		else {
			int totalPage = productDAO.getTotalPageByCategoryId(Product.STATUS_PUBLISH, category.getId(), brandId);
			if (totalPage == 0)
				model.addAttribute("products_is_empty", true);
			else {
				if (page > totalPage || page < 1)
					return "redirect:/404";
				
				List<Product> productList = productDAO.findByCategoryId(Product.STATUS_PUBLISH, category.getId(), brandId, orderBy, page);
				ResultPagination<Product> result = new ResultPagination<Product>(page, totalPage, productList);
				model.addAttribute("result", result);
			}
		}
		
		model.addAttribute("category", category);
		loadData(model);
		return "category";
	}
	
	
	/*******************************************************************************************/
	/************************************* POST PAGE *******************************************/
	/*******************************************************************************************/
	@RequestMapping(value="/posts", method=RequestMethod.GET)
	public String postList(Model model) {
		return postListPagination(model, 1);
	}
	
	@RequestMapping(value="/posts/page-{page}")
	public String postListPagination(Model model, @PathVariable("page") int page) {
		int totalPage = postDAO.getTotalPageByStatus(Post.STATUS_PUBLISH);
		if (page < 1 || page > totalPage)
			return "redirect:/404";
		else {
			List<Post> postList = postDAO.findByStatus(Post.STATUS_PUBLISH, page);
			ResultPagination<Post> result = new ResultPagination<Post>(page, totalPage, postList);
			model.addAttribute("result", result);
			loadData(model);
		}
		return "posts";
	}
	
	@RequestMapping(value="/post/{id}", method=RequestMethod.GET)
	public String postDetailById(Model model, @PathVariable("id") int id) {
		Post post = postDAO.findById(id);
		if (post == null) return "redirect:/404";
		
		return "redirect:/post/" + post.getId() + "/" + post.getSlug();
	}
	
	@RequestMapping(value="/post/{id}/{slug}")
	public String postDetail(Model model, @PathVariable("id") int id, @PathVariable("slug") String slug) {
		Post post = postDAO.findById(id);
		if (post == null)
			return "redirect:/404";
		else if (!slug.equals(post.getSlug())) {
			return "redirect:/post/" + post.getId() + "/" + post.getSlug();
		} else {
			model.addAttribute("post", post);
			loadData(model);
			postDAO.updateNumberView(post);
		}
		return "post";
	}
	
	/*******************************************************************************************/
	/************************************* CART PAGE *******************************************/
	/*******************************************************************************************/
	@RequestMapping(value="/carts", method=RequestMethod.GET)
	public String cartList(
			Model model, 
			Principal principal,
			HttpServletRequest request){
		HttpSession session = request.getSession();
		
		CartList cartList = (CartList) session.getAttribute("CART_LIST");
		model.addAttribute("cart_list", cartList);
		
		loadData(model);
		return "carts";
	}
	
	@RequestMapping(value="/checkout", method=RequestMethod.GET)
	public String checkout(
			Model model, 
			HttpServletRequest request,
			@RequestParam(required=true, name="address") String address){
		
		Account account = accountDAO.findById(1);
		HttpSession session = request.getSession();
		CartList cartList = (CartList) session.getAttribute("CART_LIST");
		
		Order order = new Order();
		order.setAddress(address);
		order.setCreatedAt(new Date());
		order.setAccount(account);
		order.setStatus(Order.STATUS_OK);
		order.setTotal(cartList.getTotalPrice());
		orderDAO.add(order);
		
		for (Cart cart : cartList.getCarts()) {
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setOrder(order);
			orderDetail.setProduct(cart.getProduct());
			orderDetail.setPrice(cart.getProduct().getPrice());
			orderDetail.setDiscount(cart.getProduct().getSalePrice());
			orderDetail.setQuantity(cart.getQuantity());
			orderDetailDAO.add(orderDetail);
		}
		
		session.removeAttribute("CART_LIST");
		
		model.addAttribute("result", "Đã đặt hàng.");

		loadData(model);
		return "carts";
	}

	
}
