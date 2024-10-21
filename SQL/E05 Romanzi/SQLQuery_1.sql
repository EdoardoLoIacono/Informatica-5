--ROMANZI(CodiceR, Titolo, NomeAut*, Anno)
--PERSONAGGI(NomeP, CodiceR*, sesso, ruolo)
--AUTORI(NomeAut, AnnoN, AnnoM:optional, Nazione)
--FILM(CodiceF, Titolo, Regista, Produttore, Anno, CodiceR*)



--1- Il titolo dei romanzi del 19° secolo
SELECT r.Titolo 
FROM Romanzi r 
WHERE r.Anno BETWEEN 1801 AND 1900
AND r.Anno IS NOT NULL
--2- Il titolo, l’autore e l’anno di pubblicazione dei romanzi di autori russi, ordinati per autore e, per
--lo stesso autore, ordinati per anno di pubblicazione
SELECT r.Titolo,r.NomeAut,r.Anno 
FROM Romanzi r 
JOIN Autori a ON r.NomeAut = a.NomeAut 
WHERE a.Nazione = 'Russia'
ORDER BY a.NomeAut, r.Anno
--3- I personaggi principali (ruolo =”P”) dei romanzi di autori viventi.
SELECT p.NomeP 
FROM Personaggi p 
JOIN Romanzi r ON p.CodiceR = r.CodiceR 
JOIN Autori a ON r.NomeAut = a.NomeAut
WHERE p.ruolo = 'Protagonista'
AND a.AnnoM IS NULL
--4. I romanzi dai quali è stato tratto un film con lo stesso titolo del romanzo
SELECT r.Titolo 
FROM Romanzi r 
JOIN Film f ON r.Titolo = f.Titolo
--5- Il titolo, il regista e l’anno dei film tratti dal romanzo “Robin Hood”
SELECT f.Titolo, f.Regista, f.Anno 
FROM Film f 
WHERE f.CodiceR = (SELECT r.CodiceR
                   FROM Romanzi r
                   WHERE r.Titolo = 'Robin Hood')

--6- Per ogni autore italiano, l’anno del primo e dell’ultimo romanzo.
SELECT r.NomeAut,  MIN(r.Anno) AS minimo, MAX(r.Anno) AS max
FROM Romanzi r
JOIN Autori a ON r.NomeAut = a.NomeAut
WHERE a.Nazione = 'Italia'
GROUP BY r.NomeAut

--7- I nomi dei personaggi che compaiono in più di un romanzo, ed il numero dei romanzi nei quali compaiono
SELECT p.NomeP, COUNT(*) AS nRomanzi
FROM Romanzi r
JOIN Personaggi p ON p.CodiceR = r.CodiceR
GROUP BY p.NomeP
HAVING COUNT(*) > 1

--8- I romanzi di autori italiani dai quali è stato tratto più di un film
SELECT r.Titolo
FROM Romanzi r
JOIN Autori a ON a.NomeAut = r.NomeAut
JOIN Film f ON f.CodiceR = r.CodiceR
WHERE a.Nazione = 'Italia'
GROUP BY r.Titolo 
HAVING COUNT(*) > 1
--9- Il titolo dei romanzi dai quali non è stato tratto un film
SELECT r.Titolo 
FROM Romanzi r 
WHERE NOT EXISTS (SELECT * 
                  FROM Film f
                  WHERE f.CodiceR = r.CodiceR)
--10- Il titolo dei romanzi i cui personaggi principali son tutti femminili.
SELECT r.Titolo
FROM Romanzi r 
WHERE NOT EXISTS(SELECT *
                 FROM Personaggi p
                 WHERE p.CodiceR = r.CodiceR
                 AND p.Sesso = 'M'
                 AND p.Ruolo = 'Protagonista')