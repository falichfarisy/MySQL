create database db_mahasiswa;

use db_mahasiswa;

create table kelas_1A(
id int auto_increment primary key,
nama varchar(100) not null,
no_hp int(15) not null
);

insert into kelas_1A (nama, no_hp)
values ('Arif syafarian', 4839273)

select * from kelas_1A

drop table kelas_1A;

drop database db_mahasiswa;