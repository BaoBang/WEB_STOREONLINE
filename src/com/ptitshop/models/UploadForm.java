package com.ptitshop.models;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class UploadForm {

	// Upload files.
	private CommonsMultipartFile[] fileDatas;

	public CommonsMultipartFile[] getFileDatas() {
		return fileDatas;
	}

	public void setFileDatas(CommonsMultipartFile[] fileDatas) {
		this.fileDatas = fileDatas;
	}
}
