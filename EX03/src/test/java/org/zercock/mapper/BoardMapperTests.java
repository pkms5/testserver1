package org.zercock.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import org.zerock.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
//	@Setter(onMethod_ = @Autowired)
	@Autowired
	private BoardMapper mapper; //주입
	

	@Test
	public void testGetList() {
		// getList()의 return값은 List<BoardVO>.
		// List에서 한 개씩 꺼내서 boardVO 매개변수에 저장한 다음 log.info로 출력.
		mapper.getList().forEach(boardVo -> log.info(boardVo));
		
	}
	
	
	
	
	

}
