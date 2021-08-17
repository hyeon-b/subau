package com.subau.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.subau.model.MailBoxVO;

public interface MailBoxService {

	/* 게시판 목록 */
    public List<MailBoxVO> getList(String recver);
 
    /*매칭끊기*/
    public Integer matchDel(@Param("recver") String recver, @Param("sender") String sender);
}
