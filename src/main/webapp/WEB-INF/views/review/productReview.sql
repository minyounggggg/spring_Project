show tables;

create table productReview (
	idx 				int not null auto_increment,
	mid 				varchar(30) not null,		/* 제품리뷰 올린사람 아이디 */
	nickName 			varchar(20) not null,		/* 제품리뷰 올린사람 닉네임 */
	petCategory 		varchar(10) not null,		/* 반려동물 종류 */
	productCategory 	varchar(10) not null,		/* 제품 종류 */
	brand 				varchar(30) not null,		/* 제품브랜드 */
	productName 		varchar(50) not null,		/* 제품이름 */
	memberHeart 		int not null default 1,		/* 반려인 만족도 */
	petHeart 			int not null default 1,		/* 반려동물 선호도 */
	goodPoint 			text not null,				/* 좋은점 */
	badPoint 			text not null,				/* 아쉬운점 */
	productPhoto 		varchar(100) not null,		/* 제품사진 */
	repurchase 			varchar(10) not null,		/* 재구매 여부 */
	readNum 			int default 0,				/* 조회수 */
	uploadDate 			datetime default now(),		/* 제품 리뷰 업로드 일자 */
	complaint 			char(2) default 'NO',		/* 신고횟수 */
	goodHeart 			int default 0,				/* 좋아요 받은 수 */
	hostIp  			varchar(40) not null,		/* 글 올린이 IP */
	primary key (idx),
	foreign key(nickName) references member(nickName)
	on update cascade
	on delete restrict
);