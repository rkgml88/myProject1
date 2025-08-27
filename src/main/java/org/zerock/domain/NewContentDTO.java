package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NewContentDTO {
	private int id;
	private String img;
	private String title;
	private String des;
	private Date updatedAt;
}
