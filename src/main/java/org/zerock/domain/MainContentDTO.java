package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MainContentDTO {
	private int id;
	private String img1;
	private String title1;
	private String desc1;
	private String img2;
	private String title2;
	private String desc2;
	private Date updatedAt;
}
