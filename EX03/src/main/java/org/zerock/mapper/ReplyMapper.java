package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface ReplyMapper {
	//등록
	public int insert(ReplyVO vo);
	//상세보기
	public ReplyVO read(Long rno);
	//삭제
	public int delete(Long rno);
	//수정
	public int update(ReplyVO vo);
	//목록 with paging. parameter가 2개 이상일 때 @Param사용 필요.
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri,@Param("bno") Long bno);
	//댓글갯수
	public int getCountByBno(Long bno);
	
}
