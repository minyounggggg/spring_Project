show tables;

CREATE TABLE friends (
	idx INT NOT NULL AUTO_INCREMENT,
	mid VARCHAR(20) NOT NULL,
	friendMid VARCHAR(20) NOT NULL,
	success CHAR(2) NULL DEFAULT 'NO',
	PRIMARY KEY (idx),
	FOREIGN KEY (mid) REFERENCES member (mid) on update cascade on delete cascade,
	FOREIGN KEY (friendMid) REFERENCES member (mid) on update cascade on delete cascade
);

insert into friends values (default, 'cmy1234', 'admin', 'OK');
insert into friends values (default, 'admin', 'cmy1234', 'OK');
insert into friends values (default, 'cmy1234', 'btom', DEFAULT);
insert into friends values (default, 'cmy1234', 'ctom', 'OK');
insert into friends values (default, 'ctom', 'cmy1234', 'OK');

drop table friends;