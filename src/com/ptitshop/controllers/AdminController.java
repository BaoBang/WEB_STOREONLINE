package com.ptitshop.controllers;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
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
import com.ptitshop.dao.ProductDetailDAO;
import com.ptitshop.dao.ProductImageDAO;
import com.ptitshop.dao.PromotionDAO;
import com.ptitshop.entities.Account;
import com.ptitshop.entities.AccountProfile;
import com.ptitshop.entities.Brand;
import com.ptitshop.entities.Category;
import com.ptitshop.entities.Order;
import com.ptitshop.entities.OrderDetail;
import com.ptitshop.entities.Post;
import com.ptitshop.entities.Product;
import com.ptitshop.entities.ProductDetail;
import com.ptitshop.entities.ProductImage;
import com.ptitshop.entities.Promotion;
import com.ptitshop.models.ResultPagination;
import com.ptitshop.utils.BCryptEncoder;
import com.ptitshop.utils.Constants;
import com.ptitshop.utils.ConvertCharacterUtils;

@Controller
@Transactional
@EnableWebMvc
@RequestMapping(value = "/admin")
public class AdminController {

	@Autowired
	private AccountDAO accountDAO;
	
	@Autowired
	private AccountProfileDAO accountProfileDAO;

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
	
	@Autowired
	private OrderDAO orderDAO;
	
	@Autowired
	private OrderDetailDAO orderDetailDAO;

	
	private void loadData(Model model) {
		List<Category> categoryList = categoryDAO.findByStatus(Category.STATUS_PUBLISH);
		List<Brand> brandList = brandDAO.findByStatus(Brand.STATUS_PUBLISH);
		List<Promotion> promotionList = promotionDAO.findByStatus(Promotion.STATUS_PUBLISH);
		model.addAttribute("category_list", categoryList);
		model.addAttribute("brand_list", brandList);
		model.addAttribute("promotion_list", promotionList);
	}
	
	/*******************************************************************************************/
	/************************************* ERROR PAGE ******************************************/
	/*******************************************************************************************/
	@RequestMapping(value = "/403", method = RequestMethod.GET)
	public String errorAdmin403() {
		return "/admin/403";
	}

	
	/*******************************************************************************************/
	/************************************* DASHBOARD PAGE **************************************/
	/*******************************************************************************************/
	@RequestMapping(method = RequestMethod.GET)
	public String admin(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		Account user = (Account) session.getAttribute("user");
		if(user == null){
			Principal principal = request.getUserPrincipal();
			if(principal != null){
				user = accountDAO.findByUserName(principal.getName());
			}
		}
		
		List<Category> categoryList = categoryDAO.findByStatus(Category.STATUS_PUBLISH);
		String arrCategory [] = new String[categoryList.size()];
		int arrTotalProduct [] = new int[categoryList.size()];
		for (int i = 0; i < categoryList.size(); i++) {
			int totalProduct = productDAO.getTotalProductByCategoryId(categoryList.get(i).getId());
			arrCategory[i] = categoryList.get(i).getName();
			arrTotalProduct[i] = totalProduct;
		}
		
		List<Account> accountList = accountDAO.findNews(10);
		List<Product> productList = productDAO.findRecentlyAddedProducts(5);
		List<Post> postList	= postDAO.findRecentlyAddedPosts(5);
		List<Order> orderList = orderDAO.findLatestOrders(5);
		
		int totalAccount = accountDAO.getTotalAccounts();
		int totalProduct = productDAO.getTotalProducts();
		int totalPost = postDAO.getTotalPosts();
		int totalOrder = orderDAO.getToltalOrders();
		
		model.addAttribute("accountList", accountList);
		model.addAttribute("productList", productList);
		model.addAttribute("postList", postList);
		model.addAttribute("orderList", orderList);
		model.addAttribute("totalAccount", totalAccount);
		model.addAttribute("totalProduct", totalProduct);
		model.addAttribute("totalPost", totalPost);
		model.addAttribute("totalOrder", totalOrder);
		model.addAttribute("arrCategory", arrCategory);
		model.addAttribute("arrTotalProduct", arrTotalProduct);
		
		session.setAttribute("user", user);
		return "admin/index";
	}


	/*******************************************************************************************/
	/*************************************** BRAND PAGE ****************************************/
	/*******************************************************************************************/
	@RequestMapping(value = "/brand", method = RequestMethod.GET)
	public String brand(Model model, @RequestParam(required = false, name = "page", defaultValue = "1") int page) {
		List<Brand> brandList = brandDAO.findAllByPagination(page);
		int totalPage = brandDAO.getTotalPage();
		ResultPagination<Brand> result = new ResultPagination<>(page, totalPage, brandList);
		model.addAttribute("result", result);
		return "/admin/brand";
	}

	@RequestMapping(value = "/add-brand")
	public String addBrand(Model model, HttpServletRequest request,
			@RequestParam(required = false, name = "page", defaultValue = "1") int page,
			@RequestParam(required = true, name = "brandid", defaultValue = "0") int brandId,
			@RequestParam(required = true, name = "brandname", defaultValue = "") String brandName,
			@RequestParam(required = true, name = "brandimage", defaultValue = "") String brandImage,
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

	@RequestMapping(value = "/edit-brand/{brandId}")
	public String editBrand(Model model, HttpServletRequest request, @PathVariable("brandId") int brandId,
			@RequestParam(required = true, name = "brandname", defaultValue = "") String brandName,
			@RequestParam(required = true, name = "brandimage", defaultValue = "") String brandImage,
			@RequestParam(required = true, name = "brandstatus", defaultValue = "1") int brandStatus) {
		Brand brand = brandDAO.findById(brandId);
		String error = "";
		if (request.getParameter("submit") != null) {
			if (brand != null) {
				brand.setName(brandName);
				brand.setImage(brandImage);
				System.out.println(brandImage);
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
	/************************************** PRODUCT ********************************************/
	/*******************************************************************************************/
	@RequestMapping(value = "/product")
	public String product(Model model, @RequestParam(required = false, name = "page", defaultValue = "2") int page) {
		List<Product> result = productDAO.findAll();

		model.addAttribute("result", result);
		return "/admin/product";
	}

	private void insertProductImage(List<ProductImage> productImages) {
		for (ProductImage image : productImages) {
			productImageDAO.insert(image);
		}
	}

	@SuppressWarnings("unused")
	private void updateProductImage(List<ProductImage> productImages) {
		for (ProductImage image : productImages) {
			productImageDAO.update(image);
		}
	}

	private void deleteProductImage(List<ProductImage> productImages) {
		for (ProductImage image : productImages) {
			productImageDAO.remove(image);
		}
	}

	private List<Promotion> getPromotion(Product product, String promotionStrs[]) {
		List<Promotion> promotions = new ArrayList<>();
		for (int i = 0; i < promotionStrs.length; i++) {
			Promotion promotion = promotionDAO.findById(Integer.parseInt(promotionStrs[i]));
			promotion.getProducts().add(product);
			promotionDAO.update(promotion);
			promotions.add(promotion);
		}
		return promotions;
	}

	private List<ProductImage> getProductImages(String[] images, ProductDetail productDetail) {
		List<ProductImage> productImages = new ArrayList<>();
		for (int i = 0; i < images.length; i++) {
			if (!images[i].equals("")) {
				ProductImage image = new ProductImage();
				image.setId(Constants.DEUFAULT_ID);
				image.setUrl(images[i]);
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

	private String pasreToJSONDigitals(String digitalDetails[]) {
		String sjons = "[";
		for (int i = 0; i < digitalDetails.length; i += 2) {
			digitalDetails[i].replaceAll("\"", "\\\"");
			digitalDetails[i + 1].replaceAll("\"", "\\\"");
			System.out.println(digitalDetails[i + 1]);
			if (digitalDetails[i + 1].equals("/")) {
				if (i > 1) {
					sjons += "]}";
					if (i < digitalDetails.length)
						sjons += ",";
				}
				sjons += "{\"category\":" + "\"" + digitalDetails[i] + "\",\"list\":[";
			} else {
				sjons += "{\"name\":" + "\"" + digitalDetails[i] + "\",\"value\":\"" + digitalDetails[i + 1] + "\"}";
				if (i + 2 < digitalDetails.length && !digitalDetails[i + 3].equals("/")) {
					sjons += ",";
				}
			}
		}
		sjons += "]}]";
		return sjons;
	}

	private String convertJSONToDigitalAdminForm(String jSON) {
		String digitals = "";
		JSONParser jsonParser = new JSONParser();
		int index = 0;
		try {
			JSONArray jsonArray = (JSONArray) jsonParser.parse(jSON);

			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject jsonObject = (JSONObject) jsonArray.get(i);
				String category = (String) jsonObject.get("category");
				digitals += "<li id='" + index++
						+ "'><input class='form-control input-digital-title' placeholder='Nhập vào loại thông số' name='digital-details' value='"
						+ category + "'><input type='hidden' value='/' name='digital-details'><a li-id='" + index
						+ "' class='delete-input'><i class='fa fa-time'></i></a></li>";

				JSONArray jsonArray2 = (JSONArray) jsonObject.get("list");
				for (int j = 0; j < jsonArray2.size(); j++) {
					JSONObject jsonObject2 = (JSONObject) jsonArray2.get(j);
					digitals += "<li id='" + index
							+ "'><input class='form-control input-digital-lable' placeholder='Nhập vào tên thông số' name='digital-details' value='"
							+ jsonObject2.get("name")
							+ "'><input class='form-control input-digital-span' placeholder='Nhập vào giá trị thông số' name='digital-details' value='"
							+ jsonObject2.get("value") + "'><a li-id='" + index++
							+ "' class='delete-input'><i class='fa fa-times'></i></a></li>";

				}
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return digitals;
	}

	@RequestMapping(value = "/add-product")
	public String addProduct(Model model, HttpServletRequest request,
			@RequestParam(required = true, name = "productname", defaultValue = "") String productName,
			@RequestParam(required = true, name = "productimage", defaultValue = "") String productImage,
			@RequestParam(required = true, name = "productcategory", defaultValue = "0") int productCategoryId,
			@RequestParam(required = true, name = "productbrand", defaultValue = "0") int productBrandId,
			@RequestParam(required = true, name = "productprice", defaultValue = "0") double productPrice,
			@RequestParam(required = true, name = "productsaleprice", defaultValue = "0") double productSalePrice,
			@RequestParam(required = true, name = "productquantity", defaultValue = "0") int productQuantity,
			@RequestParam(required = true, name = "productdescription", defaultValue = "") String productDescription) {
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
			if (request.getParameterValues("productimage") != null) {
				String images[] = productImage.split("\n");
				System.out.println("len : " + images.length);
				productImages = getProductImages(images, productDetail);
				if (images.length > 0) {
					product.setImage(images[Constants.ZERO_NUMBER]);
				}
			}
			// overview + digital
			String digitals = "";
			String overview = "";
			if (request.getParameterValues("digital-details") != null) {
				String digitalDetails[] = request.getParameterValues("digital-details");
				digitals = pasreToJSONDigitals(digitalDetails);
				overview = getOverView(digitalDetails);
			}
			product.setOverview(overview);
			productDetail.setDigitals(digitals);

			// 1 insert product detail
			productDetailDAO.insert(productDetail);
			product.setProductDetail(productDetail);
			// 2 insert product images
			insertProductImage(productImages);
			productDetail.setProductImages(productImages);
			// 4 insert product
			productDAO.insert(product);
			// 3 promotions
			List<Promotion> promotions = new ArrayList<>();
			if (request.getParameterValues("promotions") != null) {
				String promotionStrs[] = request.getParameterValues("promotions");
				promotions = getPromotion(product, promotionStrs);
			}
			product.setPromotions(promotions);

			message = "Thêm thành công sản phẩm " + product.getName() + " vào cơ sở dữ liệu";

		}
		model.addAttribute("message", message);
		loadData(model);
		return "/admin/add-product";
	}

	@SuppressWarnings("unused")
	@RequestMapping(value = "/edit-product/{productId}")
	public String eidtProduct(Model model, HttpServletRequest request, HttpServletResponse response,
			@PathVariable("productId") int productId,
			@RequestParam(required = true, name = "productname", defaultValue = "") String productName,
			@RequestParam(required = true, name = "productimage", defaultValue = "") String productImage,
			@RequestParam(required = true, name = "productcategory", defaultValue = "0") int productCategoryId,
			@RequestParam(required = true, name = "productbrand", defaultValue = "0") int productBrandId,
			@RequestParam(required = true, name = "productprice", defaultValue = "0") double productPrice,
			@RequestParam(required = true, name = "productsaleprice", defaultValue = "0") double productSalePrice,
			@RequestParam(required = true, name = "productquantity", defaultValue = "0") int productQuantity,
			@RequestParam(required = true, name = "productdescription", defaultValue = "") String productDescription,
			@RequestParam(required = true, name = "productstatus", defaultValue = "1") int productStatus)
			throws IOException {
		loadData(model);
		String message = "";
		Product product = productDAO.findById(productId);
		if (request.getParameter("submit") != null) {
			if (product != null) {
				product.setBrand(brandDAO.findById(productBrandId));
				product.setCategory(categoryDAO.findById(productCategoryId));
				product.setName(productName);
				product.setPrice(productPrice);
				product.setSalePrice(productSalePrice);
				product.setStatus(productStatus);
				// detail
				ProductDetail productDetail = product.getProductDetail();
				productDetail.setDescription(productDescription);
				productDetail.setQuantity(productQuantity);
				// overview
				String digitals = "";
				String overview = "";
				if (request.getParameterValues("digital-details") != null) {
					String digitalDetails[] = request.getParameterValues("digital-details");
					digitals = pasreToJSONDigitals(digitalDetails);
					overview = getOverView(digitalDetails);
				}
				product.setOverview(overview);
				productDetail.setDigitals(digitals);
				// image
				List<ProductImage> productImages = new ArrayList<>();
				if (request.getParameterValues("productimage") != null) {
					System.out.println(productImage);
					String images[] = productImage.split("\n");
					productImages = getProductImages(images, productDetail);
					if (images.length > 0) {
						product.setImage(images[Constants.ZERO_NUMBER]);
					}
				}
				// promotions
				List<Promotion> promotions = new ArrayList<>();
				if (request.getParameterValues("promotions") != null) {
					String promotionStrs[] = request.getParameterValues("promotions");
					promotions = getPromotion(product, promotionStrs);
				}
				// product.setPromotions(promotions);
				// 1 update product detail

				productDetailDAO.update(productDetail);
				product.setProductDetail(productDetail);
				System.out.println(product.getProductDetail().getDescription());
				// 2 update product images
				deleteProductImage(productImageDAO.findByProducDetailtId(productDetail.getId()));
				insertProductImage(productImages);
				productDetail.setProductImages(productImages);
				// 3 update product
				productDAO.update(product);
				message = "Cập nhật thành công sản phẩm " + product.getName() + ".";
				model.addAttribute("message", message);
				response.sendRedirect(request.getContextPath() + "/admin/product");
			} else {
				message = "Cập nhật thất bại";
			}
		}
		String productImageStrings = getImageList(product);
		model.addAttribute("digitalDetails", convertJSONToDigitalAdminForm(product.getProductDetail().getDigitals()));
		model.addAttribute("message", message);
		model.addAttribute("productImageStrings", productImageStrings);
		model.addAttribute(product);
		return "/admin/edit-product";
	}

	private String getImageList(Product product) {
		String imageStr = "";
		if (product != null) {
			List<ProductImage> images = productImageDAO.findByProducDetailtId(product.getProductDetail().getId());
			for (ProductImage image : images) {
				imageStr += image.getUrl() + "\n";
			}
		}
		return imageStr;
	}

	/*******************************************************************************************/
	/*************************************** PROMOTION PAGE ************************************/
	/*******************************************************************************************/
	@RequestMapping(value = "/promotion", method = RequestMethod.GET)
	public String promotion(Model model, @RequestParam(required = false, name = "page", defaultValue = "1") int page) {
		List<Promotion> promotionList = promotionDAO.findAllByPagination(page);
		int totalPage = promotionDAO.getTotalPage();
		ResultPagination<Promotion> result = new ResultPagination<>(page, totalPage, promotionList);
		model.addAttribute("result", result);
		return "/admin/promotion";
	}

	@SuppressWarnings({ "deprecation" })
	@RequestMapping(value = "/add-promotion")
	public String addPromotion(Model model, HttpServletRequest request,
			@RequestParam(required = false, name = "page", defaultValue = "1") int page,
			@RequestParam(required = true, name = "promotionname", defaultValue = "") String promotionName,
			@RequestParam(required = true, name = "promotionimage", defaultValue = "") String promotionImage,
			@RequestParam(required = true, name = "promotioncontent", defaultValue = "") String promotionContent,
			@RequestParam(required = true, name = "promotiondate", defaultValue = "") String promotionDate,
			@RequestParam(required = true, name = "brandstatus", defaultValue = "1") int promotionStatus) {

		Promotion promotion = new Promotion();
		String error = "";
		if (request.getParameter("submit") != null) {
			try {
				promotion.setId(Constants.DEUFAULT_ID);
				promotion.setName(promotionName);
				promotion.setImage(promotionImage);
				promotion.setStatus(promotionStatus);
				promotion.setContent(promotionContent);
				String dates[] = promotionDate.split("-");
				if (dates.length > 1) {
					promotion.setStartAt(new Date(dates[0]));
					promotion.setEndAt(new Date(dates[1]));
				}
				System.out.println(promotion.getEndAt().toString() + "-" + promotion.getStartAt().toString());
				promotionDAO.insert(promotion);
				error = "Thêm thành công ưu đãi " + promotion.getName() + "!";

			} catch (Exception e) {
				System.err.println(e);
				error = "Có lỗi xảy ra.";
			}
			model.addAttribute("error", error);
		}
		model.addAttribute("promotion", promotion);
		return "/admin/add-promotion";
	}

	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/edit-promotion/{promotionId}")
	public String editPromotion(Model model, HttpServletRequest request, @PathVariable("promotionId") int promotionId,
			@RequestParam(required = true, name = "promotionname", defaultValue = "") String promotionName,
			@RequestParam(required = true, name = "promotionimage", defaultValue = "") String promotionImage,
			@RequestParam(required = true, name = "promotioncontent", defaultValue = "") String promotionContent,
			@RequestParam(required = true, name = "promotiondate", defaultValue = "") String promotionDate,
			@RequestParam(required = true, name = "promotionstatus", defaultValue = "1") int promotionStatus) {
		Promotion promotion = promotionDAO.findById(promotionId);
		String error = "";
		if (request.getParameter("submit") != null) {
			if (promotion != null) {
				promotion.setName(promotionName);
				promotion.setImage(promotionImage);
				promotion.setContent(promotionContent);
				promotion.setStatus(promotionStatus);
				String dates[] = promotionDate.split("-");
				if (dates.length > 1) {
					promotion.setStartAt(new Date(dates[0]));
					promotion.setEndAt(new Date(dates[1]));
				}
				promotionDAO.update(promotion);
				error = "Cập nhật thành công công hãng " + promotion.getName() + " vào csdl.";
			} else {
				error = "Cập nhật thất bại";
			}
			model.addAttribute("error", error);
		}
		model.addAttribute("promotion", promotion);
		return "/admin/edit-promotion";
	}

	/*******************************************************************************************/
	/************************************** POST PAGE ******************************************/
	/*******************************************************************************************/
	@RequestMapping(value = "/posts", method = RequestMethod.GET)
	public String postList(Model model, @RequestParam(required = false, name = "page", defaultValue = "1") int page) {
		int totalPage = postDAO.getTotalPage();
		if (page < 1 || page > totalPage)
			return "redirect:/admin/403";

		List<Post> postList = postDAO.findAllByPagination(page);
		ResultPagination<Post> result = new ResultPagination<Post>(page, totalPage, postList);

		model.addAttribute("result", result);
		return "/admin/post-list";
	}

	@RequestMapping(value = "/add-new-post", method = RequestMethod.GET)
	public String addNewPost(Model model) {
		return "/admin/add-new-post";
	}

	@RequestMapping(value = "/add-new-post", method = RequestMethod.POST)
	public String doAddNewPost(Model model, @RequestParam(required = true, name = "post_title") String title,
			@RequestParam(required = true, name = "post_description") String description,
			@RequestParam(required = true, name = "post_content") String content,
			@RequestParam(required = false, name = "post_image", defaultValue = Constants.DEFAULT_POST_IMAGE) String image,
			@RequestParam(required = true, name = "post_status", defaultValue = Constants.DEFAULT_POST_STATUS) int status) {

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
			String slug = ConvertCharacterUtils.toURLFriendly(title);
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

		if (errors.isEmpty()) {
			// add
			postDAO.add(post);
			model.addAttribute("result", true);
			model.addAttribute("post_title", post.getTitle());
		} else {
			model.addAttribute("result", false);
			model.addAttribute("post", post);
		}
		model.addAttribute("errors", errors);

		return "/admin/add-new-post";
	}

	@RequestMapping(value = "/edit-post/{postId}", method = RequestMethod.GET)
	public String editPost(Model model, @PathVariable("postId") int postId) {

		Post post = postDAO.findById(postId);
		if (post == null)
			return "redirect:/admin/403";
		else
			model.addAttribute("post", post);

		return "/admin/edit-post";
	}

	@RequestMapping(value = "/edit-post/{postId}", method = RequestMethod.POST)
	public String doEditPost(Model model, @PathVariable("postId") int postId,
			@RequestParam(required = true, name = "post_title") String title,
			@RequestParam(required = false, name = "post_slug") String slug,
			@RequestParam(required = true, name = "post_description") String description,
			@RequestParam(required = true, name = "post_content") String content,
			@RequestParam(required = false, name = "post_image", defaultValue = Constants.DEFAULT_POST_IMAGE) String image,
			@RequestParam(required = false, name = "post_status", defaultValue = Constants.DEFAULT_POST_STATUS) int status) {

		Post post = postDAO.findById(postId);
		if (post == null)
			return "redirect:/admin/403";
		else {
			Map<String, String> errors = new HashMap<String, String>();

			// Title
			if (null == title || title.length() <= 0)
				errors.put("title", "Tiêu đề không được để trống!");
			else
				post.setTitle(title);

			// Slug
			if (null == slug || slug.length() <= 0)
				slug = ConvertCharacterUtils.toURLFriendly(post.getTitle());
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

			if (errors.isEmpty()) {
				// update
				postDAO.update(post);
				model.addAttribute("result", true);
			} else {
				model.addAttribute("result", false);
				model.addAttribute("errors", errors);
			}

			model.addAttribute("post", post);
		}
		return "/admin/edit-post";
	}

	/*******************************************************************************************/
	/************************************ CATEGORY PAGE ****************************************/
	/*******************************************************************************************/
	@RequestMapping(value = "/categories", method = RequestMethod.GET)
	public String categoryList(Model model) {
		List<Category> categoryList = categoryDAO.findAll();
		model.addAttribute("category_list", categoryList);
		return "/admin/category-list";
	}

	@RequestMapping(value = "/add-new-category", method = RequestMethod.GET)
	public String addNewCategory(Model model) {
		List<Category> categoryList = categoryDAO.findByStatus(Category.STATUS_PUBLISH);
		model.addAttribute("category_list", categoryList);
		return "/admin/add-new-category";
	}

	@RequestMapping(value = "/add-new-category", method = RequestMethod.POST)
	public String doAddNewCategory(Model model, @RequestParam(name = "category_name", required = true) String name,
			@RequestParam(name = "category_slug", required = true) String slug,
			@RequestParam(name = "category_description", required = true) String description,
			@RequestParam(name = "category_position", required = true, defaultValue= "1") int position,
			@RequestParam(name = "category_parent_id", required = true, defaultValue = "0") int parentId,
			@RequestParam(name = "category_status", required = true) int status,
			@RequestParam(name = "category_image", required = false) String image) {

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

		if (position < 1){
			errors.put("position", "Thứ tự không khợp lệ");
		} else {
			category.setPosition(position);
		}
		
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
			model.addAttribute("category_name", category.getName());
		} else{
			model.addAttribute("result", false);
			model.addAttribute("category", category);
		}
		
		List<Category> categoryList = categoryDAO.findByStatus(Category.STATUS_PUBLISH);
		model.addAttribute("category_list", categoryList);

		return "/admin/add-new-category";
	}

	@RequestMapping(value = "/edit-category/{id}", method = RequestMethod.GET)
	public String editCategory(Model model, @PathVariable("id") int id) {
		Category category = categoryDAO.findById(id);
		if (category == null)
			return "redirect:/admin/403";
		List<Category> categoryList = categoryDAO.findByStatus(Category.STATUS_PUBLISH);
		model.addAttribute("category", category);
		model.addAttribute("category_list", categoryList);
		return "/admin/edit-category";
	}

	@RequestMapping(value = "/edit-category/{id}", method = RequestMethod.POST)
	public String doEditCategory(Model model, @PathVariable("id") int id,
			@RequestParam(name = "category_name", required = true) String name,
			@RequestParam(name = "category_slug", required = true) String slug,
			@RequestParam(name = "category_position", required = true, defaultValue= "1") int position,
			@RequestParam(name = "category_description", required = true) String description,
			@RequestParam(name = "category_parent_id", required = true, defaultValue = "0") int parentId,
			@RequestParam(name = "category_status", required = true) int status,
			@RequestParam(name = "category_image", required = false) String image) {

		Category category = categoryDAO.findById(id);
		if (null == category)
			return "redirect/admin/403";
		else {
			Map<String, String> errors = new HashMap<String, String>();
			if (null == name || name.trim().length() <= 0)
				errors.put("name", "Tên thể loại không được bỏ trống.");
			else
				category.setName(name);

			if (null == slug || slug.trim().length() <= 0)
				errors.put("slug", "Đường dẫn thể loại không được để trống.");
			else
				category.setSlug(slug);

			if (null == description || description.trim().length() <= 0)
				errors.put("description", description);
			else
				category.setDescription(description);

			if (position < 1){
				errors.put("position", "Thứ tự không khợp lệ");
			} else {
				category.setPosition(position);
			}
			
			if (parentId == 0) {
				if (null == image || image.trim().length() <= 0)
					errors.put("image", image);
				else
					category.setImage(image);
			} else {
				category.setImage(null);
				Category parentCategory = categoryDAO.findById(parentId);
				if (parentCategory == null || parentCategory.getParentId() != 0)
					errors.put("parentId", "Nút gốc không hợp lệ.");
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
	/************************************* ACCOUNT PAGE ****************************************/
	/*******************************************************************************************/

	@RequestMapping(value = "/members", method = RequestMethod.GET)
	public String accountList(Model model) {
		List<Account> accountList = accountDAO.findAll();
		model.addAttribute("account_list", accountList);
		return "/admin/member-list";
	}

	@RequestMapping(value = "/profile/{id}", method = RequestMethod.GET)
	public String accountProfile(Model model, @PathVariable("id") int id) {
		Account account = accountDAO.findById(id);
		if (account == null)
			return "redirect:/admin/403";
		else
			model.addAttribute("account", account);
		return "/admin/profile";
	}

	@RequestMapping(value = "/profile/{id}", method = RequestMethod.POST)
	public String updateAccountProfile(Model model, @PathVariable("id") int id,
			@RequestParam(required = true, name = "account_first_name") String firstName,
			@RequestParam(required = true, name = "account_last_name") String lastName,
			@RequestParam(required = true, name = "account_email") String email,
			@RequestParam(required = true, name = "account_phone") String phone,
			@RequestParam(required = true, name = "account_address") String address,
			@RequestParam(required = true, name = "account_biography") String biography,
			@RequestParam(required = false, name = "account_avatar", defaultValue = Constants.DEFAULT_AVATAR) String avatar,
			@RequestParam(required = true, name = "account_gender", defaultValue = "0") int gender,
			@RequestParam(required = false, name = "account_role") String role) {

		Account account = accountDAO.findById(id);
		if (account == null)
			return "redirect:/admin/403";
		else {
			account.setFirstName(firstName);
			account.setLastName(lastName);
			account.setAvatar(avatar);
			if (role != null && (role.equals(Account.ROLE_ADMIN) || role.equals(Account.ROLE_USER))) account.setRole(role);
			
			AccountProfile accountProfile = account.getAccountProfile();
			accountProfile.setEmail(email);
			accountProfile.setPhone(phone);
			accountProfile.setAddress(address);
			accountProfile.setBiography(biography);
			accountProfile.setGender(gender == 0 ? false : true);
			
			account.setAccountProfile(accountProfile);
			accountProfileDAO.updateAccountProfile(accountProfile);
			accountDAO.updateAccount(account);
			
			model.addAttribute("account", account);
			model.addAttribute("result", true);
		}

		return "/admin/profile";
	}

	@RequestMapping(value = "/profile/{id}/reset-password", method = RequestMethod.POST)
	public String resetPassword(Model model, @PathVariable("id") int id,
			@RequestParam(required = true, name = "current_password") String currentPassword,
			@RequestParam(required = true, name = "new_password") String newPassword,
			@RequestParam(required = true, name = "confirm_password") String confirmPassword) {
		Account account = accountDAO.findById(id);
		BCryptEncoder encoder = new BCryptEncoder();
		if (account == null) {
			return "/admin/403";
		} else {
			Map<String, String> errors_password = new HashMap<String, String>();
			if (currentPassword == null || currentPassword.length() <= 0)
				errors_password.put("current_password", "Mật khẩu không được bỏ trống!");
			if (newPassword == null || newPassword.length() <= 0)
				errors_password.put("new_password", "Mật khẩu mới không được bỏ trống!");
			if (confirmPassword == null || confirmPassword.length() <= 0)
				errors_password.put("confirm_password", "Xác nhận mật khẩu không được bỏ trống!");
			
			String passwordHash = encoder.BCEncrypt(currentPassword);
			if (passwordHash.equals(account.getPasswordHash())) {
				errors_password.put("current_password", "Mật khẩu không chính xác!");
			} else if (!newPassword.equals(confirmPassword)) {
				errors_password.put("confirm_password", "Xác nhận mật khẩu không chính xác!");
			}

			if (!errors_password.isEmpty()) {
				model.addAttribute("result_reset_password", false);
			} else {
				String hashPassword = encoder.BCEncrypt(newPassword);
				account.setSalt(Constants.ZERO_NUMBER + "");
				account.setPasswordHash(hashPassword);

				accountDAO.updateAccount(account);
				model.addAttribute("result_reset_password", true);
			}

			model.addAttribute("account", account);
		}
		return "/admin/profile";
	}
	
	@RequestMapping(value="/add-new-account", method=RequestMethod.GET)
	public String addNewAccount() {
		return "/admin/add-new-account";
	}
	
	@RequestMapping(value="/add-new-account", method=RequestMethod.POST)
	public String doAddNewAccount(
			Model model,
			@RequestParam(required=true, name="account_user_name") String userName,
			@RequestParam(required=true, name="account_first_name") String firstName,
			@RequestParam(required=true, name="account_last_name") String lastName,
			@RequestParam(required=false, name="account_role", defaultValue=Constants.DEFAULT_ROLE) String role,
			@RequestParam(required=true, name="account_password") String password,
			@RequestParam(required=true, name="account_confirm_password") String confirmPassword,
			@RequestParam(required=false, name="account_status", defaultValue=Constants.DEFAULT_ACCOUNT_STATUS) int status,
			@RequestParam(required=false, name="account_avatar", defaultValue=Constants.DEFAULT_AVATAR) String avatar) {
		
		BCryptEncoder encoder = new BCryptEncoder();
		String passwordHash = encoder.BCEncrypt(password);
		
		Account account = new Account();
		account.setUserName(userName);
		account.setFirstName(firstName);
		account.setLastName(lastName);
		account.setAvatar(avatar);
		account.setStatus(status);
		account.setRole(role);
		account.setPasswordHash(passwordHash);
		account.setSalt(Constants.ZERO_NUMBER + "");
		account.setCreatedAt(new Date());
		AccountProfile accountProfile = new AccountProfile();
		accountProfile.setGender(Constants.DEFAULT_GENDER);
		accountProfileDAO.add(accountProfile);
		account.setAccountProfile(accountProfile);
		
		accountDAO.add(account);

		return "redirect:/admin/members";
	}
	
	@RequestMapping(value = "/delete-account", method=RequestMethod.POST)
	public String deleteAccount(@RequestParam (required = true, name = "id_account") int idAccount) {
		Account account = accountDAO.findById(idAccount);
		if (account != null) {
			AccountProfile accountProfile = accountProfileDAO.findById(account.getAccountProfile().getId());
			accountDAO.delete(account);
			accountProfileDAO.delete(accountProfile);
		}
		return "redirect:/admin/members";
	}
	
	/*******************************************************************************************/
	/************************************** ORDER PAGE *****************************************/
	/*******************************************************************************************/
	@RequestMapping(value="/order-list", method=RequestMethod.GET)
	public String orderList(Model model, @RequestParam(required=false, name="page", defaultValue="1") int page) {
		int totalPage = orderDAO.getTotalPage();
		if (page <= 0 || page > totalPage) return "redirect:/admin/403";
		
		List<Order> orderList = orderDAO.findByPagination(page);
		ResultPagination<Order> result = new ResultPagination<Order>(page, totalPage, orderList);
		model.addAttribute("result", result);
		
		return "/admin/order-list";
	}
	
	@RequestMapping(value="/order-detail/{id}", method = RequestMethod.GET)
	public String orderDetail(Model model, @PathVariable("id") int id) {
		Order order = orderDAO.findById(id);
		if (order == null) return "redirect:/admin/403";
		else {
			List<OrderDetail> orderDetailList = orderDetailDAO.findByOrderId(order.getId());
			model.addAttribute("order", order);
			model.addAttribute("order_detail_list", orderDetailList);
		}
		return "/admin/order-detail";
	}
	
	@RequestMapping(value="/order-detail/{id}", method=RequestMethod.POST)
	public String changeStatusOrder(
			Model model, 
			@PathVariable("id") int id, 
			@RequestParam(required = true, name = "order_status", defaultValue = "0") int status){
		Order order = orderDAO.findById(id);
		if (order == null) return "redirect:/admin/403";
		else {
			order.setStatus(status);
			orderDAO.update(order);
			
			List<OrderDetail> orderDetailList = orderDetailDAO.findByOrderId(order.getId());
			model.addAttribute("order", order);
			model.addAttribute("order_detail_list", orderDetailList);
		}
		return "/admin/order-detail";
	}

}
