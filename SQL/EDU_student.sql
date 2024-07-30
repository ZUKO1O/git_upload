create table SQL_EMP1(
    EMP_ID char(8) primary key,
    EMP_NM NVARCHAR2(20),
    ID VARCHAR2(10),
    TEL VARCHAR2(20),
    DEP VARCHAR2(20)
);

create table SQL_CUSTOMER1(
    ID VARCHAR(10) primary key,
    NAME NVARCHAR2(20),
    EMP CHAR(8) references SQL_EMP1(EMP_ID)
);

alter table SQL_CUSTOMER1
    add foreign key (EMP)
    references SQL_EMP1(EMP_ID);
    
alter table SQL_CUSTOMER1
    add primary key(ID);
    
alter table SQL_CUSTOMER1 add constraint SQL_CUSTOMER1_FK1
foreign key(EMP) references SQL_EMP1(EMP_ID);

desc SQL_CUSTOMER1;

create index SQL_EMP1_INDEX1 on SQL_EMP1(DEP);

create table WATER1 as select * from SQL_TAOYUAN_WATER;

select
    SERIAL_NUMBER as �Ǹ�,
    HYDROGEN as �B���l�@�׫���,
    TURBIDITY as �B��,
    CHLORINE as �ۥѦ��ľl��
from WATER1
where (SERIAL_NUMBER between 379 and 395)
    or SERIAL_NUMBER = 441
    or SERIAL_NUMBER = 481;
    
select TEL as ���� from SQL_EMP
where ID like 'A%';

select ID as ���X from SQL_EMP
 where DEP = '�t�ζ}�o��' or DEP = '�}�o�t�γ�';
 
select PLACE as �a�I
 from SQL_TAOYUAN_WATER
 where WATER_SYSTEM in('S04', 'S06');
 
select NAME from TABLE1
 where TEL is not null;

select
    SERIAL_NUMBER as �Ǹ�,
    HYDROGEN as �B���l�@��,
    TURBIDITY as �B��,
    CHLORINE as �ۥѦ��ľl��
 from SQL_TAOYUAN_WATER
 where
    HYDROGEN in('7.5','8')
 and
    CHLORINE > '0.6'
 and
    PLACE = 'T22';
    

select
    PLACE as �a�I,
    SERIAL_NUMBER as �Ǹ�,
    HYDROGEN as �B���l�@��,
    TURBIDITY as �B��,
    CHLORINE as �ۥѦ��ľl��
 from SQL_TAOYUAN_WATER
 where
    SERIAL_NUMBER between 521 and 529
 or 
    (HYDROGEN <> 7.8
 and
    CHLORINE in(0.76,0.77,0.66)
 and
    TURBIDITY = 0.6)
 order by TURBIDITY asc, SERIAL_NUMBER desc;
    
select �a�I, �Ǹ�, �B���l�@��, �B��, �ۥѦ��ľl�� from(
select
    PLACE as �a�I,
    SERIAL_NUMBER as �Ǹ�,
    HYDROGEN as �B���l�@��,
    TURBIDITY as �B��,
    CHLORINE as �ۥѦ��ľl��
 from SQL_TAOYUAN_WATER
 where
    SERIAL_NUMBER between 521 and 529
 union
 select
    PLACE as �a�I,
    SERIAL_NUMBER as �Ǹ�,
    HYDROGEN as �B���l�@��,
    TURBIDITY as �B��,
    CHLORINE as �ۥѦ��ľl��
 from SQL_TAOYUAN_WATER
 where
    HYDROGEN <> 7.8
 and
    CHLORINE in(0.76,0.77,0.66)
 and
    TURBIDITY = 0.6)
 order by �B�� asc, �Ǹ� desc;
  
select EMP_NM as �W�r from SQL_EMP
    where EMP_ID in (select distinct EMP from SQL_CUSTOMER);
 
 select CUT.ID, CUT.NAME, EMP.EMP_NM
  from SQL_CUSTOMER CUT full join SQL_EMP EMP
  on CUT.EMP = EMP.EMP_ID;

select �Ǹ�, �B���l�@��, �B��, �ۥѦ��ľl��,
    WATER_PURIFICATION_PLANT as �b���t,
    WATER_SUPPLY as �Ѥ��t��,
    TOWNSHIP as ��F��, 
    PLACE as ���q
from (
    select
    PLACE as �a�I,
    SERIAL_NUMBER as �Ǹ�,
    HYDROGEN as �B���l�@��,
    TURBIDITY as �B��,
    CHLORINE as �ۥѦ��ľl��,
    WATER_SYSTEM as �Ѥ��t��
 from SQL_TAOYUAN_WATER
 where
    SERIAL_NUMBER between 521 and 529 
 or
    (HYDROGEN <> 7.8 and CHLORINE in(0.76,0.77,0.66) and TURBIDITY = 0.6)) DATA
left join SQL_TAOYUAN_REGIONS
on SQL_TAOYUAN_REGIONS.SERIAL = DATA.�a�I
left join SQL_TAOYUAN_WATER_SYSTEM
on SQL_TAOYUAN_WATER_SYSTEM.SERIAL = DATA.�Ѥ��t��
order by �B�� asc, �Ǹ� desc;