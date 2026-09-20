DROP TABLE IF EXISTS Reader CASCADE;
DROP TABLE IF EXISTS Book CASCADE;
DROP TABLE IF EXISTS Author CASCADE;
DROP TABLE IF EXISTS Authorship CASCADE;
DROP TABLE IF EXISTS Loan CASCADE;

create table Reader (
    id_reader serial primary key,
    full_name varchar(1000) not null,
    phone varchar(20) not null unique
);
 
create table Book (
    isbn_book varchar(20) primary key,
    name_book varchar(1000) not null,
    year_publication int not null check (year_publication between 1000 and 9999)
);
 
create table Author (
    id_author serial primary key,
    full_name_author varchar(1000) not null
);
 
create table Authorship (
    isbn_book varchar(20) not null,
    id_author int not null, 
    primary key (isbn_book, id_author),
    foreign key (isbn_book) references Book(isbn_book) on delete cascade,
    foreign key (id_author) references Author(id_author) on delete restrict
); 
 
create table Loan (
    id_issuance serial primary key,
    id_reader int not null,
    isbn_book varchar(20) not null,
    date_issuance date not null default current_date,
    planed_date_return date not null,
    actual_date_return date,
 
    foreign key (id_reader) references Reader(id_reader) on delete cascade,
    foreign key (isbn_book) references Book(isbn_book) on delete cascade,
 
    check (actual_date_return is null or actual_date_return >= date_issuance),
    check (planed_date_return >= date_issuance)
);