package com.ptitshop.controllers;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import com.ptitshop.entities.ProductDetail;
import com.ptitshop.entities.ProductImage;
import com.ptitshop.entities.Promotion;
import com.ptitshop.models.ResultPagination;
import com.ptitshop.utils.Constants;
import com.ptitshop.utils.MyUtils;

@Controller
@Transactional
@EnableWebMvc
@RequestMapping(value = "/admin")
public class AdminController {

	@Autowired
	private AccountDAO accountDAO;

	@Autowired
	private PostDAO postDAO;

	@Autowired
	private CategoryDAO categoryDAO;

	@Autowired
	private BrandDAO brandDAO;

	@Autowired
	private ProductDAO productDAO;

	@Autowired
	private PromotionDAO promotionDAO;

	@Autowired
	private ProductImageDAO productImageDAO;

	@Autowired
	private ProductDetailDAO productDetailDAO;

	@RequestMapping(value = "/test")
	public String test() {
		return "/admin/brank";
	}

	private void loadData(Model model) {
		List<Category> categoryList = categoryDAO.findByStatus(Category.STATUS_PUBLISH);
		List<Brand> brandList = brandDAO.findByStatus(Brand.STATUS_PUBLISH);
		List<Promotion> promotionList = promotionDAO.findByStatus(Promotion.STATUS_PUBLISH);
		model.addAttribute("category_list", categoryList);
		model.addAttribute("brand_list", brandList);
		model.addAttribute("promotion_list", promotionList);
	}

	/*******************************************************************************************/
	/************************************ ERROR PAGE *******************************************/
	/*******************************************************************************************/
	@RequestMapping(value="/403", method=RequestMethod.GET)
	public String errorAdmin403() {
		return "/admin/403";
	}

	
	/*******************************************************************************************/
	/**************************************
	 * Brand PAGE
	 *****************************************/
	/*******************************************************************************************/
	@RequestMapping(value = "/brand", method = RequestMethod.GET)
	public String brand(Model model, @RequestParam(required = false, name = "page", defaultValue = "1") int page) {
		List<Brand> brandList = brandDAO.findAllByPagination(page);
		int totalPage = brandDAO.getTotalPage();
		ResultPagination<Brand> result = new ResultPagination<>(page, totalPage, brandList);
		model.addAttribute("result", result);
		return "/admin/brand";
	}

	@RequestMapping(value = "/add-brand", method = RequestMethod.GET)
	public String addBrand(Model model, HttpServletRequest request,
			@RequestParam(required = false, name = "page", defaultValue = "1") int page,
			@RequestParam(required = true, name = "brandid", defaultValue = "0") int brandId,
			@RequestParam(required = true, name = "brandname", defaultValue = "") String brandName,
			@RequestParam(required = true, name = "files[]", defaultValue = "") String brandImage,
			@RequestParam(required = true, name = "brandstatus", defaultValue = "1") int brandStatus) {
		Brand brand = brandDAO.findByBrandName(brandName);
		String error = "";
		if (request.getParameter("submit") != null) {
			if (brand == null) {
				brand = new Brand();
				brand.setId(brandId);
				brand.setName(brandName);
				brand.setImage(brandImage);
				brand.setStatus(brandStatus);
				brandDAO.insert(brand);
				error = "Thêm thành công hãng " + brand.getName() + " vào csdl.";
				brand = new Brand();
				brand.setStatus(1);
			} else {
				error = "Hãng đã tồn tại.";
			}
			model.addAttribute("error", error);
		}
		model.addAttribute("brand", brand);
		return "/admin/add-brand";
	}

	@RequestMapping(value = "/edit-brand/{brandId}", method = RequestMethod.GET)
	public String editBrand(Model model, HttpServletRequest request,
			@PathVariable("brandId") int brandId,
			@RequestParam(required = true, name = "brandname", defaultValue = "") String brandName,
			@RequestParam(required = true, name = "brandimage", defaultValue = "") String brandImage,
			@RequestParam(required = true, name = "brandstatus", defaultValue = "1") int brandStatus
			) {
		Brand brand = brandDAO.findById(brandId);
		String error = "";
		if (request.getParameter("submit") != null) {
			if (brand != null) {
				brand.setName(brandName);
				brand.setImage(brandImage);
				brand.setStatus(brandStatus);
				brandDAO.update(brand);
				error = "Cập nhật thành công công hãng " + brand.getName() + " vào csdl.";
			} else {
				error = "Cập nhật thất bại";
			}
			model.addAttribute("error", error);
		}
		model.addAttribute("brand", brand);
		return "/admin/edit-brand";
	}

	/*******************************************************************************************/
	/************************************** PRODUCT *******************************************/
	/*******************************************************************************************/
	@RequestMapping(value = "/product", method = RequestMethod.GET)
	public String product(Model model, @RequestParam(required = false, name = "page", defaultValue = "1") int page) {
		List<Product> productList = productDAO.findAllByPagination(page);
		int totalPage = productDAO.getTotalPage();
		ResultPagination<Product> result = new ResultPagination<>(page, totalPage, productList);
		model.addAttribute("result", result);
		return "/admin/product";
	}

	@RequestMapping(value = "/add-product", method = RequestMethod.GET)
	public String addProduct(Model model, HttpServletRequest request,
			@RequestParam(required = true, name = "productname", defaultValue = "") String productName,
			@RequestParam(required = true, name = "productcategory", defaultValue = "0") int productCategoryId,
			@RequestParam(required = true, name = "productbrand", defaultValue = "0") int productBrandId,
			@RequestParam(required = true, name = "productprice", defaultValue = "0") double productPrice,
			@RequestParam(required = true, name = "productsaleprice", defaultValue = "0") double productSalePrice,
			@RequestParam(required = true, name = "productquantity", defaultValue = "0") int productQuantity,
			@RequestParam(required = true, name = "productdescription", defaultValue = "") String productDescription) {
		loadData(model);
		String message = "";
		if (request.getParameter("submit") != null) {
			Product product = new Product();
			product.setId(Constants.DEUFAULT_ID);
			product.setBrand(brandDAO.findById(productBrandId));
			product.setCategory(categoryDAO.findById(productCategoryId));
			product.setCreatedAt(new Date());
			product.setName(productName);
			product.setPrice(productPrice);
			product.setSalePrice(productSalePrice);
			product.setRank(Constants.ZERO_NUMBER);
			product.setStatus(Constants.DEFAULT_STATUS);
			product.setViews(Constants.ZERO_NUMBER);
			// detail
			ProductDetail productDetail = new ProductDetail();
			productDetail.setDescription(productDescription);
			productDetail.setId(3);
			productDetail.setQuantity(productQuantity);
			productDetail.setUploadedAt(new Date());

			// image
			List<ProductImage> productImages = new ArrayList<>();
			if (request.getParameterValues("files[]") != null) {
				String images[] = request.getParameterValues("files[]");
				productImages = getProductImages(images, productDetail);
				if (images.length > 0) {
					product.setImage("/PTiTShop/uploads/" + images[Constants.ZERO_NUMBER]);
				}
			}
			// overview + digital
			String digitals = "";
			String overview = "";
			if (request.getParameterValues("digital-details") != null) {
				String digitalDetails[] = request.getParameterValues("digital-details");
				digitals = getDigital(digitalDetails);
				overview = getOverView(digitalDetails);
			}
			product.setOverview(overview);
			productDetail.setDigitals(digitals);
			// promotions
			List<Promotion> promotions = new ArrayList<>();
			if (request.getParameterValues("promotions") != null) {
				String promotionStrs[] = request.getParameterValues("promotions");
				promotions = getPromotion(promotionStrs);
			}
			product.setPromotions(promotions);
			// insert product detail
			productDetailDAO.insert(productDetail);
			product.setProductDetail(productDetail);
			// insert product images
			insertProductImage(productImages);
			productDetail.setProductImages(productImages);
			// insert product
			productDAO.insert(product);
			//product.setPromotions(promotions);
			message = "Thêm thành công sản phẩm " + product.getName() + " vào cơ sở dữ liệu";
			
		}
		model.addAttribute("message", message);
		return "/admin/add-product";
	}

	private void insertProductImage(List<ProductImage> productImages) {
		for (ProductImage image : productImages) {
			productImageDAO.insert(image);
		}
	}

	private List<Promotion> getPromotion(String promotionStrs[]) {
		List<Promotion> promotions = new ArrayList<>();
		for (int i = 0; i < promotionStrs.length; i++) {
			promotions.add(promotionDAO.findById(Integer.parseInt(promotionStrs[i])));
		}
		return promotions;
	}

	private List<ProductImage> getProductImages(String[] images, ProductDetail productDetail) {
		List<ProductImage> productImages = new ArrayList<>();
		for (int i = 0; i < images.length; i++) {
			if (!images[i].equals("")) {
				ProductImage image = new ProductImage();
				image.setId(Constants.DEUFAULT_ID);
				image.setUrl("/PTiTShop/uploads/" + images[i]);
				image.setProductDetail(productDetail);
				productImages.add(image);
			}
		}
		return productImages;
	}

	private String getOverView(String[] digitalDetails) {
		String overview = "";
		if (digitalDetails.length > 2) {
			for (int i = 2; i < digitalDetails.length; i += 2) {
				if (digitalDetails[i + 1].equals("/")) {
					break;
				} else {
					overview += "<span>" + digitalDetails[i] + ":" + digitalDetails[i + 1] + "</span>";
				}
			}
		}
		return overview;
	}

	private String getDigital(String digitalDetails[]) {
		String digitals = "";
		if (digitalDetails.length > 0) {
			for (int i = 0; i < digitalDetails.length; i += 2) {
				if (digitalDetails[i + 1].equals("/")) {
					digitals += "<li class='digital-title'>" + digitalDetails[i] + "</li>";
				} else {
					digitals += "<li> <lable>" + digitalDetails[i] + ":" + "</lable><span>" + digitalDetails[i + 1]
							+ "</span> </li>";
				}
			}
		}
		return digitals;
	}
	/*******************************************************************************************/
	/************************************* POST PAGE *******************************************/
	/*******************************************************************************************/
	@RequestMapping(value="/posts", method=RequestMethod.GET)
	public String postList(Model model, @RequestParam(required=false, name="page", defaultValue="1") int page){
		int totalPage = postDAO.getTotalPage();
		if (page < 1 || page > totalPage) return "redirect:/admin/403";
			
		List<Post> postList = postDAO.findAllByPagination(page);
		ResultPagination<Post> result = new ResultPagination<>(page, totalPage, postList);
	
		model.addAttribute("result", result);
		return "/admin/post-list";
	}
	
	@RequestMapping(value="/add-new-post", method=RequestMethod.GET)
	public String addNewPost(Model model){
		return "/admin/add-new-post";
	}
	
	@RequestMapping(value="/add-new-post", method=RequestMethod.POST)
	public String doAddNewPost(
			Model model,
			@RequestParam(required=true, name="post_title") String title,
			@RequestParam(required=true, name="post_description") String description,
			@RequestParam(required=true, name="post_content") String content,
			@RequestParam(required=false, name="post_image", defaultValue=Constants.DEFAULT_POST_IMAGE) String image,
			@RequestParam(required=true, name="post_status", defaultValue=Constants.DEFAULT_POST_STATUS) int status){
		
		Account account = accountDAO.findById(1);
		
		Post post = new Post();
		post.setAccount(account);
		post.setViews(0);
		post.setPublishDate(new Date());
		post.setLastEdit(new Date());
		
		
		Map<String, String> errors = new HashMap<String, String>();

		// Title
		if (null == title || title.length() <= 0)
			errors.put("title", "Tiêu đề không được để trống!");
		else {
			post.setTitle(title);
			String slug = MyUtils.toURLFriendly(title);
			post.setSlug(slug);
		}
		
		// Description
		if (null == description || description.length() <= 0)
			errors.put("description", "Mô tả bài viết không được để trống!");
		else 
			post.setDescription(description);
		
		// Content
		if (null == content || content.length() <= 0)
			errors.put("content", "Nội dung bài viết không được bỏ trống!");
		else 
			post.setContent(content);
		
		// Image 
		if (null != image && image.length() > 0)
			post.setImage(image);
			
		// Status
		if (status != 0 && status != 1)
			errors.put("status", "Bạn chưa chọn trạng thái bài viết!");
		else
			post.setStatus(status);
		

		if (errors.isEmpty()){
			// add
			postDAO.add(post);
			model.addAttribute("result", true);
		} else
			model.addAttribute("result", false);
			model.addAttribute("errors", errors);
		
		model.addAttribute("post", post);
		
		return "/admin/add-new-post";
	}
	
	
	@RequestMapping(value="/edit-post/{postId}", method=RequestMethod.GET)
	public String editPost(
			Model model,
			@PathVariable("postId") int postId){
		
		Post post = postDAO.findById(postId);
		if(post == null)
			return "redirect:/admin/403";
		else
			model.addAttribute("post", post);
		
		return "/admin/edit-post";
	}
	
	@RequestMapping(value="/edit-post/{postId}", method=RequestMethod.POST)
	public String doEditPost(
			Model model,
			@PathVariable("postId") int postId,
			@RequestParam(required=true, name="post_title") String title,
			@RequestParam(required=false, name="post_slug") String slug,
			@RequestParam(required=true, name="post_description") String description,
			@RequestParam(required=true, name="post_content") String content,
			@RequestParam(required=false, name="post_image", defaultValue=Constants.DEFAULT_POST_IMAGE) String image,
			@RequestParam(required=false, name="post_status", defaultValue=Constants.DEFAULT_POST_STATUS) int status){
		
		Post post = postDAO.findById(postId);
		if(post == null)
			return "redirect:/admin/403";
		else{
			Map<String, String> errors = new HashMap<String, String>();

			// Title
			if (null == title || title.length() <= 0)
				errors.put("title", "Tiêu đề không được để trống!");
			else 
				post.setTitle(title);
			
			// Slug
			if (null == slug || slug.length() <= 0)
				slug = MyUtils.toURLFriendly(post.getTitle());
			post.setSlug(slug);
			
			// Description
			if (null == description || description.length() <= 0)
				errors.put("description", "Mô tả bài viết không được để trống!");
			else 
				post.setDescription(description);
			
			// Content
			if (null == content || content.length() <= 0)
				errors.put("content", "Nội dung bài viết không được bỏ trống!");
			else 
				post.setContent(content);
			
			// Image 
			if (null != image && image.length() > 0)
				post.setImage(image);
				
			// Status
			if (status != 0 && status != 1)
				errors.put("status", "Bạn chưa chọn trạng thái bài viết!");
			else
				post.setStatus(status);
			
			// Last Edit
			post.setLastEdit(new Date());
			

			if (errors.isEmpty()){
				// update
				postDAO.update(post);
				model.addAttribute("result", true);
			} else{
				model.addAttribute("result", false);
				model.addAttribute("errors", errors);
			}
				
			model.addAttribute("post", post);
		}
		return "/admin/edit-post";
	}
	
	
	/*******************************************************************************************/
	/*********************************** CATEGORY PAGE *****************************************/
	/*******************************************************************************************/
	@RequestMapping(value="/categories", method=RequestMethod.GET)
	public String categoryList(Model model) {
		List<Category> categoryList = categoryDAO.findAll();
		model.addAttribute("category_list", categoryList);
		return "/admin/category-list";
	}
	
	@RequestMapping(value="/add-new-category", method=RequestMethod.GET)
	public String addNewCategory(Model model) {
		List<Category> categoryList = categoryDAO.findByStatus(Category.STATUS_PUBLISH);
		model.addAttribute("category_list", categoryList);
		return "/admin/add-new-category";
	}
	
	@RequestMapping(value="/add-new-category", method=RequestMethod.POST)
	public String doAddNewCategory(
			Model model,
			@RequestParam(name="category_name", required=true) String name,
			@RequestParam(name="category_slug", required=true) String slug,
			@RequestParam(name="category_description", required=true) String description,
			@RequestParam(name="category_parent_id", required=true, defaultValue="0") int parentId, 
			@RequestParam(name="category_status", required=true) int status,
			@RequestParam(name="category_image", required=false) String image) {
		
		Category category = new Category();
		Map<String, String> errors = new HashMap<String, String>();
		if (null == name || name.trim().length() <= 0)
			errors.put("name", "Tên thể loại không được bỏ trống.");
		else 
			category.setName(name);
		
		if (null == slug || slug.trim().length() <= 0)
			errors.put("slug", "Đường dận thể loại không được để trống.");
		else 
			category.setSlug(slug);
		
		if (null == description || description.trim().length() <= 0)
			errors.put("description", description);
		else 
			category.setDescription(description);
		
		if (parentId == 0) {
			if (null == image || image.trim().length() <= 0)
				errors.put("image", image);
			else 
				category.setImage(image);
		} else {
			Category parentCategory = categoryDAO.findById(parentId);
			if (parentCategory == null || parentCategory.getParentId() != 0)
				errors.put("parentId", "út gốc không hợp lệ.");
			else 
				category.setParentId(parentId);
		}
		
		if (status != 0 && status != 1)
			errors.put("status", "Bạn chưa chọn trạng thái cho thể loại.");
		else 
			category.setStatus(status);
		
		if (errors.isEmpty()) {
			categoryDAO.add(category);
			model.addAttribute("result", true);
		} else 
			model.addAttribute("result", false);
	
		List<Category> categoryList = categoryDAO.findByStatus(Category.STATUS_PUBLISH);
		model.addAttribute("category_list", categoryList);
		model.addAttribute("category", category);
		
		return "/admin/add-new-category";
	}
	
	@RequestMapping(value="/edit-category/{id}", method=RequestMethod.GET)
	public String editCategory(Model model, @PathVariable("id") int id) {
		Category category = categoryDAO.findById(id);
		if (category == null) return "redirect:/admin/403";
		List<Category> categoryList = categoryDAO.findByStatus(Category.STATUS_PUBLISH);
		model.addAttribute("category", category);
		model.addAttribute("category_list", categoryList);
		return "/admin/edit-category";
	}
	
	@RequestMapping(value="/edit-category/{id}", method=RequestMethod.POST)
	public String doEditCategory(
			Model model, 
			@PathVariable("id") int id,
			@RequestParam(name="category_name", required=true) String name,
			@RequestParam(name="category_slug", required=true) String slug,
			@RequestParam(name="category_description", required=true) String description,
			@RequestParam(name="category_parent_id", required=true, defaultValue="0") int parentId, 
			@RequestParam(name="category_status", required=true) int status,
			@RequestParam(name="category_image", required=false) String image) {
		
		Category category = categoryDAO.findById(id);
		if (null == category) return "redirect/admin/403"; 
		else {
			Map<String, String> errors = new HashMap<String, String>();
			if (null == name || name.trim().length() <= 0)
				errors.put("name", "Tên thể loại không được bỏ trống.");
			else 
				category.setName(name);
			
			if (null == slug || slug.trim().length() <= 0)
				errors.put("slug", "Đường dận thể loại không được để trống.");
			else 
				category.setSlug(slug);
			
			if (null == description || description.trim().length() <= 0)
				errors.put("description", description);
			else 
				category.setDescription(description);
			
			if (parentId == 0) {
				if (null == image || image.trim().length() <= 0)
					errors.put("image", image);
				else 
					category.setImage(image);
			} else {
				Category parentCategory = categoryDAO.findById(parentId);
				if (parentCategory == null || parentCategory.getParentId() != 0)
					errors.put("parentId", "út gốc không hợp lệ.");
				else 
					category.setParentId(parentId);
			}
			
			if (status != 0 && status != 1)
				errors.put("status", "Bạn chưa chọn trạng thái cho thể loại.");
			else 
				category.setStatus(status);
			
			if (errors.isEmpty()) {
				categoryDAO.update(category);
				model.addAttribute("result", true);
			} else {
				model.addAttribute("result", false);
				model.addAttribute("errors", errors);
			}
				
		
			List<Category> categoryList = categoryDAO.findByStatus(Category.STATUS_PUBLISH);
			model.addAttribute("category_list", categoryList);
			model.addAttribute("category", category);

		}
		return "/admin/edit-category";
	}
	
	
	
	/*******************************************************************************************/
	/************************************ ACCOUNT PAGE *****************************************/
	/*******************************************************************************************/
	
	@RequestMapping(value="/members", method=RequestMethod.GET)
	public String accountList(Model model) {
		List<Account> accountList = accountDAO.findAll();
		model.addAttribute("account_list", accountList);
		return "/admin/member-list";
	}
	
	@RequestMapping(value="/profile/{id}", method=RequestMethod.GET)
	public String accountProfile(Model model, @PathVariable("id") int id) {
		Account account = accountDAO.findById(id);
		if (account == null) return "redirect:/admin/403";
		else model.addAttribute("account", account);
		return "/admin/profile";
	}
}
