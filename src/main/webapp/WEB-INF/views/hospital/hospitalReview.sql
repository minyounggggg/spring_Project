show tables;

create table hospitalReview (
	idx 			int not null auto_increment,
	placeIdx		int not null,				/* 장소 고유번호 */
	mid 			varchar(30) not null,		/* 제품리뷰 올린사람 아이디 */
	nickName 		varchar(20) not null,		/* 제품리뷰 올린사람 닉네임 */
	photo 			varchar(100) not null,		/* 제품리뷰 올린사람 프로필 사진 */
	title 			varchar(100) not null,		/* 업로드 파일의간단 제목 */
	content 		text,						/* 업로드 파일의 상세 설명 */
	returnVisit 	char(2) not null,			/* 재방문 여부 OK, NO, Um */
	readNum 		int default 0,				/* 조회수 */
	uploadDate 		datetime default now(),		/* 제품 리뷰 업로드 일자 */
	complaint 		int default 0,				/* 신고횟수 3번이면 삭제처리*/
	goodHeart 		int default 0,				/* 좋아요 받은 수 */
	hostIp  		varchar(40) not null,		/* 글 올린이 IP */
	primary key (idx),
	foreign key(nickName) references member(nickName) on update cascade on delete restrict
);

insert into petCafeReview values (default,505,'cmy1234','민영9','noimage.png','커피도 디저트도 다 맛있어요','분위기도 전체적으로 밝은 분위기였고 개방적이여서 강아지들이 뛰어놀기 좋아요.','noimage.png','noimage123.png','OK',default,default,default,default,'192.168.50.53');
insert into petCafeReview values (default,505,'minmin0325','최민영','noimage.png','별로였어요','분위기도 Ewwww 밝은 분위기 Ewwwww 개방적이여서 Ewwwwwwwwww','noimage.png','noimage123.png','NO',default,default,default,default,'192.168.50.53');

desc petCafeReview;

select * from petCafeReview;

select * from petCafeReview order by idx desc;

drop table petCafeReview;