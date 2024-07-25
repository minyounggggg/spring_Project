show tables;

create table reviewComment (
	idx   		int not null auto_increment,  	/* 댓글 고유번호 */
	commentLev	int not null,					/* 댓글, 대댓글 분류 */
	commentCnt  int not null, 					/* 댓글 순번 */
  	part  		varchar(20) not null,			/* 분야(게시판:board, 자료실:pds....) */
  	partIdx  	int not null,					/* 해당 분야의 고유번호 */
  	mid			varchar(20) not null,			/* 댓글 올린이 */
  	nickName 	varchar(20) not null,			/* 댓글 올린이 닉네임 */
  	photo		varchar(100) not null,			/* 댓글작성자 프로필 사진 */
  	content	 	text,							/* 댓글 내용 */
  	uploadDate	datetime default now(),			/* 댓글 등록일자 */
  	primary key(idx),
  	foreign key(partIdx) references productReview(idx),
  	foreign key(nickName) references member(nickName)
);

desc reviewComment;
select * from reviewComment;

drop table reviewComment;


insert into reviewComment values (default, 0, 1, 'productReview', '7', 'atom', '아톰', 'noimage.png', '튼튼한가요?', default);
insert into reviewComment values (default, 1, 2, 'productReview', '7', 'cmy1234', '민영9', 'noimage.png', '맞춰보세용', default);
insert into reviewComment values (default, 0, 3, 'productReview', '7', 'atom', '아톰', 'noimage.png', '강아지가 참 귀엽네요', default);
insert into reviewComment values (default, 1, 4, 'productReview', '7', 'cmy1234', '민영9', 'noimage.png', '고마워용', default);
insert into reviewComment values (default, 1, 5, 'productReview', '7', 'cmy1234', '민영9', 'noimage.png', '당신도 귀여워용', default);
insert into reviewComment values (default, 0, 1, 'cafeReview', 23, 'cmy1234', '민영9', 'noimage.png', '맛있나요', default);

select * from reviewComment where part = 'productReview' and partIdx = 7 order by commentCnt;