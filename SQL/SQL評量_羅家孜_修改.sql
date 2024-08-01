-- ��@�m�� 2
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

-- ��@�m�� 3
insert into EVACUATION_FACILITY values
 ('B001', 'M001', 'C001', '�]�߿��˫n��j�H�����H��20��', 100, 1, '���J');
insert into EVACUATION_FACILITY values
 ('B002', 'M001', 'C002', '�]�߿��˫n��˫n���M����79��', 3142, 1, '�j��');
insert into EVACUATION_FACILITY values
 ('B003', 'M001', 'C003', '�]�߿��˫n��s�Ψ��s�s���T�q142��', 1072, 1, '�j��');
insert into EVACUATION_FACILITY values
 ('B004', 'M001', 'C004', '�]�߿����s��H�������ظ�1498��', 32, 1, '���@�]�I');
insert into EVACUATION_FACILITY values
 ('B005', 'M002', 'C005', '�]�߿��]�ߥ���]���̥���80��', 106, 1, '���J');
insert into EVACUATION_FACILITY values
 ('B006', 'M002', 'C005', '�]�߿��]�ߥ���]�����_��117��', 26, 1, '���J');
insert into EVACUATION_FACILITY values
 ('B007', 'M002', 'C005', '�]�߿��]�ߥ���]���շR��109��', 2038, 2, '�j��');
insert into EVACUATION_FACILITY values
 ('B008', 'M002', 'C005', '�]�߿��]�ߥ���]���j�P��53��', 128, 2, '�j��');
insert into EVACUATION_FACILITY values
 ('B009', 'M003', 'C006', '�]�߿��Y�������ڨ��M����102��', 353, 1, '���@�]�I');
insert into EVACUATION_FACILITY values
 ('B010', 'M003', 'C007', '�]�߿��Y���������������@��69��', 501, 1, '�p����');
insert into EVACUATION_FACILITY values
 ('B011', 'M003', 'C008', '�]�߿��Y�����H�q��������65��', 194, 1, '���J');
insert into EVACUATION_FACILITY values
 ('B012', 'M003', 'C008', '�]�߿��Y�����H�q��������116��', 78, 1, '�p����');

insert into POLICE_STATION values
 ('M001', '�˫n����', '�]�߿��˫n����ڵ�72��', '037-474796');
insert into POLICE_STATION values
 ('M002', '�]�ߤ���', '�]�߿��]�ߥ������109��', '037-320059');
insert into POLICE_STATION values
 ('M003', '�Y������', '�]�߿��Y����������503��', '037-663004');

insert into VILLAGE_OFFICE values
 ('C001', '�j�H��', '�]�߿��˫n��j�H�����q��1035��', '037-581072');
insert into VILLAGE_OFFICE values
 ('C002', '�˫n��', '�]�߿��˫n��˫n�����s��103��', '037-472735');
insert into VILLAGE_OFFICE values
 ('C003', '�s�Ψ�', '�]�߿��˫n��s�Ψ������14��', '037-614186');
insert into VILLAGE_OFFICE values
 ('C004', '�H����', '�]�߿����s��H����������136-1��', '037-724839');
insert into VILLAGE_OFFICE values
 ('C005', '��]��', '�]�߿��]�ߥ���]��������766��', '037-333240');
insert into VILLAGE_OFFICE values
 ('C006', '���ڨ�', '�]�߿��Y�������ڨ����ڸ�96��', '037-660001');
insert into VILLAGE_OFFICE values
 ('C007', '������', '�]�߿��Y�������������j��82��', '037-661145');
insert into VILLAGE_OFFICE values
 ('C008', '�H�q��', '�]�߿��Y�����H�q���H�q��53��1��', '037-616072');

-- ��@�m�� 4-1
-- �C�X�Һްϰ줺����@�����]�I�j�� 1000 �e�H�ƶq�� �Һޤ��� �� �����s���q��
select distinct 
 PS.POLICE_STATION as "�Һޤ���",
 PS.POLICE_TEL as "�����s���q��"
 from STUDENT.POLICE_STATION PS
 inner join STUDENT.EVACUATION_FACILITY EF
 on PS.POLICE_NO = EF.POLICE_STATION
 where EF.FACILITY_CAPACITY > '1000';
    
-- ��@�m�� 4-2
-- �C�X�Һްϰ줺����@�����]�I�j�� 1000 �e�H�ƶq�� �Һޤ��� �� �����s���q�� �íp��X �]�I�ƶq
select
 PS.POLICE_STATION as "�Һޤ���",
 PS.POLICE_TEL as "�����s���q��",
 count(EF.FACILITY_NO) as "�]�I�ƶq"
 from STUDENT.POLICE_STATION PS
 inner join STUDENT.EVACUATION_FACILITY EF
 on PS.POLICE_NO = EF.POLICE_STATION
 where EF.FACILITY_CAPACITY > '1000'
 group by PS.POLICE_STATION, PS.POLICE_TEL;

-- ��@�m�� 4-3
-- �ӤW�D�A�A�ɤW �����]�I�a�}�B����
select
 DATA.POLICE_STATION as "�Һޤ���",
 DATA.POLICE_TEL as "�����s���q��",
 DATA.NO as "�]�I�ƶq",
 EF.FACILITY_ADD as "�����]�I�a�}",
 EF.FACILITY_CLASS as "����"
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
 
-- CR�H����²�ƪ��A�ϥ� partition by
select
 PS.POLICE_STATION as "�Һޤ���",
 PS.POLICE_TEL as "�����s���q��",
 count(PS.POLICE_STATION) over (partition by PS.POLICE_STATION) as "�]�I�ƶq",
 EF.FACILITY_ADD as "�����]�I�a�}",
 EF.FACILITY_CLASS as "����"
 from STUDENT.EVACUATION_FACILITY EF
 inner join STUDENT.POLICE_STATION PS
 on EF.POLICE_STATION = PS.POLICE_NO
 where EF.FACILITY_CAPACITY > '1000';


-- ��@�m�� 4-4
-- �d�߳]�I�a�}�]�t�u���v�r�������]�I�A�C�X��ƥ����t �����O�B�����]�I�a�}�B�e�H�ƶq�B�Һޤ��� �� �����s���q��
select 
 VO.OFFICE_VILLAGE as "�����O",
 EF.FACILITY_ADD as "�����]�I�a�}",
 EF.FACILITY_CAPACITY as "�e�H�ƶq",
 PS.POLICE_STATION as "�Һޤ���",
 PS.POLICE_TEL as "�����s���q��"
 from EVACUATION_FACILITY EF
 inner join STUDENT.VILLAGE_OFFICE VO
 on EF.VILLAGE_OFFICE = VO.OFFICE_NO
 inner join STUDENT.POLICE_STATION PS
 on EF.POLICE_STATION = PS.POLICE_NO
 where EF.FACILITY_ADD like '%��%';
    
-- ��@�m�� 4-5
-- �d�ߩҦ����O�� ���J�Τj�� �������]�I�C�X��ƥ����]�t �����O�B�����줽�Ǧ�m�B�����]�I�a�}�B�e�H�ƶq
select 
 VO.OFFICE_VILLAGE as "�����O",
 VO.OFFICE_ADD as "�����줽�Ǧ�m",
 EF.FACILITY_ADD as "�����]�I�a�}",
 EF.FACILITY_CAPACITY as "�e�H�ƶq"
 from STUDENT.EVACUATION_FACILITY EF
 inner join STUDENT.VILLAGE_OFFICE VO
 on EF.VILLAGE_OFFICE = VO.OFFICE_NO
 where EF.FACILITY_CLASS in ('���J', '�j��');

/* ���קK��@5����Ƽv�T��@4�����G
   �N EVACUATION_FACILITY �ƻs�� EVACUATION_FACILITY2 �ѹ�@5�ϥ�
   �ê��W�Ω�s�W�ΧR�����y�k�p�U
*/
create table EVACUATION_FACILITY2 as select * from EVACUATION_FACILITY;

drop table EVACUATION_FACILITY2;

-- ��@�m�� 5-1
-- ��s�����]�I�a�}�O �]�߿��˫n��M����79�� ���e�H�ƶq�� 5000 �H
update STUDENT.EVACUATION_FACILITY2
 set FACILITY_CAPACITY = '5000'
 where FACILITY_ADD = '�]�߿��˫n��M����79��';

-- ��@�m�� 5-2
-- �R�������]�I�p�� 1000 �e�H�ƶq�����
delete from STUDENT.EVACUATION_FACILITY2
 where FACILITY_CAPACITY < '1000'; 
