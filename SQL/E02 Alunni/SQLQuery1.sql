/*1.      
Tutti i dati degli alunni di FOSSANO, BRA e
MONDOVI*/

SELECT *
FROM Alunni a
WHERE a.Città = 'Bra' OR a.Città = 'Fossano' OR a.Città = 'Mondovi'

/*2.      
 Cognome e nome degli alunni alti tra 180 e 190
 in ordine decrescente di altezza e crescente cognome, nome*/

 SELECT a.Nome, a.Cognome
 FROM Alunni a
 WHERE a.Altezza BETWEEN 180 AND 190
 ORDER BY a.Altezza DESC, a.Cognome ASC, a.Nome ASC

 /*3.      
Cognome e nome degli alunni nati nel mese di
dicembre*/

SELECT a.Cognome, a.Nome
FROM Alunni a
WHERE MONTH(a.DataNascita) = 12

/*4.      
Cognome e nome degli alunni che non hanno l’ecdl*/

SELECT a.Cognome, a.Nome
FROM Alunni a
WHERE a.Ecdl = 'false'

/*5.      
Tutti i dati degli alunni senza data dinascita*/

SELECT *
FROM Alunni a
WHERE a.DataNascita IS null

/*6.      
Visualizzare gli alunni che hanno il cognome che
inizia per MA*/

SELECT *
FROM Alunni a
WHERE a.Cognome LIKE 'Ma%'

/*7.      
Per ogni mese visualizzare quanti sono gli alunni*/

SELECT MONTH(DataNascita), COUNT(*) AS nAlunni
FROM Alunni
GROUP BY MONTH(DataNascita)
Order BY MONTH(DataNascita)

/*8.      
Per ogni altezza visualizzare quanti sono gli
alunnu escludendo le altezze con un solo alunnno*/

SELECT a.Altezza, COUNT(*) AS nAlunni
FROM Alunni a
GROUP BY a.Altezza
HAVING COUNT(*) > 1
ORDER BY a.Altezza

/*9.      
Visualizzare idAlunno, cognome, nome e
‘maggiorenne’ se ha già compiuto 18 anni, ‘quasi maggiorenne’ se nell’anno in
corso compie 18 anni, ‘minorenne’ negli altri casi*/

SELECT idAlunno, Cognome, Nome, 
CASE 
    WHEN 2024 - YEAR(DataNascita) > 18 THEN 'maggiorenne'
    WHEN 2024 - YEAR(DataNascita) = 18 AND MONTH(DataNascita) <= MONTH(GETDATE()) THEN 'maggiorenne'
    WHEN 2024 - YEAR(DataNascita) = 18 THEN 'quasi maggiorenne'
    ELSE 'minorenne'
END AS Stato
FROM Alunni;
/*10.  
Visualizzare i dati dell’alunno più giovane*/

SELECT *
FROM Alunni a
WHERE a.DataNascita = (SELECT MAX(a1.DataNascita) FROM Alunni a1)