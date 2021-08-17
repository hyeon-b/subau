package com.subau.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.subau.mapper.MailBoxMapper;
import com.subau.model.MailBoxVO;

@Service
public class MailBoxServiceImpl implements MailBoxService{

	@Autowired
	private MailBoxMapper mapper;
	
	/*게시판 목록*/
	@Override
    public List<MailBoxVO> getList(String recver) {
		return mapper.getList(recver);
    }
	
	/*매칭끊기*/
	@Override
	public Integer matchDel(@Param("recver") String recver, @Param("sender") String sender) {
		return mapper.matchDel(recver, sender);
    }
	
}
