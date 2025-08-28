package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MainContentDTO {
	private int id;
	private String pcImg1;
	private String title1;
	private String desc1;
	private String mobileImg1;
	private String pcImg2;
	private String title2;
	private String desc2;
	private String mobileImg2;
	private Date updatedAt;
}
