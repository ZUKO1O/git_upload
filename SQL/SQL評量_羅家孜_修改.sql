-- 實作練習 2
create table EVACUATION_FACILITY
 (FACILITY_NO varchar2(4) primary key,
  POLICE_STATION varchar2(4),
  VILLAGE_OFFICE varchar2(4),
  FACILITY_ADD nvarchar2(100),
  FACILITY_CAPACITY number(5),
  FACILITY_FLOOR number(2),
  FACILITY_CLASS nvarchar2(20));
     
create table POLICE_STATION
 (POLICE_NO varchar2(4) primary key,
  POLICE_STATION nvarchar2(20),
  POLICE_ADD nvarchar2(100),
  POLICE_TEL varchar2(10));
     
create table VILLAGE_OFFICE
 (OFFICE_NO varchar2(4) primary key,
  OFFICE_VILLAGE nvarchar2(10),
  OFFICE_ADD nvarchar2(100),
  OFFICE_TEL varchar2(10));

-- 實作練習 3
insert into EVACUATION_FACILITY values
 ('B001', 'M001', 'C001', '苗栗縣竹南鎮大埔里中埔街20號', 100, 1, '公寓');
insert into EVACUATION_FACILITY values
 ('B002', 'M001', 'C002', '苗栗縣竹南鎮竹南里和平街79號', 3142, 1, '大樓');
insert into EVACUATION_FACILITY values
 ('B003', 'M001', 'C003', '苗栗縣竹南鎮山佳里龍山路三段142號', 1072, 1, '大樓');
insert into EVACUATION_FACILITY values
 ('B004', 'M001', 'C004', '苗栗縣後龍鎮埔頂里中華路1498號', 32, 1, '公共設施');
insert into EVACUATION_FACILITY values
 ('B005', 'M002', 'C005', '苗栗縣苗栗市綠苗里米市街80號', 106, 1, '公寓');
insert into EVACUATION_FACILITY values
 ('B006', 'M002', 'C005', '苗栗縣苗栗市綠苗里光復路117號', 26, 1, '公寓');
insert into EVACUATION_FACILITY values
 ('B007', 'M002', 'C005', '苗栗縣苗栗市綠苗里博愛街109號', 2038, 2, '大樓');
insert into EVACUATION_FACILITY values
 ('B008', 'M002', 'C005', '苗栗縣苗栗市綠苗里大同路53號', 128, 2, '大樓');
insert into EVACUATION_FACILITY values
 ('B009', 'M003', 'C006', '苗栗縣頭份市民族里和平路102號', 353, 1, '公共設施');
insert into EVACUATION_FACILITY values
 ('B010', 'M003', 'C007', '苗栗縣頭份市忠孝里忠孝一路69號', 501, 1, '私營單位');
insert into EVACUATION_FACILITY values
 ('B011', 'M003', 'C008', '苗栗縣頭份市信義里中正路65號', 194, 1, '公寓');
insert into EVACUATION_FACILITY values
 ('B012', 'M003', 'C008', '苗栗縣頭份市信義里中正路116號', 78, 1, '私營單位');

insert into POLICE_STATION values
 ('M001', '竹南分局', '苗栗縣竹南鎮民族街72號', '037-474796');
insert into POLICE_STATION values
 ('M002', '苗栗分局', '苗栗縣苗栗市金鳳街109號', '037-320059');
insert into POLICE_STATION values
 ('M003', '頭份分局', '苗栗縣頭份市中興路503號', '037-663004');

insert into VILLAGE_OFFICE values
 ('C001', '大埔里', '苗栗縣竹南鎮大埔里公義路1035號', '037-581072');
insert into VILLAGE_OFFICE values
 ('C002', '竹南里', '苗栗縣竹南鎮竹南里中山路103號', '037-472735');
insert into VILLAGE_OFFICE values
 ('C003', '山佳里', '苗栗縣竹南鎮山佳里國光街14號', '037-614186');
insert into VILLAGE_OFFICE values
 ('C004', '埔頂里', '苗栗縣後龍鎮埔頂里中興路136-1號', '037-724839');
insert into VILLAGE_OFFICE values
 ('C005', '綠苗里', '苗栗縣苗栗市綠苗里中正路766號', '037-333240');
insert into VILLAGE_OFFICE values
 ('C006', '民族里', '苗栗縣頭份市民族里民族路96號', '037-660001');
insert into VILLAGE_OFFICE values
 ('C007', '忠孝里', '苗栗縣頭份市忠孝里光大街82號', '037-661145');
insert into VILLAGE_OFFICE values
 ('C008', '信義里', '苗栗縣頭份市信義里信義路53巷1號', '037-616072');

-- 實作練習 4-1
-- 列出轄管區域內有單一避難設施大於 1000 容人數量的 轄管分局 及 分局連絡電話
select distinct 
 PS.POLICE_STATION as "轄管分局",
 PS.POLICE_TEL as "分局連絡電話"
 from STUDENT.POLICE_STATION PS
 inner join STUDENT.EVACUATION_FACILITY EF
 on PS.POLICE_NO = EF.POLICE_STATION
 where EF.FACILITY_CAPACITY > '1000';
    
-- 實作練習 4-2
-- 列出轄管區域內有單一避難設施大於 1000 容人數量的 轄管分局 及 分局連絡電話 並計算出 設施數量
select
 PS.POLICE_STATION as "轄管分局",
 PS.POLICE_TEL as "分局連絡電話",
 count(EF.FACILITY_NO) as "設施數量"
 from STUDENT.POLICE_STATION PS
 inner join STUDENT.EVACUATION_FACILITY EF
 on PS.POLICE_NO = EF.POLICE_STATION
 where EF.FACILITY_CAPACITY > '1000'
 group by PS.POLICE_STATION, PS.POLICE_TEL;

-- 實作練習 4-3
-- 承上題，再補上 避難設施地址、類型
select
 DATA.POLICE_STATION as "轄管分局",
 DATA.POLICE_TEL as "分局連絡電話",
 DATA.NO as "設施數量",
 EF.FACILITY_ADD as "避難設施地址",
 EF.FACILITY_CLASS as "類型"
 from STUDENT.EVACUATION_FACILITY EF
 inner join        
 (select
  PS.POLICE_NO,
  PS.POLICE_STATION,
  PS.POLICE_TEL,
  count(EF.FACILITY_NO) as NO
  from STUDENT.POLICE_STATION PS
  left join STUDENT.EVACUATION_FACILITY EF
  on PS.POLICE_NO = EF.POLICE_STATION
  where EF.FACILITY_CAPACITY > '1000'
  group by PS.POLICE_STATION, PS.POLICE_TEL, PS.POLICE_NO) DATA
 on EF.POLICE_STATION = DATA.POLICE_NO
 where EF.FACILITY_CAPACITY > '1000';
 
-- CR人員的簡化版，使用 partition by
select
 PS.POLICE_STATION as "轄管分局",
 PS.POLICE_TEL as "分局連絡電話",
 count(PS.POLICE_STATION) over (partition by PS.POLICE_STATION) as "設施數量",
 EF.FACILITY_ADD as "避難設施地址",
 EF.FACILITY_CLASS as "類型"
 from STUDENT.EVACUATION_FACILITY EF
 inner join STUDENT.POLICE_STATION PS
 on EF.POLICE_STATION = PS.POLICE_NO
 where EF.FACILITY_CAPACITY > '1000';


-- 實作練習 4-4
-- 查詢設施地址包含「中」字的避難設施，列出資料必須含 村里別、避難設施地址、容人數量、轄管分局 及 分局連絡電話
select 
 VO.OFFICE_VILLAGE as "村里別",
 EF.FACILITY_ADD as "避難設施地址",
 EF.FACILITY_CAPACITY as "容人數量",
 PS.POLICE_STATION as "轄管分局",
 PS.POLICE_TEL as "分局連絡電話"
 from EVACUATION_FACILITY EF
 inner join STUDENT.VILLAGE_OFFICE VO
 on EF.VILLAGE_OFFICE = VO.OFFICE_NO
 inner join STUDENT.POLICE_STATION PS
 on EF.POLICE_STATION = PS.POLICE_NO
 where EF.FACILITY_ADD like '%中%';
    
-- 實作練習 4-5
-- 查詢所有類別為 公寓及大樓 的避難設施列出資料必須包含 村里別、村里辦公室位置、避難設施地址、容人數量
select 
 VO.OFFICE_VILLAGE as "村里別",
 VO.OFFICE_ADD as "村里辦公室位置",
 EF.FACILITY_ADD as "避難設施地址",
 EF.FACILITY_CAPACITY as "容人數量"
 from STUDENT.EVACUATION_FACILITY EF
 inner join STUDENT.VILLAGE_OFFICE VO
 on EF.VILLAGE_OFFICE = VO.OFFICE_NO
 where EF.FACILITY_CLASS in ('公寓', '大樓');

/* 為避免實作5的資料影響實作4的結果
   將 EVACUATION_FACILITY 複製至 EVACUATION_FACILITY2 供實作5使用
   並附上用於新增或刪除的語法如下
*/
create table EVACUATION_FACILITY2 as select * from EVACUATION_FACILITY;

drop table EVACUATION_FACILITY2;

-- 實作練習 5-1
-- 更新避難設施地址是 苗栗縣竹南鎮和平街79號 的容人數量為 5000 人
update STUDENT.EVACUATION_FACILITY2
 set FACILITY_CAPACITY = '5000'
 where FACILITY_ADD = '苗栗縣竹南鎮和平街79號';

-- 實作練習 5-2
-- 刪除避難設施小於 1000 容人數量的資料
delete from STUDENT.EVACUATION_FACILITY2
 where FACILITY_CAPACITY < '1000'; 
