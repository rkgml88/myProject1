package org.zerock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.zerock.domain.MemberDTO;
import org.zerock.mapper.MemberMapper;

@Service("userDetailsService") // XML에서 참조 가능하도록 Bean 이름 지정
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
    private MemberMapper memberMapper;

    @Override
    public UserDetails loadUserByUsername(String allID) throws UsernameNotFoundException {
        MemberDTO member = memberMapper.findByAllID(allID); // DB 조회

        if (member == null) {
            throw new UsernameNotFoundException("사용자를 찾을 수 없습니다: " + allID);
        }

        // UserDetails 구현체 반환 (Spring Security에서 제공하는 User 사용 가능)
        return org.springframework.security.core.userdetails.User
        		.withUsername(
    			    member.getUsername() != null ? member.getUsername() :
    			    member.getNaverId() != null ? member.getNaverId() :
    			    member.getGoogleId()
    			)
                .password(member.getPassword() != null ? member.getPassword() : "{noop}") // 소셜 로그인 시 password 없을 수 있음
                .roles("USER") // 권한 설정
                .build();
    }
}

