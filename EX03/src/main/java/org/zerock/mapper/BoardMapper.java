package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper {
	//목록
	public List<BoardVO> getList();
	//등록
	public void insert(BoardVO board);
	//등록.key값 구하기
	public Integer insertSelectKey(BoardVO board);
	//상세보기
	public BoardVO read(Long bno);
	//삭제
	public int delete(Long bno);
	//수정
	public int update(BoardVO board);
	//전체글수
	public int getTotalCount(Criteria cri);
	//목록 with paging
	public List<BoardVO> getListWithPaging(Criteria cri);

}
