show tables;

create table productReview (
	idx 				int not null auto_increment,
	mid 				varchar(30) not null,		/* 제품리뷰 올린사람 아이디 */
	nickName 			varchar(20) not null,		/* 제품리뷰 올린사람 닉네임 */
	photo 				varchar(100) not null,		/* 제품리뷰 올린사람 프로필 사진 */
	petCategory 		varchar(10) not null,		/* 반려동물 종류 */
	productCategory 	varchar(10) not null,		/* 제품 종류 */
	brand 				varchar(30) not null,		/* 제품브랜드 */
	productName 		varchar(50) not null,		/* 제품이름 */
	memberHeart 		int not null default 1,		/* 반려인 만족도 */
	petHeart 			int not null default 1,		/* 반려동물 선호도 */
	goodPoint 			text not null,				/* 좋은점 */
	badPoint 			text not null,				/* 아쉬운점 */
	productPhoto 		varchar(500) not null,		/* 제품사진 */
	repurchase 			char(2) not null,			/* 재구매 여부 OK, NO, Um */
	readNum 			int default 0,				/* 조회수 */
	uploadDate 			datetime default now(),		/* 제품 리뷰 업로드 일자 */
	complaint 			int default 0,				/* 신고횟수 3번이면 삭제처리*/
	goodHeart 			int default 0,				/* 좋아요 받은 수 */
	hostIp  			varchar(40) not null,		/* 글 올린이 IP */
	primary key (idx),
	foreign key(nickName) references member(nickName) on update cascade on delete restrict
);

insert into productReview values (default,'cmy1234','민영9','noimage.png','강아지','장난감','바잇미','곰돌이인형',5,5,'크기도 적당하고 소리가 잘 나요','딱히 없습니다.','noimage.png','OK',2,'2024-07-01',0,0,'192.168.50.53');
insert into productReview values (default,'cmy1234','민영9','noimage.png','강아지','사료','로얄캐닌','냠냠쩝쩝',5,5,'크기도 적당하고 소리가 잘 나요','딱히 없습니다.','noimage.png','OK',2,'2024-07-01',0,0,'192.168.50.53');

desc productReview;

select * from productReview;

select * from productReview order by idx desc;

drop table productReview;