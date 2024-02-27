package org.zerock.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Getter
@Setter
public class ReplyPageDTO {
	private int replyCnt;
	private List<ReplyVO> list;
}
