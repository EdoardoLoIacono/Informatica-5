/*1- Il nome di tutte le sale di Pisa*/
SELECT Nome
FROM Sale
WHERE Città = 'Pisa'

/*2- Il titolo dei film di F. Fellini prodotti dopo il 1960.*/
SELECT Titolo
FROM Film
WHERE Regista = 'Fellini' AND AnnoProduzione > 1960

/*3- Il titolo dei film di fantascienza giapponesi o francesi prodotti dopo il 1990*/
SELECT Titolo
FROM Film
WHERE AnnoProduzione > 1990
AND (Nazionalità = 'Francia' OR (Nazionalità = 'Giappone' AND Genere = 'Fantascienza'))

/*4- Il titolo dei film di fantascienza giapponesi prodotti dopo il 1990 oppure francesi*/
SELECT Titolo
FROM Film
WHERE (Genere = 'Fantascienza' AND Nazionalità = 'Giappone' AND AnnoProduzione > 1990) OR (Nazionalità = 'Francia')

/*5- I titolo dei film dello stesso regista di “Casablanca”*/
SELECT f1.Titolo
FROM Film f1
WHERE f1.Regista =  (SELECT f2.Regista FROM Film f2 WHERE f2.Titolo = 'Casablanca')

/*6- Il titolo ed il genere dei film proiettati il giorno di Natale 2004*/
SELECT f.Titolo,f.Genere
FROM Film f
JOIN Proiezioni p ON f.CodFilm = p.CodFilm
Where p.DataProiezione = '2004-12-25' /*La data va scritta al CONTRARIO*/

/* 7- Il titolo ed il genere dei film proiettati a Napoli il giorno di Natale 2004 */
SELECT f.Titolo,f.Genere
FROM Film f
JOIN Proiezioni p ON f.CodFilm = p.CodFilm
JOIN Sale s ON p.CodSala = s.CodSala
WHERE s.Città = 'Napoli' AND p.DataProiezione = '2004-12-25'

/* 8- I nomi delle sale di Napoli in cui il giorno di Natale 2004 è stato proiettato un film con
R.Williams */
SELECT s.Nome
FROM Sale s
JOIN Proiezioni p ON s.CodSala = p.CodSala
JOIN Recita r ON p.CodFilm = r.CodFilm
JOIN Attori a ON r.CodAttore = a.CodAttore
WHERE a.Nome = 'Robin Williams' AND p.DataProiezione = '2004-12-25'

/* 9- Il titolo dei film in cui recita M. Mastroianni oppure S.Loren */
SELECT f.Titolo
FROM Film f
JOIN Recita r ON f.CodFilm = r.CodFilm
JOIN Attori a ON r.CodAttore = a.CodAttore
WHERE a.Nome = 'Marcello Mastroianni' OR a.Nome = 'Sophia Loren' 

/* 10- Il titolo dei film in cui recitano M. Mastroianni e S.Loren */
SELECT f.Titolo
FROM Film f
JOIN Recita r ON f.CodFilm = r.CodFilm
JOIN Attori a1 ON r.CodAttore = a1.CodAttore
JOIN Recita r2 ON f.CodFilm = r2.CodFilm
JOIN Attori a2 ON r2.CodAttore = a2.CodAttore
WHERE a1.Nome = 'Marcello Mastroianni' AND a2.Nome = 'Sophia Loren' 

/* 11- Per ogni film in cui recita un attore francese, il titolo del film e il nome dell’attore */
SELECT f.Titolo, a.Nome
FROM Film f
JOIN Recita r ON f.CodFilm = r.CodFilm
JOIN Attori a ON r.CodAttore = a.CodAttore
WHERE a.Nazionalità = 'Francia'

/* 12- Per ogni film che è stato proiettato a Pisa nel gennaio 2005, il titolo del film e il nome della
sala. */
SELECT f.Titolo,s.Nome
FROM Film f
JOIN Proiezioni p ON f.CodFilm = p.CodFilm
JOIN Sale s ON p.CodSala = s.CodSala
WHERE s.Città = 'Pisa' AND (p.DataProiezione BETWEEN '2005-01-01' AND '2005-01-31')

/*13- Il numero di sale di Pisa con più di 60 posti*/
SELECT COUNT(*) AS nSale
FROM Sale s
WHERE s.Città = 'Pisa' AND s.Posti > 60

/* 14- Il numero totale di posti nelle sale di Pisa*/
SELECT SUM(s.Posti) AS totPosti
FROM Sale s
WHERE s.Città = 'Pisa'

/*15- Per ogni città, il numero di sale*/
SELECT s.Città, COUNT(*) AS nSale
FROM Sale s
GROUP BY s.Città

/*16- Per ogni città, il numero di sale con più di 60 posti*/
SELECT s.Città, COUNT(*) AS nSale
FROM Sale s
WHERE s.Posti > 60
GROUP BY s.Città

/*17- Per ogni regista, il numero di film diretti dopo il 1990*/
SELECT f.Regista, COUNT(*) AS nFilm
FROM Film f
WHERE f.AnnoProduzione > 1990
GROUP BY f.Regista

/*18- Per ogni regista, l’incasso totale di tutte le proiezioni dei suoi film*/
SELECT f.Regista, SUM(p.Incasso) AS totIncasso
FROM Proiezioni p
JOIN Film f ON p.CodFilm = f.CodFilm
GROUP BY f.Regista

/*19- Per ogni film di S.Spielberg, il titolo del film, il numero totale di proiezioni a Pisa e l’incasso
totale*/
SELECT f.Titolo, COUNT(p.CodFilm) AS nProiezioni, SUM(p.Incasso) AS totIncasso
FROM Film f
JOIN Proiezioni p ON f.CodFilm = p.CodFilm
JOIN Sale s ON p.CodSala = s.CodSala
WHERE s.Città = 'Pisa' AND f.Regista = 'Spielberg'
GROUP BY f.Titolo

/*20- Per ogni regista e per ogni attore, il numero di film del regista con l’attore*/
SELECT f.Regista, a.Nome, COUNT(*) AS nFilm
FROM Film f
JOIN Recita r ON f.CodFilm = r.CodFilm
JOIN Attori a ON r.CodAttore = a.CodAttore
GROUP BY f.Regista, a.Nome;

/*21 - Il regista ed il titolo dei film in cui recitano meno di 6 attori*/
SELECT f.Regista, f.Titolo
FROM Film f
JOIN Recita r ON f.CodFilm = r.CodFilm
GROUP BY f.Titolo, f.Regista 
HAVING COUNT(*) < 6

/*22- Per ogni film prodotto dopo il 2000, il codice, il titolo e l’incasso totale di tutte le sue
proiezioni*/
SELECT f.codFilm, f.Titolo, SUM(p.Incasso) AS totIncasso
FROM Film f
JOIN Proiezioni p ON f.CodFilm = p.CodFilm
WHERE f.AnnoProduzione > 2000
GROUP BY f.CodFilm,f.Titolo

/*23 - Il numero di attori dei film in cui appaiono solo attori nati prima del 1970*/
SELECT f.Titolo, COUNT(*) AS nAttori
FROM Attori a
JOIN Recita r ON a.CodAttore = r.CodAttore
JOIN Film f ON r.CodFilm = f.CodFilm
GROUP BY f.Titolo
HAVING MAX(a.AnnoNascita) < 1970 

/*24- Per ogni film di fantascienza, il titolo e l’incasso totale di tutte le sue proiezioni
*/
SELECT f.Titolo, SUM(p.Incasso) AS totFilm
FROM Film f
JOIN Proiezioni p ON f.CodFilm = p.CodFilm
WHERE f.Genere = 'Fantascienza'
GROUP BY f.Titolo

/*25- Per ogni film di fantascienza il titolo e l’incasso totale di tutte le sue proiezioni successive al
1/1/01*/
SELECT f.Titolo, SUM(p.Incasso) AS totFilm
FROM Film f
JOIN Proiezioni p ON f.CodFilm = p.CodFilm
WHERE f.Genere = 'Fantascienza' AND p.DataProiezione > '2001/01/01'
GROUP BY f.Titolo

/*26- Per ogni film di fantascienza che non è mai stato proiettato prima del 1/1/01 il titolo e
l’incasso totale di tutte le sue proiezioni*/
SELECT f.Titolo, SUM(p.Incasso) AS totFilm
FROM Film f
JOIN Proiezioni p ON f.CodFilm = p.CodFilm
WHERE f.Genere = 'Fantascienza'
GROUP BY f.Titolo
HAVING MIN(p.DataProiezione) >= '2001/01/01'

/*27- Per ogni sala di Pisa, che nel mese di gennaio 2005 ha incassato più di 20000 €, il nome della
sala e l’incasso totale (sempre del mese di gennaio 2005)*/
SELECT s.Nome, SUM(p.Incasso) AS totIncasso
FROM Sale s
JOIN Proiezioni p ON s.CodSala = p.CodSala
WHERE s.Città = 'Pisa' AND p.DataProiezione BETWEEN '2005/01/01' AND '2005/01/31'
GROUP BY s.Nome
HAVING SUM(p.Incasso) > 2000

/*28- I titoli dei film che non sono mai stati proiettati a Pisa*/
SELECT f.Titolo
FROM Film f
JOIN Proiezioni p ON f.CodFilm = p.CodFilm
JOIN Sale s ON p.CodSala = s.CodSala
WHERE NOT EXISTS (SELECT *
				  FROM Proiezioni p
				  JOIN Sale s ON p.CodSala = s.CodSala
				  WHERE f.CodFilm = p.CodFilm
				  AND s.Città = 'Pisa')
GROUP BY f.Titolo
/*OPPURE*/
SELECT *
FROM Film f
WHERE 'Pisa' NOT IN (SELECT s.Città
					 FROM Proiezioni p, Sale s
					 WHERE p.CodSala = s.CodSala
					 AND p.CodFilm = f.CodFilm)

/*29- I titoli dei film che sono stati proiettati solo a Pisa*/
SELECT f.Titolo
FROM Film f
JOIN Proiezioni p ON f.CodFilm = p.CodFilm
JOIN Sale s ON p.CodSala = s.CodSala
WHERE NOT EXISTS (SELECT *
				  FROM Proiezioni p
				  JOIN Sale s ON p.CodSala = s.CodSala
				  WHERE f.CodFilm = p.CodFilm
				  AND s.Città <> 'Pisa')
GROUP BY f.Titolo

/*30- I titoli dei film dei quali non vi è mai stata una proiezione con incasso superiore a 500 €*/
SELECT f.Titolo
FROM Film f
JOIN Proiezioni p ON f.CodFilm = p.CodFilm
WHERE NOT EXISTS (SELECT *
				  FROM Proiezioni p
				  WHERE f.CodFilm = p.CodFilm
				  AND p.Incasso > 500)
GROUP BY f.Titolo

/*31- I titoli dei film le cui proiezioni hanno sempre ottenuto un incasso superiore a 500 */
SELECT f.Titolo
FROM Film f
JOIN Proiezioni p ON f.CodFilm = p.CodFilm
WHERE NOT EXISTS (SELECT *
				  FROM Proiezioni p
				  WHERE f.CodFilm = p.CodFilm
				  AND p.Incasso < 500)
GROUP BY f.Titolo

/*32- Il nome degli attori italiani che non hanno mai recitato in film di Fellini*/
SELECT a.nome
FROM Attori a
JOIN Recita r ON a.CodAttore = r.CodAttore
JOIN Film f ON r.CodFilm = f.CodFilm
WHERE NOT EXISTS (SELECT *
				  FROM Film f
				  JOIN Recita r ON f.CodFilm = r.CodFilm
				  WHERE r.CodAttore = a.CodAttore
				  AND f.Regista = 'Fellini')
AND a.Nazionalità = 'Italia'
GROUP BY a.Nome

/*33- Il titolo dei film di Fellini in cui non recitano attori italiani*/
SELECT f.Titolo
FROM Film f
WHERE F.Regista = 'Fellini'
AND NOT EXISTS (
    SELECT *
    FROM Recita r
    JOIN Attori a ON r.CodAttore = a.CodAttore
    WHERE r.CodFilm = f.CodFilm
    AND a.Nazionalità = 'Italia'
	)
GROUP BY f.Titolo

/*34- Il titolo dei film senza attori*/
SELECT f.Titolo
FROM Film f
WHERE NOT EXISTS(Select *
				 FROM Recita r
				 WHERE r.CodFilm = f.CodFilm)
GROUP BY f.Titolo

/*35- Gli attori che prima del 1960 hanno recitato solo nei film di Fellini*/
SELECT *
FROM Attori a
JOIN Recita r ON a.CodAttore = r.CodAttore
JOIN Film f ON r.CodFilm = f.CodFilm
WHERE f.AnnoProduzione < 1960
AND NOT EXISTS (SELECT *
				FROM Film f
				JOIN Recita r ON f.CodFilm = r.CodFilm
				WHERE a.CodAttore = r.CodAttore
				AND f.Regista != 'Fellini')

/*36- Gli attori che hanno recitato in film di Fellini solo prima del 1960*/
SELECT *
FROM Attori a
JOIN Recita r ON a.CodAttore = r.CodAttore
JOIN Film f ON r.CodFilm = f.CodFilm
WHERE f.Regista = 'Fellini' 
AND NOT EXISTS (SELECT *
				FROM Film f
				JOIN Recita r ON f.CodFilm = r.CodFilm
				WHERE a.CodAttore = r.CodAttore
				AND f.AnnoProduzione > 1960)