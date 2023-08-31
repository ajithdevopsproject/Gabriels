create database wiselearns_mari;
use wiselearns_mari;

create table userdataa (UserId int primary key auto_increment,
Username varchar(20),
UserAddress nvarchar(30),
UserPhone nvarchar(25),
UserMail varchar(20),
UserProfileImg nvarchar(255),
DateUpdated DateTime);


desc wiselearns_mari.userdataa;

insert into wiselearns_mari.userdataa (username,useraddress,userphone,usermail,userprofileimg,dateupdated)
values('Maripandi P', 'Madurai', '901243625,6235489721', 'marip@domain.com', 'images/maripandi.jpg', now()),
  ('Neha', 'Salem', '966543625,9665986958', 'neha@domain.com', 'images/neha.jpg', now()),
  ('Williams', 'Coimbatur', '201243625,2365325487', 'williams@domain.com', 'images/williams.jpg', now()),
  ('Esthar', 'Tuticorn', '654233625,5698284587', 'Esthar@domain.com', 'images/Esthar.jpg', now()),
   ('Jacob Raj', 'thirunelvely', '362546598,2363698265', 'jacob@domain.com', 'images/jacob.jpg',now()),
   ('Kannu kumar','Namakkal','362543625,2365983265', 'kannu@domain.com', null,now()),
   ('Iqbhal','chennai','3625410987','iqbhal@domain.com','images/iqbhal.jpg',now()),
    ('Jegan','chennai','3625410987,2365987410','jegan@domain.com','images/jegan.jpg',now()),
     ('Rasitha','Madurai','3625410987','rasitha@domain.com','images/rasitha.jpg',now()),
      ('Begam','chennai','3625410987,2563147890','begam@domain.com','images/begam.jpg',now()),
      ('Shamitha','Karur','3625410987,2013546977','shamitha@domain.com','images/shamitha.jpg',now()),
       ('Suman','Karur','3625410987','suman@domain.com','images/suman.jpg',now()),
      ('Vignesh','Vellore','3625410987,2365987412','vignesh@domain.com','images/vignesh.jpg',now());
  
  
insert into userdataa (username,useraddress,userphone,usermail,userprofileimg,dateupdated)values('Georgia', 'Velly', '362543625,2365983636', 'georgia@domai.com', 'images/georgia.jpg',now()),('Suman2','Karur','36254109827,2136548790','suman2@domain.com',null,now());



# show tables;
select * from wiselearns_mari.userdataa;















-- use tradingbotdynamic;

-- select * from app_coindata;
-- select * from app_coinpair;
-- select * from app_coins;

-- select name,open,high,low,close from app_coins right join app_coindata on app_coins.id = app_coindata.id;
-- select name,open,high,low,close from app_coins right join app_coindata using(id);
-- select name,open,high,low,close from app_coindata  left join app_coins using(id) group by name;
-- select curdate(),current_date(),current_date,current_time();



