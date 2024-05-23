-- Keep a log of any SQL queries you execute as you solve the mystery.


-- Find crime scene description
SELECT description
  FROM crime_scene_reports
 WHERE month = 7
   AND day = 28
   AND street = 'Humphrey Street';

-- Result:
-- +-------------------------------------------------------------------------------------+
-- |                                    description                                      |
-- +-------------------------------------------------------------------------------------+
-- | Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery.         |
-- | Interviews were conducted today with three witnesses who were present at the time – |
-- | each of their interview transcripts mentions the bakery.                            |
-- | Littering took place at 16:36. No known witnesses.                                  |
-- +-------------------------------------------------------------------------------------+


-- Find any other mentions of ducks in crime scene description
SELECT description
  FROM crime_scene_reports
 WHERE description LIKE '%duck%';

 -- Result: None other than above


 -- Find interview transcripts from the day of the theft
SELECT id, name, transcript
  FROM interviews
 WHERE year = 2023
   AND month = 7
   AND day = 28;

-- Result:
-- +------+---------+----------------------------------------------------------------------------------------------------------------------------------------------+
-- |      |         |                          transcript                                                                                                          |
-- +------+---------+----------------------------------------------------------------------------------------------------------------------------------------------+
-- | 158x | Jose    | “Ah,” said he, “I forgot that I had not seen you for some weeks.                                                                             |
-- |      |         |  It is a little souvenir from the King of Bohemia in return for my assistance in the case of the Irene Adler papers.”                        |
-- | 159x | Eugene  | “I suppose,” said Holmes, “that when Mr. Windibank came back from France he was very annoyed at your having gone to the ball.”               |
-- | 160x | Barbara | “You had my note?” he asked with a deep harsh voice and a strongly marked German accent. “I told you that I would call.”                     |
-- |      |         | He looked from one to the other of us, as if uncertain which to address.                                                                     |
-- | 161o | Ruth    | Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away.                           |
-- |      |         | If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.      |
-- | 162o | Eugene  | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery,                     |
-- |      |         | I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.                                                   |
-- | 163o | Raymond | As the thief was leaving the bakery, they called someone who talked to them for less than a minute.                                          |
-- |      |         | In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow.                           |
-- |      |         | The thief then asked the person on the other end of the phone to purchase the flight ticket.                                                 |
-- | 191? | Lily    | Our neighboring courthouse has a very annoying rooster that crows loudly at 6am every day.                                                   |
-- |      |         | My sons Robert and Patrick took the rooster to a city far, far away, so it may never bother us again.                                        |
-- |      |         | My sons have successfully arrived in Paris.                                                                                                  |
-- +------+---------+----------------------------------------------------------------------------------------------------------------------------------------------+


-- Look for cars leaving bakery parking lot within 10 minutes (10:25) of theft (theft time = 10:15am)
SELECT id, license_plate, hour, minute
  FROM bakery_security_logs
 WHERE year = 2023
   AND month = 7
   AND day = 28
   AND activity = 'exit'
   AND hour = 10
   AND minute BETWEEN 15 AND 25;

-- Result:
-- +-----+---------------+------+--------+
-- | id  | license_plate | hour | minute |
-- +-----+---------------+------+--------+
-- | 260 | 5P2BI95       | 10   | 16     |
-- | 261 | 94KL13X       | 10   | 18     |
-- | 262 | 6P58WS2       | 10   | 18     |
-- | 263 | 4328GD8       | 10   | 19     |
-- | 264 | G412CB7       | 10   | 20     |
-- | 265 | L93JTIZ       | 10   | 21     |
-- | 266 | 322W7JE       | 10   | 23     |
-- | 267 | 0NTHK55       | 10   | 23     |
-- +-----+---------------+------+--------+


-- Find names of owners of above vehicles
SELECT bakery_security_logs.id,
       people.id,
       bakery_security_logs.license_plate,
       people.license_plate,
       name,
       hour,
       minute
  FROM bakery_security_logs
  JOIN people
    ON bakery_security_logs.license_plate = people.license_plate
 WHERE year = 2023
   AND month = 7
   AND day = 28
   AND activity = 'exit'
   AND hour = 10
   AND minute BETWEEN 15 AND 25;

-- Result:
-- +-----+--------+---------------+---------------+---------+------+--------+
-- | id  |   id   | license_plate | license_plate |  name   | hour | minute |
-- +-----+--------+---------------+---------------+---------+------+--------+
-- | 260 | 221103 | 5P2BI95       | 5P2BI95       | Vanessa | 10   | 16     |
-- | 261 | 686048 | 94KL13X       | 94KL13X       | Bruce   | 10   | 18     |
-- | 262 | 243696 | 6P58WS2       | 6P58WS2       | Barry   | 10   | 18     |
-- | 263 | 467400 | 4328GD8       | 4328GD8       | Luca    | 10   | 19     |
-- | 264 | 398010 | G412CB7       | G412CB7       | Sofia   | 10   | 20     |
-- | 265 | 396669 | L93JTIZ       | L93JTIZ       | Iman    | 10   | 21     |
-- | 266 | 514354 | 322W7JE       | 322W7JE       | Diana   | 10   | 23     |
-- | 267 | 560886 | 0NTHK55       | 0NTHK55       | Kelsey  | 10   | 23     |
-- +-----+--------+---------------+---------------+---------+------+--------+

-- ***CURRENT SUSPECTS*** --
-- +---------+
-- | Vanessa |
-- | Bruce   |
-- | Barry   |
-- | Luca    |
-- | Sofia   |
-- | Iman    |
-- | Diana   |
-- | Kelsey  |
-- +---------+

-- List up Leggett Street ATM withdrawal transactions on morning of theft
SELECT id, account_number
 FROM atm_transactions
 WHERE atm_location = 'Leggett Street'
   AND year = 2023
   AND month = 7
   AND day = 28
   AND transaction_type = 'withdraw';

-- Result:
-- +-----+----------------+
-- | id  | account_number |
-- +-----+----------------+
-- | 246 | 28500762       |
-- | 264 | 28296815       |
-- | 266 | 76054385       |
-- | 267 | 49610011       |
-- | 269 | 16153065       |
-- | 288 | 25506511       |
-- | 313 | 81061156       |
-- | 336 | 26013199       |
-- +-----+----------------+

-- Find ID numbers of owners of accounts from bank account records
SELECT atm_transactions.id, bank_accounts.account_number, person_id
  FROM atm_transactions
  JOIN bank_accounts
    ON atm_transactions.account_number = bank_accounts.account_number
 WHERE atm_location = 'Leggett Street'
   AND year = 2023
   AND month = 7
   AND day = 28
   AND transaction_type = 'withdraw';

-- Result:
-- +-----+----------------+-----------+
-- | id  | account_number | person_id |
-- +-----+----------------+-----------+
-- | 246 | 28500762       | 467400    |
-- | 264 | 28296815       | 395717    |
-- | 266 | 76054385       | 449774    |
-- | 267 | 49610011       | 686048    |
-- | 269 | 16153065       | 458378    |
-- | 288 | 25506511       | 396669    |
-- | 313 | 81061156       | 438727    |
-- | 336 | 26013199       | 514354    |
-- +-----+----------------+-----------+

-- Find names of account holders from people records
SELECT atm_transactions.id, bank_accounts.account_number, person_id, name, amount
  FROM atm_transactions
  JOIN bank_accounts
    ON atm_transactions.account_number = bank_accounts.account_number
  JOIN people
    ON bank_accounts.person_id = people.id
 WHERE atm_location = 'Leggett Street'
   AND year = 2023
   AND month = 7
   AND day = 28
   AND transaction_type = 'withdraw';

-- Result:
-- +-----+----------------+-----------+---------+--------+
-- | id  | account_number | person_id |  name   | amount |
-- +-----+----------------+-----------+---------+--------+
-- | 267 | 49610011       | 686048    | Bruce   | 50     |
-- | 336 | 26013199       | 514354    | Diana   | 35     |
-- | 269 | 16153065       | 458378    | Brooke  | 80     |
-- | 264 | 28296815       | 395717    | Kenny   | 20     |
-- | 288 | 25506511       | 396669    | Iman    | 20     |
-- | 246 | 28500762       | 467400    | Luca    | 48     |
-- | 266 | 76054385       | 449774    | Taylor  | 60     |
-- | 313 | 81061156       | 438727    | Benista | 30     |
-- +-----+----------------+-----------+---------+--------+

-- Cross reference people withdrawing cash in the morning with people leaving the carpark after the theft
SELECT bakery_security_logs.id,
       people.id,
       bakery_security_logs.license_plate,
       name,
       hour,
       minute
  FROM bakery_security_logs
  JOIN people
    ON bakery_security_logs.license_plate = people.license_plate
  JOIN bank_accounts
    ON people.id = bank_accounts.person_id
  JOIN atm_transactions
    ON bank_accounts.account_number = atm_transactions.account_number
 WHERE atm_transactions.year = 2023
   AND atm_transactions.month = 7
   AND atm_transactions.day = 28
   AND activity = 'exit'
   AND hour = 10
   AND minute BETWEEN 15 AND 25
   AND transaction_type = 'withdraw'
   AND atm_location = 'Leggett Street'
   ORDER BY bakery_security_logs.id;

-- Result = ***CURRENT SUSPECTS*** --
-- +-----+--------+---------------+-------+------+--------+
-- | id  |   id   | license_plate | name  | hour | minute |
-- +-----+--------+---------------+-------+------+--------+
-- | 261 | 686048 | 94KL13X       | Bruce | 10   | 18     |
-- | 263 | 467400 | 4328GD8       | Luca  | 10   | 19     |
-- | 265 | 396669 | L93JTIZ       | Iman  | 10   | 21     |
-- | 266 | 514354 | 322W7JE       | Diana | 10   | 23     |
-- +-----+--------+---------------+-------+------+--------+

-- List up phone calls made for less than a minute (60secs) day of the theft.
SELECT id, month, day, caller, receiver, duration
  FROM phone_calls
 WHERE year = 2023
   AND month = 7
   AND day = 28
   AND duration <= 60;

-- Result:
-- +-----+-------+-----+----------------+----------------+----------+
-- | id  | month | day |     caller     |    receiver    | duration |
-- +-----+-------+-----+----------------+----------------+----------+
-- | 221 | 7     | 28  | (130) 555-0289 | (996) 555-8899 | 51       |
-- | 224 | 7     | 28  | (499) 555-9472 | (892) 555-8872 | 36       |
-- | 233 | 7     | 28  | (367) 555-5533 | (375) 555-8161 | 45       |
-- | 234 | 7     | 28  | (609) 555-5876 | (389) 555-5198 | 60       |
-- | 251 | 7     | 28  | (499) 555-9472 | (717) 555-1342 | 50       |
-- | 254 | 7     | 28  | (286) 555-6063 | (676) 555-6554 | 43       |
-- | 255 | 7     | 28  | (770) 555-1861 | (725) 555-3243 | 49       |
-- | 261 | 7     | 28  | (031) 555-6622 | (910) 555-3251 | 38       |
-- | 279 | 7     | 28  | (826) 555-1652 | (066) 555-9701 | 55       |
-- | 281 | 7     | 28  | (338) 555-6650 | (704) 555-2131 | 54       |
-- +-----+-------+-----+----------------+----------------+----------+

-- Find names of CALLERS from people register
SELECT phone_calls.id, month, day, caller, name, duration
  FROM phone_calls
  JOIN people
    ON phone_calls.caller = people.phone_number
 WHERE year = 2023
   AND month = 7
   AND day = 28
   AND duration <= 60;

-- Result:
-- +-----+-------+-----+----------------+---------+----------+
-- | id  | month | day |     caller     |  name   | duration |
-- +-----+-------+-----+----------------+---------+----------+
-- | 221 | 7     | 28  | (130) 555-0289 | Sofia   | 51       |
-- | 224 | 7     | 28  | (499) 555-9472 | Kelsey  | 36       |
-- | 233 | 7     | 28  | (367) 555-5533 | Bruce   | 45       |
-- | 234 | 7     | 28  | (609) 555-5876 | Kathryn | 60       |
-- | 251 | 7     | 28  | (499) 555-9472 | Kelsey  | 50       |
-- | 254 | 7     | 28  | (286) 555-6063 | Taylor  | 43       |
-- | 255 | 7     | 28  | (770) 555-1861 | Diana   | 49       |
-- | 261 | 7     | 28  | (031) 555-6622 | Carina  | 38       |
-- | 279 | 7     | 28  | (826) 555-1652 | Kenny   | 55       |
-- | 281 | 7     | 28  | (338) 555-6650 | Benista | 54       |
-- +-----+-------+-----+----------------+---------+----------+

-- Find names of RECEIVERS from people list
SELECT phone_calls.id, month, day, receiver, name, duration
  FROM phone_calls
  JOIN people
    ON phone_calls.receiver = people.phone_number
 WHERE year = 2023
   AND month = 7
   AND day = 28
   AND duration <= 60;

-- Result:
-- +-----+-------+-----+----------------+------------+----------+
-- | id  | month | day |    receiver    |    name    | duration |
-- +-----+-------+-----+----------------+------------+----------+
-- | 221 | 7     | 28  | (996) 555-8899 | Jack       | 51       |
-- | 224 | 7     | 28  | (892) 555-8872 | Larry      | 36       |
-- | 233 | 7     | 28  | (375) 555-8161 | Robin      | 45       |
-- | 234 | 7     | 28  | (389) 555-5198 | Luca       | 60       |
-- | 251 | 7     | 28  | (717) 555-1342 | Melissa    | 50       |
-- | 254 | 7     | 28  | (676) 555-6554 | James      | 43       |
-- | 255 | 7     | 28  | (725) 555-3243 | Philip     | 49       |
-- | 261 | 7     | 28  | (910) 555-3251 | Jacqueline | 38       |
-- | 279 | 7     | 28  | (066) 555-9701 | Doris      | 55       |
-- | 281 | 7     | 28  | (704) 555-2131 | Anna       | 54       |
-- +-----+-------+-----+----------------+------------+----------+

-- Find phone owners from both lists
SELECT phone_calls.id,
       month,
       day,
       phone_calls.caller AS caller_no,
       callers.name,
       phone_calls.receiver AS receiver_no,
       receivers.name,
       duration
  FROM phone_calls
  JOIN people callers
    ON callers.phone_number = caller_no
  JOIN people receivers
    ON receivers.phone_number = receiver_no
  WHERE year = 2023
    AND month = 7
    AND day = 28
    AND duration <= 60;

-- Result:
-- +-----+-------+-----+----------------+---------+----------------+------------+----------+
-- | id  | month | day |   caller_no    |  name   |  receiver_no   |    name    | duration |
-- +-----+-------+-----+----------------+---------+----------------+------------+----------+
-- | 221 | 7     | 28  | (130) 555-0289 | Sofia   | (996) 555-8899 | Jack       | 51       |
-- | 224 | 7     | 28  | (499) 555-9472 | Kelsey  | (892) 555-8872 | Larry      | 36       |
-- | 233 | 7     | 28  | (367) 555-5533 | Bruce   | (375) 555-8161 | Robin      | 45       |
-- | 234 | 7     | 28  | (609) 555-5876 | Kathryn | (389) 555-5198 | Luca       | 60       |
-- | 251 | 7     | 28  | (499) 555-9472 | Kelsey  | (717) 555-1342 | Melissa    | 50       |
-- | 254 | 7     | 28  | (286) 555-6063 | Taylor  | (676) 555-6554 | James      | 43       |
-- | 255 | 7     | 28  | (770) 555-1861 | Diana   | (725) 555-3243 | Philip     | 49       |
-- | 261 | 7     | 28  | (031) 555-6622 | Carina  | (910) 555-3251 | Jacqueline | 38       |
-- | 279 | 7     | 28  | (826) 555-1652 | Kenny   | (066) 555-9701 | Doris      | 55       |
-- | 281 | 7     | 28  | (338) 555-6650 | Benista | (704) 555-2131 | Anna       | 54       |
-- +-----+-------+-----+----------------+---------+----------------+------------+----------+


-- Cross reference people withdrawing cash in the morning
-- with people leaving the carpark after the theft
-- with people making < 1 minute phone call on day of the theft.
SELECT DISTINCT people.id,
       name,
       bakery_security_logs.license_plate,
       caller AS tel_no,
       passport_number,
       bank_accounts.account_number
  FROM people
  JOIN bakery_security_logs
    ON bakery_security_logs.license_plate = people.license_plate
  JOIN bank_accounts
    ON people.id = bank_accounts.person_id
  JOIN atm_transactions
    ON bank_accounts.account_number = atm_transactions.account_number
  JOIN phone_calls
    ON people.phone_number = phone_calls.caller
 WHERE phone_calls.year = 2023
   AND phone_calls.month = 7
   AND phone_calls.day = 28
   AND activity = 'exit'
   AND hour = 10
   AND minute BETWEEN 15 AND 25
   AND transaction_type = 'withdraw'
   AND atm_location = 'Leggett Street'
   AND duration <= 60;

-- Result = ***CURRENT SUSPECTS*** --
-- +--------+-------+---------------+----------------+-----------------+----------------+
-- |   id   | name  | license_plate |     tel_no     | passport_number | account_number |
-- +--------+-------+---------------+----------------+-----------------+----------------+
-- | 686048 | Bruce | 94KL13X       | (367) 555-5533 | 5773159633      | 49610011       |
-- | 514354 | Diana | 322W7JE       | (770) 555-1861 | 3592750733      | 26013199       |
-- +--------+-------+---------------+----------------+-----------------+----------------+

-- Check whether either of the suspects flew the day after the theft, and find earliest flight from Fiftyville.
SELECT flights.id AS flight_id,
       people.passport_number,
       people.name,
       flights.year,
       flights.month,
       flights.day,
       flights.hour,
       flights.minute
  FROM passengers
  JOIN people
    ON people.passport_number = passengers.passport_number
  JOIN flights
    ON passengers.flight_id = flights.id
 WHERE passengers.passport_number
    IN (SELECT passport_number
          FROM people
          JOIN bakery_security_logs
            ON bakery_security_logs.license_plate = people.license_plate
          JOIN bank_accounts
            ON people.id = bank_accounts.person_id
          JOIN atm_transactions
            ON bank_accounts.account_number = atm_transactions.account_number
          JOIN phone_calls
            ON people.phone_number = phone_calls.caller
         WHERE phone_calls.year = 2023
           AND phone_calls.month = 7
           AND phone_calls.day = 28
           AND activity = 'exit'
           AND hour = 10
           AND minute BETWEEN 15 AND 25
           AND transaction_type = 'withdraw'
           AND atm_location = 'Leggett Street'
           AND duration <= 60)
           AND flights.day = 29
           ORDER BY flights.hour
           LIMIT 1;

-- Result: *** Thief is: ***
-- +-----------+-----------------+-------+------+-------+-----+------+--------+
-- | flight_id | passport_number | name  | year | month | day | hour | minute |
-- +-----------+-----------------+-------+------+-------+-----+------+--------+
-- | 36        | 5773159633      | Bruce | 2023 | 7     | 29  | 8    | 20     |
-- +-----------+-----------------+-------+------+-------+-----+------+--------+

-- Recheck who the suspect called after the theft, using the thief's name.
SELECT phone_calls.id AS call_id,
       receivers.name AS receiver_name,
       phone_calls.receiver AS receiver_no,
       callers.name AS caller_name,
       phone_calls.caller AS caller_no,
       month,
       day,
       duration
  FROM phone_calls
  JOIN people callers
    ON callers.phone_number = caller_no
  JOIN people receivers
    ON receivers.phone_number = receiver_no
  WHERE callers.name IN (SELECT people.name
  FROM passengers
  JOIN people
    ON people.passport_number = passengers.passport_number
  JOIN flights
    ON passengers.flight_id = flights.id
 WHERE passengers.passport_number
    IN (SELECT passport_number
          FROM people
          JOIN bakery_security_logs
            ON bakery_security_logs.license_plate = people.license_plate
          JOIN bank_accounts
            ON people.id = bank_accounts.person_id
          JOIN atm_transactions
            ON bank_accounts.account_number = atm_transactions.account_number
          JOIN phone_calls
            ON people.phone_number = phone_calls.caller
         WHERE  activity = 'exit'
           AND hour = 10
           AND minute BETWEEN 15 AND 25
           AND transaction_type = 'withdraw'
           AND atm_location = 'Leggett Street')
           AND phone_calls.year = 2023
           AND phone_calls.month = 7
           AND phone_calls.day = 28
           AND duration <= 60
           AND flights.day = 29
           ORDER BY flights.hour
           LIMIT 1);

-- Result: *** Accomplice is: ***
-- +---------+---------------+----------------+-------------+----------------+-------+-----+----------+
-- | call_id | receiver_name |  receiver_no   | caller_name |   caller_no    | month | day | duration |
-- +---------+---------------+----------------+-------------+----------------+-------+-----+----------+
-- | 233     | Robin         | (375) 555-8161 | Bruce       | (367) 555-5533 | 7     | 28  | 45       |
-- +---------+---------------+----------------+-------------+----------------+-------+-----+----------+

-- Check the earliest flight from Fiftyville's destination.
SELECT flights.id AS flight_id, abbreviation, full_name, city
  FROM airports
  JOIN flights
    ON airports.id = destination_airport_id
 WHERE flights.id IN (SELECT flights.id
  FROM passengers
  JOIN people
    ON people.passport_number = passengers.passport_number
  JOIN flights
    ON passengers.flight_id = flights.id
 WHERE passengers.passport_number
    IN (SELECT passport_number
          FROM people
          JOIN bakery_security_logs
            ON bakery_security_logs.license_plate = people.license_plate
          JOIN bank_accounts
            ON people.id = bank_accounts.person_id
          JOIN atm_transactions
            ON bank_accounts.account_number = atm_transactions.account_number
          JOIN phone_calls
            ON people.phone_number = phone_calls.caller
         WHERE phone_calls.year = 2023
           AND phone_calls.month = 7
           AND phone_calls.day = 28
           AND activity = 'exit'
           AND hour = 10
           AND minute BETWEEN 15 AND 25
           AND transaction_type = 'withdraw'
           AND atm_location = 'Leggett Street'
           AND duration <= 60)
           AND flights.day = 29
           ORDER BY flights.hour
           LIMIT 1);

-- Result: *** Destination is: ***
-- +-----------+--------------+-------------------+---------------+
-- | flight_id | abbreviation |     full_name     |     city      |
-- +-----------+--------------+-------------------+---------------+
-- | 36        | LGA          | LaGuardia Airport | New York City |
-- +-----------+--------------+-------------------+---------------+

