package org.zerock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.DessertContentDTO;
import org.zerock.domain.MainContentDTO;
import org.zerock.domain.NewContentDTO;
import org.zerock.domain.SigContentDTO;
import org.zerock.mapper.CafeMapper;

@Service
public class CafeService {
	@Autowired
    private CafeMapper cafeMapper;
	
	// 메인 캐치프라이즈 이미지
	public void updateMainContent(MainContentDTO dto) {
		// id=1 고정 업데이트 (메인 콘텐츠는 1개만 관리)
        dto.setId(1);
        cafeMapper.updateMainContent(dto);
    }
	
	public MainContentDTO getMainContent() {
        return cafeMapper.getMainContent();
    }
	
	// 시그니처 이미지
	public void updateSigContent(SigContentDTO dto) {
		// id=1 고정 업데이트
        dto.setId(1);
        cafeMapper.updateSigContent(dto);
    }
	
	public SigContentDTO getSigContent() {
        return cafeMapper.getSigContent();
    }
	
	// 신메뉴 이미지
	public void updateNewContent(NewContentDTO dto) {
		// id=1 고정 업데이트
        dto.setId(1);
        cafeMapper.updateNewContent(dto);
    }
	
	public NewContentDTO getNewContent() {
        return cafeMapper.getNewContent();
    }
	
	// 디저트 이미지
	public void updateDessertContent(DessertContentDTO dto) {
		// id=1 고정 업데이트
        dto.setId(1);
        cafeMapper.updateDessertContent(dto);
    }
	
	public DessertContentDTO getDessertContent() {
        return cafeMapper.getDessertContent();
    }
}
