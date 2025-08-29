package org.zerock.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.MemberDTO;
import org.zerock.domain.VerificationCode;
import org.zerock.service.MemberService;

@Controller
public class MemberController {
	@Autowired
    private MemberService memberService;

	@GetMapping("/login")
    public String redirectLogininGet() {
        
        return "login";
    }
	
	@GetMapping("/joinU")
    public String redirectJoinUGet() {
        
        return "joinU";
    }
    
	@GetMapping("/joinA")
    public String redirectJoinAGet() {
        
        return "joinA";
    }
	
	@PostMapping("/checkUsername")
	@ResponseBody
	public String checkUsername(@RequestParam String username) {
	    boolean exists = memberService.existsByUsername(username); // DB 조회
	    return exists ? "FAIL" : "OK";
	}

    @PostMapping("/joinU")
    public String joinUser(@ModelAttribute MemberDTO member, RedirectAttributes redirectAttributes) {
    	// 마케팅 체크 안 했을 경우 'N'으로 처리
        if (member.getMarketingYn() == null) {
            member.setMarketingYn("N");
        }
    	
        // 사용자 role 고정
    	member.setRole("ROLE_USER");
    	memberService.insertMember(member);
    	redirectAttributes.addFlashAttribute("msg", "회원가입이 완료되었습니다.");
        return "redirect:/login";
    }

    @PostMapping("/joinA")
    public String joinAdmin(@ModelAttribute MemberDTO member, RedirectAttributes redirectAttributes) {
        // 관리자 role 고정
    	member.setRole("ROLE_ADMIN");
    	memberService.insertMember(member);
    	redirectAttributes.addFlashAttribute("msg", "회원가입이 완료되었습니다.");
        return "redirect:/login";
    }
    
    // 네이버 로그인
    @Autowired
    private UserDetailsService userDetailsService;
    
    @RequestMapping("/naver/callback")
    public String callback(HttpServletRequest request, HttpSession session) throws Exception {
        String clientId = "OF20uA908Z1LmP8wpvDs";
        String clientSecret = "pOXOYxmnXA";
        String code = request.getParameter("code");
        String state = request.getParameter("state");
        String redirectURI = URLEncoder.encode("http://localhost:8080/naver/callback", "UTF-8");

        // 1) access token 요청
        String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
                + "&client_id=" + clientId
                + "&client_secret=" + clientSecret
                + "&redirect_uri=" + redirectURI
                + "&code=" + code
                + "&state=" + state;

        URL url = new URL(apiURL);
        HttpURLConnection con = (HttpURLConnection)url.openConnection();
        con.setRequestMethod("GET");
        
        BufferedReader br;
        if(con.getResponseCode()==200) {
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }
        
        String inputLine;
        StringBuffer res = new StringBuffer();
        while ((inputLine = br.readLine()) != null) {
            res.append(inputLine);
        }
        br.close();

        // JSON 파싱
        JSONParser parser = new JSONParser();
        JSONObject json = (JSONObject) parser.parse(res.toString());
        String accessToken = (String) json.get("access_token");

        // 2) 사용자 프로필 요청
        String header = "Bearer " + accessToken; 
        String profileAPI = "https://openapi.naver.com/v1/nid/me";
        URL url2 = new URL(profileAPI);
        HttpURLConnection con2 = (HttpURLConnection)url2.openConnection();
        con2.setRequestMethod("GET");
        con2.setRequestProperty("Authorization", header);
        
        BufferedReader br2 = new BufferedReader(new InputStreamReader(con2.getInputStream()));
        String profileLine;
        StringBuffer profileRes = new StringBuffer();
        while ((profileLine = br2.readLine()) != null) {
            profileRes.append(profileLine);
        }
        br2.close();

        JSONObject profileJson = (JSONObject) parser.parse(profileRes.toString());
        JSONObject responseObj = (JSONObject) profileJson.get("response");

        String naverId = (String) responseObj.get("id");
        String email = (String) responseObj.get("email");
        String name = (String) responseObj.get("name");
        String mobile = (String) responseObj.get("mobile");
	     // 전화번호 포맷 통일 (하이픈 제거)
	     if (mobile != null) {
	         mobile = mobile.replaceAll("-", "");
	     }

        // 3) DB 조회 및 신규 회원 처리
        MemberDTO member = memberService.findByNaverId(naverId);
        if (member == null) {
            member = new MemberDTO();
            member.setNaverId(naverId);
            member.setName(name);
            member.setEmail(email);
            member.setTel(mobile);
            member.setPassword(UUID.randomUUID().toString()); // 더미 비번
            member.setRole("ROLE_USER");
            member.setMarketingYn("N");
            memberService.insertMember(member);
        }

        // 4) Spring Security 인증 처리
        UserDetails userDetails = userDetailsService.loadUserByUsername(naverId);
        Authentication auth = new UsernamePasswordAuthenticationToken(
                userDetails, null, userDetails.getAuthorities());
        SecurityContextHolder.getContext().setAuthentication(auth);
        
        // 5) 세션에 로그인 정보 저장
        session.setAttribute("loginMember", member);

        return "redirect:/main";
    }
    
    // 구글 로그인
    @RequestMapping("/google/callback")
    public String googleCallback(HttpServletRequest request, HttpSession session) throws Exception {
        String code = request.getParameter("code");

        String clientId = "849591001463-2hfoerqknmk47re1rvksn0clvdvq83s5.apps.googleusercontent.com";
        String clientSecret = "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";
        String redirectURI = URLEncoder.encode("http://localhost:8080/google/callback", "UTF-8");

        // 1) access token 요청
        String apiURL = "https://oauth2.googleapis.com/token";
        String postParams = "code=" + code
                + "&client_id=" + clientId
                + "&client_secret=" + clientSecret
                + "&redirect_uri=" + redirectURI
                + "&grant_type=authorization_code";

        URL url = new URL(apiURL);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("POST");
        con.setDoOutput(true);
        DataOutputStream wr = new DataOutputStream(con.getOutputStream());
        wr.writeBytes(postParams);
        wr.flush();
        wr.close();

        BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String inputLine;
        StringBuffer res = new StringBuffer();
        while ((inputLine = br.readLine()) != null) {
            res.append(inputLine);
        }
        br.close();

        JSONParser parser = new JSONParser();
        JSONObject json = (JSONObject) parser.parse(res.toString());
        String accessToken = (String) json.get("access_token");

        // 2) 사용자 프로필 요청
        URL url2 = new URL("https://www.googleapis.com/oauth2/v2/userinfo");
        HttpURLConnection con2 = (HttpURLConnection) url2.openConnection();
        con2.setRequestMethod("GET");
        con2.setRequestProperty("Authorization", "Bearer " + accessToken);

        BufferedReader br2 = new BufferedReader(new InputStreamReader(con2.getInputStream()));
        StringBuffer profileRes = new StringBuffer();
        while ((inputLine = br2.readLine()) != null) {
            profileRes.append(inputLine);
        }
        br2.close();

        JSONObject profileJson = (JSONObject) parser.parse(profileRes.toString());
        String googleId = (String) profileJson.get("id");
        String email = (String) profileJson.get("email");
        String name = (String) profileJson.get("name");
        String picture = (String) profileJson.get("picture");

        // 3) DB 조회 및 신규 회원 처리 (네이버와 동일)
        MemberDTO member = memberService.findByGoogleId(googleId);
        if (member == null) {
            member = new MemberDTO();
            member.setGoogleId(googleId);
            member.setName(name);
            member.setEmail(email);
            member.setPassword(UUID.randomUUID().toString()); // 더미 비밀번호
            member.setRole("ROLE_USER");
            member.setMarketingYn("N");
            memberService.insertMember(member);
        }

        // 4) Spring Security 인증 처리
        UserDetails userDetails = userDetailsService.loadUserByUsername(googleId);
        Authentication auth = new UsernamePasswordAuthenticationToken(
                userDetails, null, userDetails.getAuthorities());
        SecurityContextHolder.getContext().setAuthentication(auth);

        // 5) 세션 저장
        session.setAttribute("loginMember", member);

        return "redirect:/main";
    }
    
    // 회원정보 보기
    @GetMapping("/userinfo")
    public String redirectUserinfoGet(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String loginId = auth.getName();
        MemberDTO member = memberService.findByAllID(loginId);
        model.addAttribute("member", member);
        return "userinfo";
    }

    // 회원 정보 수정
    @PostMapping("/update")
    public String updateMember(MemberDTO member) {
    	// 마케팅 체크 안 했을 경우 'N'으로 처리
        if (member.getMarketingYn() == null) {
            member.setMarketingYn("N");
        }
        
        // username은 member.username에 들어 있음
        memberService.updateMember(member);
        return "redirect:/userinfo"; // 다시 회원정보 페이지로
    }
    
    // 회원탈퇴
    @PostMapping("/deleteMember")
    public String deleteMember(HttpServletRequest request,
                               HttpServletResponse response,
                               Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String loginId = auth.getName();  // username 또는 naverId 또는 googleId

        memberService.deleteMember(loginId);

        // 로그아웃 처리
        if (auth != null){
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }

        model.addAttribute("message", "회원 탈퇴되셨습니다.");
        model.addAttribute("redirectUrl", "/main");
        return "alertRedirect";
    }


    @GetMapping("/findID")
    public String redirectFindIDGet() {
        return "findID";
    }
    
    // 이메일 인증코드 요청
    @PostMapping(value = "/sendEmailCode", produces = "text/plain; charset=UTF-8")
    @ResponseBody
    public String sendCode(@RequestParam String email, HttpSession session) {
    	VerificationCode verificationCode = memberService.sendVerificationCode(email);
        session.setAttribute("emailCode", verificationCode);
        return "이메일로 인증 코드가 발송되었습니다.";
    }
    
    // 휴대전화 인증코드 요청
    @PostMapping(value = "/sendTelCode", produces = "text/plain; charset=UTF-8")
    @ResponseBody
    public String sendTelCode(@RequestParam String tel, HttpSession session) {
        VerificationCode verificationCode = memberService.sendVerificationCodeSms(tel);
        session.setAttribute("telCode", verificationCode);
        return "문자로 인증 코드가 발송되었습니다.";
    }

    // 아이디 찾기 인증 코드 검증 (이메일/휴대폰 공용)
    @PostMapping(value = "/verifyCode")
    public String verifyCode(
    		@RequestParam String verifyType, // tel 또는 email
    		@RequestParam String code,
    		@RequestParam String name,
    		@RequestParam(required = false) String email,
    		@RequestParam(required = false) String tel,
    		HttpSession session,
    		Model model) {
    	
    	VerificationCode saved;

        if ("email".equals(verifyType)) {
            saved = (VerificationCode) session.getAttribute("emailCode");
        } else { // 기본은 전화번호 인증
            saved = (VerificationCode) session.getAttribute("telCode");
        }
        
    	if (saved == null) {
            model.addAttribute("message", "인증 코드가 만료되었거나 없습니다.");
            model.addAttribute("redirectUrl", "/findID");
            return "alertRedirect";
        }

    	// 5분 = 5 * 60 * 1000 ms
    	long elapsed = System.currentTimeMillis() - saved.getTimestamp();
    	if (elapsed > 5 * 60 * 1000) {
    	    if ("email".equals(verifyType)) {
    	        session.removeAttribute("emailCode");
    	    } else {
    	        session.removeAttribute("telCode");
    	    }
    	    model.addAttribute("message", "인증 코드가 만료되었습니다.");
    	    model.addAttribute("redirectUrl", "/findID");
    	    return "alertRedirect";
    	}

        if (!saved.getCode().equals(code)) {
            model.addAttribute("message", "인증 코드가 일치하지 않습니다.");
            model.addAttribute("redirectUrl", "/findID");
            return "alertRedirect";
        }

        List<MemberDTO> members;
        if ("email".equals(verifyType)) {
            members = memberService.findIDByEmail(name, email);
        } else {
            members = memberService.findIDByTel(name, tel);
        }

        if (members != null && !members.isEmpty()) {
            model.addAttribute("members", members);
            return "idResult";  // JSP에서 리스트로 출력
        } else {
            model.addAttribute("message", "해당 이름의 아이디가 없습니다.");
            model.addAttribute("redirectUrl", "/findID");
            return "alertRedirect";
        }
    }
    
    @GetMapping("/idResult")
    public String redirectIdResultGet() {
        return "idResult";
    }
    
    @GetMapping("/findPW")
    public String redirectFindPWGet() {
        return "findPW";
    }
    
    // 비밀번호 변경 인증 코드 검증 (이메일/휴대폰 공용)
    @PostMapping(value = "/verifyCodePW")
    public String verifyCodePW(
    		@RequestParam String verifyType, // tel 또는 email
    		@RequestParam String username,
    		@RequestParam String code,
    		@RequestParam String name,
    		@RequestParam(required = false) String email,
    		@RequestParam(required = false) String tel,
    		HttpSession session,
    		Model model) {
    	
    	VerificationCode saved;

        if ("email".equals(verifyType)) {
            saved = (VerificationCode) session.getAttribute("emailCode");
        } else { // 기본은 전화번호 인증
            saved = (VerificationCode) session.getAttribute("telCode");
        }
        
    	if (saved == null) {
            model.addAttribute("message", "인증 코드가 만료되었거나 없습니다.");
            model.addAttribute("redirectUrl", "/findPW");
            return "alertRedirect";
        }

    	// 5분 = 5 * 60 * 1000 ms
    	long elapsed = System.currentTimeMillis() - saved.getTimestamp();
    	if (elapsed > 5 * 60 * 1000) {
    	    if ("email".equals(verifyType)) {
    	        session.removeAttribute("emailCode");
    	    } else {
    	        session.removeAttribute("telCode");
    	    }
    	    model.addAttribute("message", "인증 코드가 만료되었습니다.");
    	    model.addAttribute("redirectUrl", "/findPW");
    	    return "alertRedirect";
    	}

        if (!saved.getCode().equals(code)) {
            model.addAttribute("message", "인증 코드가 일치하지 않습니다.");
            model.addAttribute("redirectUrl", "/findPW");
            return "alertRedirect";
        }
        
        // 인증 성공 시, changePW.jsp에서 사용할 값 전달
        model.addAttribute("verifyType", verifyType);
        model.addAttribute("username", username);
        model.addAttribute("name", name);
        model.addAttribute("email", email);
        model.addAttribute("tel", tel);
        
        return "changePW";
    }
    
    @GetMapping("/changePW")
    public String redirectChangePWGet() {
        return "changePW";
    }
    
    @PostMapping("/changePW")
    public String changePW(
            @RequestParam String verifyType, // email 또는 tel
            @RequestParam String username,
            @RequestParam String name,
            @RequestParam(required = false) String email,
            @RequestParam(required = false) String tel,
            @RequestParam String password,
            Model model) {

    	boolean result;

        // 인증 방식에 따라 서비스 호출
        if ("email".equals(verifyType)) {
            result = memberService.changePWByEmail(password, username, name, email);
        } else {
            result = memberService.changePWByTel(password, username, name, tel);
        }

        if (result) {
            model.addAttribute("message", "비밀번호가 성공적으로 변경되었습니다. 다시 로그인 해주세요.");
            model.addAttribute("redirectUrl", "/login");
        } else {
            model.addAttribute("message", "비밀번호 변경에 실패했습니다. 입력 정보를 다시 확인해주세요.");
            model.addAttribute("redirectUrl", "/findPW");
        }
        
        return "alertRedirect";
    }

}
