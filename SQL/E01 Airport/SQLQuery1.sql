/*- Trovare le città da cui partono voli diretti a Roma, ordinate alfabeticamente- */
SELECT DepartureCity
FROM Flights
WHERE ArrivalCity = 'Rome'
ORDER BY DepartureCity ASC

/*- Trovare le città con un aeroporto di cui non è noto il numero di piste*/
SELECT City
FROM Airports
WHERE TrackCount IS null

/* - Di ogni volo misto (merci e passeggeri) estrarre il codice e i dati relativi al trasporto */
SELECT *
FROM Flights
JOIN Airplanes ON Flights.AirplaneType = Airplanes.AirplaneType
WHERE Airplanes.CargoQuantity IS NOT NULL AND Airplanes.PassengersCount IS NOT NULL