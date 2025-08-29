package org.zerock.mapper;

import java.util.List;

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

	void deleteMember(String allID);
	
	List<MemberDTO> findIDByEmail(@Param("name") String name, @Param("email") String email);
	
	List<MemberDTO> findIDByTel(@Param("name") String name, @Param("tel") String tel);
	
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
