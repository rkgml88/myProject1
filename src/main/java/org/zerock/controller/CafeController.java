package org.zerock.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.DessertContentDTO;
import org.zerock.domain.MainContentDTO;
import org.zerock.domain.NewContentDTO;
import org.zerock.domain.SigContentDTO;
import org.zerock.service.CafeService;

@Controller
public class CafeController {
	@Autowired
    private CafeService cafeService;
	
	@GetMapping("/")
	public String root() {
	    // "/" 요청 시 "/main"으로 리다이렉트
	    return "redirect:/main";
	}
	
	@GetMapping("/main")
    public String mainPage(Model model) {
        MainContentDTO mainContent = cafeService.getMainContent();
        model.addAttribute("mainContent", mainContent);
        
        SigContentDTO sigContent = cafeService.getSigContent();
        model.addAttribute("sigContent", sigContent);
        
        NewContentDTO newContent = cafeService.getNewContent();
        model.addAttribute("newContent", newContent);
        
        DessertContentDTO dessertContent = cafeService.getDessertContent();
        model.addAttribute("dessertContent", dessertContent);
        
        return "main"; // JSP 페이지
    }
	
	@GetMapping("/about")
    public String redirectAboutGet() {
        
        return "about";
    }
	
	@GetMapping("/map")
    public String redirectMapGet() {
        
        return "map";
    }
	
	// 메인 캐치프라이즈 이미지
	@PostMapping(
		    value="/updateMainContent", 
		    consumes=MediaType.MULTIPART_FORM_DATA_VALUE, 
		    produces="application/json"
		)
		@ResponseBody
		public Map<String, Object> updateMainContent(
		        @RequestParam(value="pcImg1", required=false) MultipartFile pcImg1,
		        @RequestParam(value="pcImg2", required=false) MultipartFile pcImg2,
		        @RequestParam(value="mobileImg1", required=false) MultipartFile mobileImg1,
		        @RequestParam(value="mobileImg2", required=false) MultipartFile mobileImg2,
		        @RequestParam(value="existingPcImg1", required=false) String existingPcImg1,
		        @RequestParam(value="existingPcImg2", required=false) String existingPcImg2,
		        @RequestParam(value="existingMobileImg1", required=false) String existingMobileImg1,
		        @RequestParam(value="existingMobileImg2", required=false) String existingMobileImg2,
		        @RequestParam String title1,
		        @RequestParam String desc1,
		        @RequestParam String title2,
		        @RequestParam String desc2,
		        HttpServletRequest request) throws Exception {

		    String uploadDir = request.getServletContext().getRealPath("/resources/upload/");
		    MainContentDTO dto = new MainContentDTO();

		    // pcImg1
		    if (pcImg1 != null && !pcImg1.isEmpty()) {
		        String fileName = System.currentTimeMillis() + "_" + pcImg1.getOriginalFilename();
		        pcImg1.transferTo(new File(uploadDir, fileName));
		        dto.setPcImg1("/resources/upload/" + fileName);
		    } else {
		        dto.setPcImg1(existingPcImg1);
		    }

		    // pcImg2
		    if (pcImg2 != null && !pcImg2.isEmpty()) {
		        String fileName = System.currentTimeMillis() + "_" + pcImg2.getOriginalFilename();
		        pcImg2.transferTo(new File(uploadDir, fileName));
		        dto.setPcImg2("/resources/upload/" + fileName);
		    } else {
		        dto.setPcImg2(existingPcImg2);
		    }

		    // mobileImg1
		    if (mobileImg1 != null && !mobileImg1.isEmpty()) {
		        String fileName = System.currentTimeMillis() + "_" + mobileImg1.getOriginalFilename();
		        mobileImg1.transferTo(new File(uploadDir, fileName));
		        dto.setMobileImg1("/resources/upload/" + fileName);
		    } else {
		        dto.setMobileImg1(existingMobileImg1);
		    }

		    // mobileImg2
		    if (mobileImg2 != null && !mobileImg2.isEmpty()) {
		        String fileName = System.currentTimeMillis() + "_" + mobileImg2.getOriginalFilename();
		        mobileImg2.transferTo(new File(uploadDir, fileName));
		        dto.setMobileImg2("/resources/upload/" + fileName);
		    } else {
		        dto.setMobileImg2(existingMobileImg2);
		    }

		    // 텍스트
		    dto.setTitle1(title1);
		    dto.setDesc1(desc1);
		    dto.setTitle2(title2);
		    dto.setDesc2(desc2);

		    cafeService.updateMainContent(dto);

		    Map<String, Object> result = new HashMap<>();
		    result.put("status", "success");
		    return result;
		}

	// 시그니처 이미지
	@PostMapping(
		    value="/updateSigContent", 
		    consumes=MediaType.MULTIPART_FORM_DATA_VALUE, 
		    produces="application/json"
		)
		@ResponseBody
		public Map<String, Object> updateSigContent(
		        @RequestParam(value="sigImg", required=false) MultipartFile sigfile,
		        @RequestParam(value="sigexistingImg", required=false) String sigexistingImg,
		        @RequestParam String sigtitle,
		        @RequestParam String sigdesc,
		        HttpServletRequest request) throws Exception {

		    String uploadDir = request.getServletContext().getRealPath("/resources/upload/");
		    SigContentDTO dto = new SigContentDTO();

		    // 파일 1 처리
		    if (sigfile != null && !sigfile.isEmpty()) {
		        String fileName = System.currentTimeMillis() + "_" + sigfile.getOriginalFilename();
		        File dest = new File(uploadDir, fileName);
		        sigfile.transferTo(dest);
		        dto.setImg("/resources/upload/" + fileName);
		    } else {
		        dto.setImg(sigexistingImg); // 기존 경로 유지
		    }

		    // 문구 설정
		    dto.setTitle(sigtitle);
		    dto.setDes(sigdesc);

		    // DB 업데이트
		    cafeService.updateSigContent(dto);

		    // JSON 응답
		    Map<String, Object> result = new HashMap<>();
		    result.put("status", "success");
		    return result;
		}
	
	// 신메뉴 이미지
	@PostMapping(
		    value="/updateNewContent", 
		    consumes=MediaType.MULTIPART_FORM_DATA_VALUE, 
		    produces="application/json"
		)
		@ResponseBody
		public Map<String, Object> updateNewContent(
		        @RequestParam(value="newImg", required=false) MultipartFile newfile,
		        @RequestParam(value="newexistingImg", required=false) String newexistingImg,
		        @RequestParam String newtitle,
		        @RequestParam String newdesc,
		        HttpServletRequest request) throws Exception {

		    String uploadDir = request.getServletContext().getRealPath("/resources/upload/");
		    NewContentDTO dto = new NewContentDTO();

		    // 파일 1 처리
		    if (newfile != null && !newfile.isEmpty()) {
		        String fileName = System.currentTimeMillis() + "_" + newfile.getOriginalFilename();
		        File dest = new File(uploadDir, fileName);
		        newfile.transferTo(dest);
		        dto.setImg("/resources/upload/" + fileName);
		    } else {
		        dto.setImg(newexistingImg); // 기존 경로 유지
		    }

		    // 문구 설정
		    dto.setTitle(newtitle);
		    dto.setDes(newdesc);

		    // DB 업데이트
		    cafeService.updateNewContent(dto);

		    // JSON 응답
		    Map<String, Object> result = new HashMap<>();
		    result.put("status", "success");
		    return result;
		}
	
	// 디저트 이미지
	@PostMapping(
		    value="/updateDessertContent", 
		    consumes=MediaType.MULTIPART_FORM_DATA_VALUE, 
		    produces="application/json"
		)
		@ResponseBody
		public Map<String, Object> updateDessertContent(
		        @RequestParam(value="dessertImg1", required=false) MultipartFile file1,
		        @RequestParam(value="dessertImg2", required=false) MultipartFile file2,
		        @RequestParam(value="dessertImg3", required=false) MultipartFile file3,
		        @RequestParam(value="dessertImg4", required=false) MultipartFile file4,
		        @RequestParam(value="dessertImg5", required=false) MultipartFile file5,
		        @RequestParam(value="existingDessertImg1", required=false) String existingDessertImg1,
		        @RequestParam(value="existingDessertImg2", required=false) String existingDessertImg2,
		        @RequestParam(value="existingDessertImg3", required=false) String existingDessertImg3,
		        @RequestParam(value="existingDessertImg4", required=false) String existingDessertImg4,
		        @RequestParam(value="existingDessertImg5", required=false) String existingDessertImg5,
		        @RequestParam String titleDessert1,
		        @RequestParam String titleDessert2,
		        @RequestParam String titleDessert3,
		        @RequestParam String titleDessert4,
		        @RequestParam String titleDessert5,
		        HttpServletRequest request) throws Exception {

		    String uploadDir = request.getServletContext().getRealPath("/resources/upload/");
		    DessertContentDTO dto = new DessertContentDTO();

		    // 파일 1 처리
		    if (file1 != null && !file1.isEmpty()) {
		        String fileName1 = System.currentTimeMillis() + "_" + file1.getOriginalFilename();
		        File dest1 = new File(uploadDir, fileName1);
		        file1.transferTo(dest1);
		        dto.setImg1("/resources/upload/" + fileName1);
		    } else {
		        dto.setImg1(existingDessertImg1); // 기존 경로 유지
		    }

		    // 파일 2 처리
		    if (file2 != null && !file2.isEmpty()) {
		        String fileName2 = System.currentTimeMillis() + "_" + file2.getOriginalFilename();
		        File dest2 = new File(uploadDir, fileName2);
		        file2.transferTo(dest2);
		        dto.setImg2("/resources/upload/" + fileName2);
		    } else {
		        dto.setImg2(existingDessertImg2); // 기존 경로 유지
		    }

		    // 파일 3 처리
		    if (file3 != null && !file3.isEmpty()) {
		        String fileName3 = System.currentTimeMillis() + "_" + file3.getOriginalFilename();
		        File dest3 = new File(uploadDir, fileName3);
		        file3.transferTo(dest3);
		        dto.setImg3("/resources/upload/" + fileName3);
		    } else {
		        dto.setImg3(existingDessertImg3); // 기존 경로 유지
		    }

		    // 파일 4 처리
		    if (file4 != null && !file4.isEmpty()) {
		        String fileName4 = System.currentTimeMillis() + "_" + file4.getOriginalFilename();
		        File dest4 = new File(uploadDir, fileName4);
		        file4.transferTo(dest4);
		        dto.setImg4("/resources/upload/" + fileName4);
		    } else {
		        dto.setImg4(existingDessertImg4); // 기존 경로 유지
		    }
		    
		    // 파일 5 처리
		    if (file5 != null && !file5.isEmpty()) {
		        String fileName5 = System.currentTimeMillis() + "_" + file5.getOriginalFilename();
		        File dest5 = new File(uploadDir, fileName5);
		        file5.transferTo(dest5);
		        dto.setImg5("/resources/upload/" + fileName5);
		    } else {
		        dto.setImg5(existingDessertImg5); // 기존 경로 유지
		    }
		    
		    // 문구 설정
		    dto.setTitle1(titleDessert1);
		    dto.setTitle2(titleDessert2);
		    dto.setTitle3(titleDessert3);;
		    dto.setTitle4(titleDessert4);
		    dto.setTitle5(titleDessert5);

		    // DB 업데이트
		    cafeService.updateDessertContent(dto);

		    // JSON 응답
		    Map<String, Object> result = new HashMap<>();
		    result.put("status", "success");
		    return result;
		}
}
