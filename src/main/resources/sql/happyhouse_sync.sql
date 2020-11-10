use happyhouse;

-- 관리자 계정 추가
insert into `member`
values ('admin', 'admin', 'hello@admin.com');

-- housedeal 처리하기
alter table housedeal drop `code`;
alter table housedeal add `code` int not null default 0;
update housedeal deal set deal.`code` = (select `code` from baseaddress base where deal.dong = base.dong) where deal.`no` >= 1 and deal.`no` < 10000;
update housedeal deal set deal.`code` = (select `code` from baseaddress base where deal.dong = base.dong) where deal.`no` >= 10000 and deal.`no` < 20000;
update housedeal deal set deal.`code` = (select `code` from baseaddress base where deal.dong = base.dong) where deal.`no` >= 20000 and deal.`no` < 30000;
update housedeal deal set deal.`code` = (select `code` from baseaddress base where deal.dong = base.dong) where deal.`no` >= 30000 and deal.`no` < 40000;
update housedeal deal set deal.`code` = (select `code` from baseaddress base where deal.dong = base.dong) where deal.`no` >= 40000 and deal.`no` < 60000;
update housedeal deal set deal.`code` = (select `code` from baseaddress base where deal.dong = base.dong) where deal.`no` >= 60000;

-- houseinfo 처리하기
update houseinfo info set info.`code` = (select `code` from baseaddress base where info.dong = base.dong) where info.`no` >= 1 and info.`no` < 10000;