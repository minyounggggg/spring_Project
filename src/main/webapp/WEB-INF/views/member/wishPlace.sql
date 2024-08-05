show tables;

create table wishPlace (
	idx   		int not null auto_increment,  	/* 댓글 고유번호 */
	mid			varchar(20) not null,			/* 찜한사람 아이디 */
	nickName  	varchar(20) not null,			/* 찜한사람 닉네임 */
  	part  		varchar(20) not null,			/* 분야(카페, 병원....) */
  	placeIdx  	int not null,					/* 찜한 장소의 고유번호 */
  	placeName  	varchar(50) not null,			/* 찜한 장소 이름 */
  	saveDate	datetime default now(),			/* 찜한 날짜 */
  	primary key(idx),
  	foreign key(nickName) references member(nickName) on update cascade on delete cascade
  	/* cascade를 설정해줄땐 하나 설정했으면 다 설정해주기 */
);

desc wishPlace;
select * from wishPlace;

drop table wishPlace;

insert into wishPlace values (default, 'cmy1234', '민영9', 'petCafe', 819, '크루몽살롱', default);


select * from reviewComment where part = 'productReview' and partIdx = 7 order by commentCnt;

select * from reviewComment where part = 'productReview' and partIdx = 7 order by idx desc limit 1;


