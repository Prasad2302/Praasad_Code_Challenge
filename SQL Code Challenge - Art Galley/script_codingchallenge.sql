create database VArt_Gallery;

use VArt_Gallery;

-- Create the Artists table
CREATE TABLE Artists ( 
ArtistID INT PRIMARY KEY, 
Name VARCHAR(255) NOT NULL, 
Biography TEXT, 
Nationality VARCHAR(100)); 

desc artists;

-- Create the Categories table
CREATE TABLE Categories ( 
CategoryID INT PRIMARY KEY, 
Name VARCHAR(100) NOT NULL); 

desc categories;

-- Create the Artworks table 
CREATE TABLE Artworks ( 
ArtworkID INT PRIMARY KEY, 
Title VARCHAR(255) NOT NULL, 
ArtistID INT, 
CategoryID INT, 
Year INT, 
Description TEXT, 
ImageURL VARCHAR(255), 
FOREIGN KEY (ArtistID) REFERENCES Artists (ArtistID), 
FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID));

desc artworks;

-- Create the Exhibitions table 
CREATE TABLE Exhibitions ( 
ExhibitionID INT PRIMARY KEY, 
Title VARCHAR(255) NOT NULL, 
StartDate DATE, 
EndDate DATE, 
Description TEXT);

desc exhibitions;

-- Create a table to associate artworks with exhibitions 
CREATE TABLE ExhibitionArtworks ( 
ExhibitionID INT, 
ArtworkID INT, 
PRIMARY KEY (ExhibitionID, ArtworkID), 
FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions (ExhibitionID), 
FOREIGN KEY (ArtworkID) REFERENCES Artworks (ArtworkID)); 

desc exhibitionArtworks;

-- Insert sample data into the Artists table 
INSERT INTO Artists (ArtistID, Name, Biography, Nationality) VALUES 
(1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'), 
(2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'), 
(3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian');

select * from artists;

-- Insert sample data into the Categories table 
INSERT INTO Categories (CategoryID, Name) VALUES 
(1, 'Painting'), 
(2, 'Sculpture'), 
(3, 'Photography'); 

select * from categories;

-- Insert sample data into the Artworks table 
INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) VALUES 
(1, 'Starry Night', 2, 1, 1889, 'A famous painting by Vincent van Gogh.', 'starry_night.jpg'), 
(2, 'Mona Lisa', 3, 1, 1503, 'The iconic portrait by Leonardo da Vinci.', 'mona_lisa.jpg'), 
(3, 'Guernica', 1, 1, 1937, 'Pablo Picasso\'s powerful anti-war mural.', 'guernica.jpg'); 

select * from artworks;

-- Insert sample data into the Exhibitions table 
INSERT INTO Exhibitions (ExhibitionID, Title, StartDate, EndDate, Description) VALUES 
(3, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'A collection of modern art masterpieces.'), 
(4, 'Renaissance Art', '2023-04-01', '2023-06-01', 'A showcase of Renaissance art treasures.');

select * from exhibitons;

-- Insert artworks into exhibitions 
INSERT INTO ExhibitionArtworks (ExhibitionID, ArtworkID) VALUES 
(3, 1), 
(3, 2), 
(3, 3), 
(4, 2);

select a.name, count(b.artworkID)
from artists as a
join artworks as b on 
a.artistID = b.artistID
group by 
a.artistID , a.name  
order by count(b.artworkID) desc;

Select a.title, b.nationality, a.year
from artworks as a 
join artists as b on b.artistID = a.artistID
where nationality = 'spanish' or nationality = 'dutch'
order by a.year asc;

select * from artworks;

select a.name, count(c.artworkID)
from artists as a
join artworks as c on a.artistID = c.artistID
join categories as b on  b.categoryID= c.categoryID
where b.name = 'painting'
group by a.artistID , a.name
order by count(c.artworkid) desc;


Select a.title as nameofartwork, b.name as artistname, c.name as categoryname
From artworks as a 
join ExhibitionArtworks as ea on a.artworkID = ea.artworkID
Join exhibitions as e on ea.exhibitionID = e.exhibitionID
Join artists as b on b.artistid = a.artistID
Join categories c on a.categoryid = c.categoryID
where e.title = 'modern art masterpieces';

select a.artistid, a.name, count(b.artworkID) as Numberofartworks
from artists as a
join artworks as b on a.artistID = b.artistid
group by a.artistid
having Numberofartworks > 2;



Select aw.title
From exhibitionartworks as ea
Join artworks as aw on ea.artworkID = aw.artworkID
Join exhibitions as e on ea.exhibitionID = e.exhibitionID 
Where e.title = 'modern art masterpieces' OR e.title = 'renaissance art'
group by aw.artworkid, aw.title;

select c.name as categoryname, count(aw.artworkid) as numberofartwork
from artworks as aw
join categories as c on aw.categoryid = c.categoryid
group by categoryname;


Select a.artistID, a.name, count(aw.artworkID) as numberofArtworks
From artists as a
Join artworks as aw on a.artistid = aw.artistid
group by a.artistID, a.name
having numberofArtworks > 3;

Select aw.artworkid, aw.title,  a.name, a.nationality
From artworks as aw
Join artists as a on aw.artistID = a.artistID
where nationality = 'Spanish';  -- specify nationality here 


Select e.exhibitionID, e.title 
from exhibitionartworks as ea
Join artworks as aw on ea.artworkID = aw.artworkID
Join artists as a on aw.artistid = a.artistid
Join exhibitions as e on ea.exhibitionID = e.exhibitionID
Where a.name = 'Vincent van Gogh' and 'Leonardo da Vinci';

Select aw.artworkID, aw.title
From artworks as aw
left Join exhibitionartworks as ea on ea.artworkid = aw.artworkid
Where ea.exhibitionID is null;





Select  c.name, count(aw.artworkID) as totalArtworks
From categories c 
Join artworks as aw on c.categoryID = aw.categoryID 
Group by c.name;

Select a.name as artistName, count(aw.artworkID) as NumberofArtworks
From artists as a 
Join artworks as aw on a.artistID = aw.artistID
Group by artistName
Having NumberofArtworks > 2;

Select c.name, avg(aw.year) as avgrageYear
From categories as c
Join artworks as aw on c.categoryID = aw.categoryID
Group by c.name
Having count(aw.artworkID > 1);

select * from artworks;

select aw.title
from artworks as aw
join exhibitionArtworks as ea on aw.artworkid = ea.artworkID
join exhibitions as e on ea.exhibitionID = e.exhibitionID
where e.title = 'Modern Art Masterpieces';

Select c.categoryID, c.name, avg(aw.year) as AvgYear
From categories as c
Join artworks as aw on c.categoryID = aw.categoryID
Group by c.categoryID, c.name 
Having AvgYear > (select avg(Year) from artworks);

Select aw.artworkID 
From artworks as aw
Join exhibitionartworks as ea on aw.artworkID = ea.artworkID
Where ea.exhibitionID is null;

Select a.artistID
From artists as a
Join artworks as aw on a.artistID = aw.artistID 
Where aw.categoryID = (select categoryID from artworks where title = 'mona lisa');


select * from artworks;

Select a.name, count(aw.artworkID) as numberofArtworks
From artists as a 
Join artworks as aw on a.artistID = aw.artistID
Group by a.name;

Select a.name 
From artists as a 
Join artworks as aw on a.artistID = aw.artistID
Group by a.name 
Having count(distinct aw.categoryid ) = (select count(distinct categoryID) from categories);

