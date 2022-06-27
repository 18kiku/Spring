package com.mall.service;

import java.util.List;

public interface MemberService {
	MemberDTO login(MemberDTO dto);
	void insertMember(MemberDTO dto);
	void updateMember(MemberDTO dto);
	void deleteMember(MemberDTO dto);
	MemberDTO getMember(MemberDTO dto);
	List<MemberDTO> getMemberList(MemberDTO dto);
}
