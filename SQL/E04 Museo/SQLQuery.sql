/*1- Il codice ed il titolo delle opere di Tiziano conservate alla “National Gallery”.*/
SELECT o.Codice, o.Titolo
FROM Opere o
WHERE o.NomeA = 'Tiziano Vecellio' AND o.NomeM = 'National Gallery'

/*2- Il nome dell’artista ed il titolo delle opere conservate alla “Galleria degli Uffizi” o alla “National Gallery”.*/
SELECT o.NomeA,o.Titolo
FROM Opere o
WHERE o.NomeM = 'Galleria degli Uffizi' OR o.NomeM = 'National Gallery'

/*3- Il nome dell’artista ed il titolo delle opere conservate nei musei di Firenze*/
SELECT o.NomeA, o.Titolo
FROM Opere o
JOIN Musei m ON o.NomeM = m.NomeM
WHERE m.Città = 'Firenze'

/*4- Le città in cui son conservate opere di Caravaggio*/
SELECT DISTINCT m.Città 
FROM Musei m
JOIN Opere o ON m.NomeM = o.NomeM
WHERE o.NomeA = 'Caravaggio'

/*5- Il codice ed il titolo delle opere di Tiziano conservate nei musei di Londra*/
SELECT o.Codice, o.Titolo
FROM Opere o
JOIN Musei m ON o.NomeM = m.NomeM
WHERE o.NomeA = 'Tiziano Vecellio' AND m.Città = 'Londra'

/*6- Il nome dell’artista ed il titolo delle opere di artisti spagnoli conservate nei musei di Firenze*/
SELECT o.NomeA, o.Titolo
FROM Opere o
JOIN Musei m ON o.NomeM = m.NomeM
JOIN Artisti a ON o.NomeA = a.NomeA
WHERE a.Nazionalità = 'Spagnola' AND m.Città = 'Firenze'

/*7- Il codice ed il titolo delle opere di artisti italiani conservate nei musei di Londra, in cui è
rappresentata la Madonna*/
SELECT o.Codice, o.Titolo
FROM Opere o
JOIN Artisti a ON o.NomeA = a.NomeA
JOIN Musei m ON o.NomeM = m.NomeM
JOIN Personaggi p ON p.Codice = o.Codice
WHERE a.Nazionalità = 'Italiana' AND m.Città = 'Londra' AND p.Personaggio = 'Madonna'

/*8- Per ciascun museo di Londra, il numero di opere di artisti italiani ivi conservate*/
SELECT m.NomeM, COUNT(*) AS Opere_Italiane
FROM Musei m
JOIN Opere o ON o.NomeM = m.NomeM
JOIN Artisti a ON o.NomeA = a.NomeA
WHERE m.Città = 'Londra' AND a.Nazionalità = 'Italiana'
GROUP BY m.NomeM

/*9- Il nome dei musei di Londra che non conservano opere di Tiziano*/
SELECT m.NomeM
FROM Musei m
JOIN Opere o ON m.NomeM = o.NomeM
WHERE NOT EXISTS (SELECT *
				  FROM Opere o
				  WHERE o.NomeM = m.NomeM
				  AND o.NomeA = 'Tiziano Vecellio')
AND m.Città = 'Londra'

/*10- Il nome dei musei di Londra che conservano solo opere di Tiziano*/
SELECT DISTINCT m.NomeM
FROM Musei m
JOIN Opere o ON m.NomeM = o.NomeM
WHERE NOT EXISTS (SELECT *
				  FROM Opere o
				  WHERE o.NomeM = m.NomeM
				  AND o.NomeA != 'Tiziano Vecellio')
AND m.Città = 'Londra'

/*11- Per ciascun artista, il nome dell’artista ed il numero di sue opere conservate alla “Galleria
degli Uffizi”*/
SELECT a.NomeA, COUNT(*) AS nOpere
FROM Artisti a
JOIN Opere o ON o.NomeA = a.NomeA
JOIN Musei m ON o.NomeM = m.NomeM
WHERE m.NomeM = 'Galleria degli Uffizi'
GROUP BY a.NomeA

/*12- I musei che conservano almeno 20 opere di artisti italiani*/
SELECT m.NomeM
FROM Musei m
JOIN Opere o ON m.NomeM = o.NomeM
JOIN Artisti a ON o.NomeA = a.NomeA
WHERE a.Nazionalità = 'Italiana'
GROUP BY m.NomeM
HAVING COUNT(*) > 20

/*13- Per le opere di artisti italiani che non hanno personaggi, il titolo dell’opera ed il nome
dell’artista*/
SELECT o.Titolo, o.NomeA
FROM Opere o
JOIN Artisti a ON a.NomeA = o.NomeA
WHERE NOT EXISTS (SELECT *
				  FROM Personaggi p
				  WHERE p.Codice = o.Codice)
AND a.Nazionalità = 'Italiana'

/*14- Il nome dei musei di Londra che non conservano opere di artisti italiani, eccettuato Tiziano*/
SELECT DISTINCT m.NomeM
FROM Musei m
JOIN Opere o ON m.NomeM = o.NomeM
JOIN Artisti a ON o.NomeA = a.NomeA
WHERE NOT EXISTS (SELECT *
				  FROM Artisti a
				  JOIN Opere o ON a.NomeA = o.NomeA
				  WHERE o.NomeM = m.NomeM
				  AND a.Nazionalità = 'Italiana'
				  AND a.NomeA != 'Tiziano Vecellio')
AND m.Città = 'Londra'

/*15- Per ogni museo, il numero di opere divise per la nazionalità dell’artista*/
SELECT m.NomeM, a.Nazionalità, COUNT(*) AS nOpere
FROM Musei m
JOIN Opere o ON m.NomeM = o.NomeM
JOIN Artisti a ON o.NomeA = a.NomeA
GROUP BY m.NomeM, a.Nazionalità
ORDER BY m.NomeM, a.Nazionalità
