show tables;

create table memberPet (
	idx       		int not null auto_increment,		/* 회원 고유번호 */
	petWith       	varchar(30) not null,				/* 반려동물 주인 아이디 */
	petName       	varchar(10) not null,				/* 반려동물 이름 */
	petGender       varchar(5) default '남아' not null,	/* 반려동물 성별 */
	petBirthday     varchar(10) not null,				/* 반려동물 생일 */
	petPhoto		varchar(100) default 'noimage-pet.png', /* 반려동물 사진 */		/*vo에 저장된이름*/
	petInfo			varchar(100), 						/* 반려동물 소개 */
	playWith		varchar(100), 						/* 하고싶은 동네 생활 */
	primary key (idx),
	foreign key(petWith) references member(mid)
	on update cascade
	on delete restrict
);

insert into memberPet values (default, 'cmy1234', '멍멍이', '여아', '2010-03-22', default, '귀여워용', '같이 산책해용');
insert into memberPet values (default, 'cmy1234', '야옹이', '남아', '2022-10-02', default, '멋있어용', '같이 정보공유해용');

insert into memberPet values (default, 'atom', '댕댕이', '남아', '2012-03-12', default, '똑똑해요', '같이 정보공유해용');
insert into memberPet values (default, 'btom', '냥냥이', '남아', '2019-05-04', default, '웃겨용', '같이 산책도하고 친구도해요');
insert into memberPet values (default, 'btom', '깜둥이', '여아', '2023-12-25', default, '식탐이 많아용', '친구를 만들고싶어요!');
insert into memberPet values (default, 'btom', '흰둥이', '중성화', '2024-06-16', default, '깔끔해용', '재밌는곳 공유하며 놀아요!');

desc memberPet;

select * from memberPet;

select * from memberPet where petWith = 'btom';

drop table memberPet;