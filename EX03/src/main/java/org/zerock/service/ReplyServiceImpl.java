package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class ReplyServiceImpl implements ReplyService{
	private ReplyMapper mapper; //자동주입
	
	@Override
	public int register(ReplyVO vo) {		
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {		
		return mapper.read(rno);
	}

	@Override
	public int remove(Long rno) {		
		return mapper.delete(rno);
	}

	@Override
	public int modify(ReplyVO vo) {		
		return mapper.update(vo);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {		
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {		
		return new ReplyPageDTO(mapper.getCountByBno(bno),mapper.getListWithPaging(cri, bno));
	}

}
