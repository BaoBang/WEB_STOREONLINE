package com.ptitshop.controllers;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.multipart.support.ByteArrayMultipartFileEditor;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.ptitshop.models.UploadForm;
import com.ptitshop.utils.Constants;
import com.ptitshop.utils.MyUtils;


@Controller
@Transactional
@EnableWebMvc
@RequestMapping(value = "/upload")
public class FileUploadController {

	// Phương thức này được gọi mỗi lần có Submit.
	@InitBinder
	public void initBinder(WebDataBinder dataBinder) {
		Object target = dataBinder.getTarget();
		if (target == null) {
			return;
		}
		System.out.println("Target=" + target);

		if (target.getClass() == UploadForm.class) {
			// Đăng ký để chuyển đổi giữa các đối tượng multipart thành byte[]
			dataBinder.registerCustomEditor(byte[].class, new ByteArrayMultipartFileEditor());
		}
	}

	// GET: Hiển thị trang form upload
	@RequestMapping(method = RequestMethod.GET)
	public String uploadFileHandler(Model model) {

		UploadForm myUploadForm = new UploadForm();
		model.addAttribute("uploadForm", myUploadForm);

		// Forward to "/WEB-INF/pages/uploadOneFile.jsp".
		return "/admin/upload";
	}

	// GET: Hiển thị trang form upload
	@RequestMapping(value = "/oneFile", method = RequestMethod.GET)
	public String uploadOneFileHandler(Model model) {

		UploadForm myUploadForm = new UploadForm();
		model.addAttribute("uploadForm", myUploadForm);

		// Forward to "/WEB-INF/pages/uploadOneFile.jsp".
		return "/admin/upload";
	}

	// POST: Sử lý Upload
	@RequestMapping(value = "/oneFile", method = RequestMethod.POST)
	public String uploadOneFileHandlerPOST(HttpServletRequest request, Model model,
			@ModelAttribute("uploadForm") UploadForm myUploadForm) {
		return this.doUpload(request, model, myUploadForm);
	}

	// GET: Hiển thị trang form upload
	@RequestMapping(value = "/multiFile", method = RequestMethod.GET)
	public String uploadMultiFileHandler(Model model) {

		UploadForm myUploadForm = new UploadForm();
		model.addAttribute("uploadForm", myUploadForm);

		// Forward to "/WEB-INF/jsp/uploadMultiFile.jsp".
		return "/admin/upload";
	}

	// POST: Sử lý Upload
	@RequestMapping(value = "/multiFile", method = RequestMethod.POST)
	public String uploadMultiFileHandlerPOST(HttpServletRequest request, Model model,
			@ModelAttribute("uploadForm") UploadForm myUploadForm) {
		return this.doUpload(request, model, myUploadForm);
	}

	private String doUpload(HttpServletRequest request, Model model, UploadForm uploadForm) {
		// Thời Gian Upload
		Calendar calendar = Calendar.getInstance();
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH);
		int day = calendar.get(Calendar.DAY_OF_MONTH);
		int hour = calendar.get(Calendar.HOUR_OF_DAY);
		int minute = calendar.get(Calendar.MINUTE);
		int second = calendar.get(Calendar.SECOND);

		// Thư mục gốc upload file.
		String uploadRootPath = request.getServletContext().getRealPath(Constants.UPLOAD_DIRECTORY) + File.separator + year ;
		System.out.println("uploadRootPath=" + uploadRootPath);

		File uploadRootDir = new File(uploadRootPath);

		// Tạo thư mục gốc upload nếu nó không tồn tại.
		if (!uploadRootDir.exists()) {
			uploadRootDir.mkdirs();
		}
		CommonsMultipartFile[] fileDatas = uploadForm.getFileDatas();

		List<File> uploadedFiles = new ArrayList<File>();
		for (CommonsMultipartFile fileData : fileDatas) {
			// Tên file gốc tại Client.
			String name = fileData.getOriginalFilename();
			System.out.println("Client File Name = " + name);

			// Đổi tên file: giờ_phút_giây_tênFileGốc
			String fileName = year + "-" + month + "-" + day + "-" + hour + "-" + minute + "-" + second + "-" + name;
			String fileSlug = MyUtils.toURLFriendly(fileName);
			
			if (name != null && name.length() > 0) {
				try {
					// Tạo file tại Server.
					File serverFile = new File(uploadRootDir.getAbsolutePath() + File.separator + fileSlug);

					// Luồng ghi dữ liệu vào file trên Server.
					BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
					stream.write(fileData.getBytes());
					stream.close();

					uploadedFiles.add(serverFile);
					System.out.println("Write file: " + serverFile);


				} catch (Exception e) {
					System.out.println("Error Write file: " + name);
				}
			}
		}
		model.addAttribute("uploadedFiles", uploadedFiles);
//		return "upload-result";
		return "/admin/upload";
	}
}
