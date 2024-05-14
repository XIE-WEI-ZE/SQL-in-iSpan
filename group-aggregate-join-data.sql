use photo_app2;
create table artists(
 id int not null primary key identity(1,1),
 artist_name nvarchar(50) not null unique
);
go
create table songs(
  id int not null primary key identity(1,1),
  song_name nvarchar(50) not null,
  artist_id int,
  foreign key (artist_id) references artists(id) on delete cascade
);
go
insert into artists(artist_name)
values('Jay'), ('Leo王'), ('陳綺貞'),('太研');
go
insert into songs(song_name, artist_id)
values('以父之名', 1),('夜的第七章',1),('快樂的甘蔗人',2),('旅行的意義',3),('私奔到月球',3),('Spark',4);