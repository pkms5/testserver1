package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Service // 없으면 500번 에러. internal server error
@AllArgsConstructor // 모든 필드를 초기화하는 생성자를 만들어 줌.
@Log4j
public class BoardServiceImpl implements BoardService{

	//자동주입
	private BoardMapper mapper;
	
	
	@Override
	public List<BoardVO> getList() {		
		return mapper.getList();
	}

	@Override
	public void register(BoardVO board) {
		mapper.insertSelectKey(board);		
	}

	@Override
	public BoardVO get(Long bno) {		
		return mapper.read(bno);
	}

	@Override
	public boolean remove(Long bno) {
		return mapper.delete(bno)==1; //영향을 받은 행의 수가 1이면 삭제가 성공함.
	}

	@Override
	public boolean modify(BoardVO board) {		
		return mapper.update(board)==1; //영향을 받은 행의 수가 1이면 수정이 성공함.
	}

	@Override
	public int getTotal(Criteria cri) {
		
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		
		return mapper.getListWithPaging(cri);
	}

}
