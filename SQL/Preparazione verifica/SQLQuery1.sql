/*Il nome di tutte le biblioteche di Roma.*/
SELECT b.Nome
FROM Biblioteche b
WHERE b.Città = 'Roma'

/*Il titolo dei libri di G. Orwell pubblicati dopo il 1945.*/
SELECT l.Titolo
FROM Libri l
JOIN Scrive s ON l.CodLibro = s.CodLibro
JOIN Autori a ON s.CodAutore = a.CodAutore
WHERE a.Nome = 'George Orwell'
AND l.AnnoPubblicazione > 1945

/*Il titolo e l'editore dei libri di fantascienza pubblicati dopo il 2000.*/
SELECT l.Titolo, l.Editore
FROM Libri l
WHERE l.Genere = 'Fantascienza'
AND l.AnnoPubblicazione > 2000

/*Il titolo dei libri di genere fantascientifico pubblicati dopo il 2000 o di genere horror.*/
SELECT l.Titolo
FROM Libri l
WHERE (l.Genere = 'Fantascienza' AND l.AnnoPubblicazione > 2000)
OR l.Genere = 'Horror'

/*Il titolo dei libri dello stesso editore di "1984".*/
SELECT l.Titolo, l.Genere
FROM Libri l
WHERE l.Editore = (SELECT l.Editore
				  FROM Libri l
				  WHERE l.Titolo = '1984')

/*Il titolo e il genere dei libri prestati il 1 gennaio 2020.*/
SELECT l.Titolo, l.Genere
FROM Libri l
JOIN Prestiti p ON l.CodLibro = p.CodLibro
WHERE p.DataPrestito = '2020/01/01'

/*Il titolo e il genere dei libri prestati a Milano il 1 gennaio 2020.*/
SELECT l.Titolo,l.Genere
FROM Libri l
JOIN Prestiti p ON l.CodLibro = p.CodLibro
JOIN Biblioteche b ON p.CodBiblioteca = b.CodBiblioteca
WHERE p.DataPrestito = '2020/01/01'
AND b.Città = 'Milano'

/*I nomi delle biblioteche di Firenze in cui il 1 gennaio 2020 è stato prestato un libro di A. Christie.*/
SELECT b.Nome
FROM Biblioteche b
JOIN Prestiti p ON b.CodBiblioteca = p.CodBiblioteca
JOIN Scrive s ON p.CodLibro = s.CodLibro
JOIN Autori a ON s.CodAutore = a.CodAutore
WHERE b.Città = 'Firenze'
AND p.DataPrestito = '2020/01/01'
AND a.Nome = 'Agatha Christie'

/*Il titolo dei libri scritti da J.K. Rowling o G. Martin.*/
SELECT l.Titolo
FROM Libri l
JOIN Scrive s ON l.CodLibro = s.CodLibro
JOIN Autori a ON s.CodAutore = a.CodAutore
WHERE a.Nome = 'J.K. Rowling'
OR a.Nome = 'George R.R. Martin'

/*Il titolo dei libri scritti da J.K. Rowling e G. Martin.*/
SELECT l.Titolo
FROM Libri l
JOIN Scrive s ON l.CodLibro = s.CodLibro
JOIN Autori a ON s.CodAutore = a.CodAutore
WHERE a.Nome = 'J.K. Rowling'
AND a.Nome = 'George R.R. Martin'

/*Per ogni libro scritto da un autore francese, il titolo del libro e il nome dell'autore.*/
SELECT l.Titolo,a.Nome
FROM Libri l
JOIN Scrive s ON l.CodLibro = s.CodLibro
JOIN Autori a ON s.CodAutore = a.CodAutore
WHERE a.Nazionalità = 'Francese'

/*Per ogni libro prestato a Torino nel dicembre 2021, il titolo del libro e il nome della biblioteca.*/
SELECT l.Titolo,b.Nome
FROM Libri l
JOIN Prestiti p ON l.CodLibro = p.CodLibro
JOIN Biblioteche b ON p.CodBiblioteca = b.CodBiblioteca
WHERE b.Città = 'Torino'
AND p.DataPrestito BETWEEN '2021/12/01' AND '2021/12/31'

/*Il numero di biblioteche di Napoli con più di 100 posti.*/
SELECT COUNT(*) AS nBiblioteche
FROM Biblioteche b
WHERE b.Città = 'Napoli'
AND b.Posti > 100

/*Il numero totale di posti nelle biblioteche di Firenze.*/
SELECT SUM(b.Posti) AS totPosti
FROM Biblioteche b
WHERE b.Città = 'Firenze'

/*Per ogni città, il numero di biblioteche.*/
SELECT b.Città, COUNT(*) AS nBiblio
FROM Biblioteche b
GROUP BY b.Città

/*Per ogni città, il numero di biblioteche con più di 100 posti.*/
SELECT b.Città, COUNT(*) AS nBiblio
FROM Biblioteche b
WHERE b.Posti > 100
GROUP BY b.Città

/*Per ogni autore, il numero di libri scritti dopo il 2000.*/
SELECT a.Nome, COUNT(*) as nLibri
FROM Libri l
JOIN Scrive s ON l.CodLibro = s.CodLibro
JOIN Autori a ON s.CodAutore = a.CodAutore
WHERE l.AnnoPubblicazione > 2000
GROUP BY a.Nome

/*Per ogni autore, il numero totale di prestiti di tutti i suoi libri.*/
SELECT a.Nome, SUM(p.CodPrestito)
FROM Autori a
JOIN Scrive s ON a.CodAutore = s.CodAutore
JOIN Libri l ON s.CodLibro = l.CodLibro
JOIN Prestiti p ON p.CodLibro = l.CodLibro
GROUP BY a.Nome

/*Per ogni libro di S. King, il titolo, il numero totale di prestiti a Roma e la data più recente di restituzione.*/
SELECT l.Titolo, COUNT(*) AS nPrestiti, MAX(p.DataRestituzione) as dataRecente
FROM Libri l
JOIN Scrive s ON l.CodLibro = s.CodLibro
JOIN Autori a ON s.CodAutore = a.CodAutore
JOIN Prestiti p ON l.CodLibro = p.CodLibro
JOIN Biblioteche b ON p.CodBiblioteca = b.CodBiblioteca
WHERE a.Nome = 'Stephen King'
AND b.Città = 'Roma'
GROUP BY l.Titolo

/*Per ogni editore e per ogni autore, il numero di libri dell'editore scritti dall'autore.*/
SELECT l.Editore,a.Nome, COUNT(*) AS nLibri
FROM Libri l
JOIN Scrive s ON l.CodLibro = s.CodLibro
JOIN Autori a ON s.CodAutore = a.CodAutore
GROUP BY l.Editore,a.Nome

/*Il nome dell'autore e il titolo dei libri che hanno meno di 3 autori.*/
SELECT a.Nome, l.Titolo
FROM Libri l
JOIN Scrive s ON l.CodLibro = s.CodLibro
JOIN Autori a ON s.CodAutore = a.CodAutore
GROUP BY a.Nome, l.Titolo
HAVING COUNT(s.CodAutore) < 3

/*Per ogni libro pubblicato dopo il 2010, il codice, il titolo e il numero totale di prestiti.*/
SELECT l.CodLibro,l.Titolo,COUNT(p.CodPrestito) AS nPrestiti
FROM Libri l
JOIN Prestiti p ON l.CodLibro = p.CodLibro
WHERE l.AnnoPubblicazione > 2010
GROUP BY l.CodLibro,l.Titolo

/*I titoli dei libri che non sono mai stati prestati a Torino.*/
SELECT l.Titolo
FROM Libri l
JOIN Prestiti p ON l.CodLibro = p.CodLibro
JOIN Biblioteche b ON p.CodBiblioteca = b.CodBiblioteca
WHERE NOT EXISTS (SELECT *
				  FROM Biblioteche b
				  JOIN Prestiti p ON b.CodBiblioteca = p.CodBiblioteca
				  WHERE l.CodLibro = p.CodLibro
				  AND b.Città = 'Torino')

/*I titoli dei libri che sono stati prestati solo a Torino.*/
SELECT l.Titolo, b.Città
FROM Libri l
JOIN Prestiti p ON l.CodLibro = p.CodLibro
JOIN Biblioteche b ON p.CodBiblioteca = b.CodBiblioteca
WHERE NOT EXISTS (SELECT *
				  FROM Biblioteche b
				  JOIN Prestiti p ON b.CodBiblioteca = p.CodBiblioteca
				  WHERE l.CodLibro = p.CodLibro
				  AND b.Città != 'Torino')
