package org.zerock.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.zerock.domain.DessertContentDTO;
import org.zerock.domain.MainContentDTO;
import org.zerock.domain.NewContentDTO;
import org.zerock.domain.SigContentDTO;

@Mapper
public interface CafeMapper {
	void updateMainContent(MainContentDTO dto);	
	MainContentDTO getMainContent();
	
	void updateSigContent(SigContentDTO dto);	
	SigContentDTO getSigContent();
	
	void updateNewContent(NewContentDTO dto);	
	NewContentDTO getNewContent();
	
	void updateDessertContent(DessertContentDTO dto);	
	DessertContentDTO getDessertContent();
}
