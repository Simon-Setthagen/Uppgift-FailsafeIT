# FailSafe IT - Inlämningsuppgift 1

## Beskrivning

Detta projekt innehåller en relationsdatabas för konsultföretaget FailSafe IT. Databasen används för att hantera klienter, konsulter och uppdrag mellan dessa.

Databasen är skapad i Microsoft SQL Server och består av tre tabeller:

- Clients
- Consultants
- Assignments

Datamodellen är utformad enligt tredje normalformen (3NF) och innehåller primärnycklar samt främmande nycklar för att säkerställa referensintegritet.

---

# ER-diagram

ER-diagrammet visar relationerna mellan tabellerna Clients, Consultants och Assignments.

- En klient kan ha flera uppdrag.
- En konsult kan ha flera uppdrag.
- Varje uppdrag är kopplat till exakt en klient och en konsult.

---

# Normalisering

Databasen är normaliserad till tredje normalformen (3NF).

### Första normalformen (1NF)

Alla kolumner innehåller endast atomära värden och det finns inga upprepande grupper eller listor i tabellerna. Varje rad representerar en unik post.

### Andra normalformen (2NF)

Alla icke-nyckelattribut är fullt funktionellt beroende av respektive tabells primärnyckel. Exempelvis lagras klientinformation endast i tabellen Clients och konsultinformation endast i tabellen Consultants.

### Tredje normalformen (3NF)

Det finns inga transitiva beroenden mellan de icke-nyckelattribut som förekommer i databasen. Informationen är uppdelad i separata tabeller för att undvika redundans och förenkla underhåll.

---

# SQL-funktionalitet

SQL-skriptet innehåller:

- Skapande av tabeller (DDL)
- Infogning av testdata (DML)
- Fråga A: Filtrering och sortering av konsulter baserat på timpris
- Fråga B: Sammanställning av uppdrag med hjälp av JOIN
- Fråga C: Antal uppdrag per klient med COUNT och GROUP BY
- Fråga D: Uppdatering av konsults timpris
- Fråga E: Borttagning av klient utan uppdrag

Skriptet är idempotent och kan köras flera gånger eftersom tabellerna tas bort och skapas på nytt vid varje körning.

---

# DevSecOps-reflektion

## Sec

För att skydda databasen mot SQL Injection bör parametriserade SQL-frågor användas. Detta innebär att användarens inmatning behandlas som data istället för körbar SQL-kod, vilket minskar risken för att en angripare kan manipulera databasen.

## Ops

Om databasen växer till ett stort antal klienter och uppdrag bör index användas på kolumner som ofta används vid sökningar, exempelvis OrganizationNumber. Index förbättrar prestandan genom att databasen kan hitta information snabbare utan att behöva läsa igenom hela tabellen.

---

# Filer i projektet

Projektet innehåller följande filer:

- README.md
- Database.sql
- ER-diagram (PDF eller bild)
