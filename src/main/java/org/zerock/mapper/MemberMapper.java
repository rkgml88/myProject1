package org.zerock.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.zerock.domain.MemberDTO;

@Mapper
public interface MemberMapper {
	
	void insertMember(MemberDTO member);
	
	int existsByUsername(String username);
	
	MemberDTO findByusername(String username);
	
	MemberDTO findByNaverId(String naverId);
	
	MemberDTO findByGoogleId(String googleId);
	
	MemberDTO findByAllID(String allID);
	
	void updateMember(MemberDTO member);

	void deleteMember(String username);
	
	String findIDByEmail(@Param("name") String name, @Param("email") String email);
	
	String findIDByTel(@Param("name") String name, @Param("tel") String tel);
	
	int changePWByEmail(
			@Param("password") String password, 
			@Param("username") String username, 
			@Param("name") String name, 
			@Param("email") String email);
	
	int changePWByTel(
			@Param("password") String password, 
			@Param("username") String username, 
			@Param("name") String name, 
			@Param("tel") String tel);
}
