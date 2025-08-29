package org.zerock.service;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.zerock.domain.MemberDTO;
import org.zerock.domain.VerificationCode;
import org.zerock.mapper.MemberMapper;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Service
public class MemberService {
	
	@Autowired
    private MemberMapper memberMapper;
	
	@Autowired
    private JavaMailSender mailSender;
	
	@Autowired
    private BCryptPasswordEncoder passwordEncoder;
		
	public void insertMember(MemberDTO member) {
        // 비밀번호 암호화 예시 (Spring Security)
        String encodedPassword = new BCryptPasswordEncoder().encode(member.getPassword());
        member.setPassword(encodedPassword);

        memberMapper.insertMember(member);
    }
	
	public boolean existsByUsername(String username) {
		return memberMapper.existsByUsername(username) > 0;
	}
	
	public MemberDTO findByusername(String username) {
    	return memberMapper.findByusername(username);
    }
	
	public MemberDTO findByNaverId(String naverId) {
    	return memberMapper.findByNaverId(naverId);
    }
	
	public MemberDTO findByGoogleId(String googleId) {
    	return memberMapper.findByGoogleId(googleId);
    }
	
	public MemberDTO findByAllID(String allID) {
    	return memberMapper.findByAllID(allID);
    }
	
	public void updateMember(MemberDTO member) {
	    memberMapper.updateMember(member);
	}
	
	public void deleteMember(String allID) {
		memberMapper.deleteMember(allID);
	}

	// 이메일 인증코드 발송
    public VerificationCode sendVerificationCode(String to) {
        // 6자리 랜덤 숫자
        String code = String.format("%06d", new Random().nextInt(1000000));
        long now = System.currentTimeMillis();

        // 메일 내용
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(to);
        message.setSubject("이메일 인증 코드");
        message.setText("인증 코드는 " + code + " 입니다.");

        mailSender.send(message);

        return new VerificationCode(code, now);
    }
    
    public List<MemberDTO> findIDByEmail(String name, String email) {
    	return memberMapper.findIDByEmail(name, email);
    }
    // coolsms SDK 초기화
    private final DefaultMessageService messageService;
    
    public MemberService() {
        this.messageService = NurigoApp.INSTANCE.initialize(
            "NCSDRNA4CCZ6TBFG", // 발급받은 API KEY
            "CFZESZURTBU8LKBYL6H1CA05IIZN7WIC", // 발급받은 API SECRET
            "https://api.coolsms.co.kr"
        );
    }
    
    // 휴대전화 인증코드 발송
    public VerificationCode sendVerificationCodeSms(String phoneNumber) {
        String code = String.format("%06d", new Random().nextInt(1000000));
        long now = System.currentTimeMillis();

        Message message = new Message();
        message.setFrom("01085558529"); // 사전에 등록된 발신번호
        message.setTo(phoneNumber);
        message.setText("[인증번호] " + code + " 를 입력해주세요.");

        try {
            messageService.sendOne(new SingleMessageSendingRequest(message));
        } catch (Exception e) {
            throw new RuntimeException("SMS 발송 실패: " + e.getMessage(), e);
        }

        return new VerificationCode(code, now);
    }
    
    public List<MemberDTO> findIDByTel(String name, String tel) {
        return memberMapper.findIDByTel(name, tel);
    }
    
    // 이메일로 비밀번호 변경
    public boolean changePWByEmail(String password, String username, String name, String email) {
        String encoded = passwordEncoder.encode(password);
        int updated = memberMapper.changePWByEmail(encoded, username, name, email);
        return updated > 0; // 변경된 행 수가 1 이상이면 성공
    }

    // 전화번호로 비밀번호 변경
    public boolean changePWByTel(String password, String username, String name, String tel) {
        String encoded = passwordEncoder.encode(password);
        int updated = memberMapper.changePWByTel(encoded, username, name, tel);
        return updated > 0;
    }
}
