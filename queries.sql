# --Uppgift 1
# CREATE TABLE successful_mission AS
# SELECT *
# FROM moon_mission
# WHERE outcome = 'Successful';
# --Uppgift 2
# ALTER TABLE successful_mission
#     ADD PRIMARY KEY (mission_id);
# --Uppgift 3
# ALTER TABLE successful_mission
#     RENAME TO `successful mission`;
# ALTER TABLE moon_mission
#     RENAME TO `moon mission`;
# --Uppgift 4
# DELETE FROM `successful mission`
# WHERE launch_date >= '2010-01-01';
# --Uppgift 5
# ALTER TABLE account
#     ADD gender varchar(255);
# UPDATE account
# SET gender = CASE
#     WHEN SUBSTRING(ssn, LENGTH(ssn)-1, 1) % 2 = 0
#     THEN 'female'
#     ELSE 'male'
#     END
# WHERE ssn IS NOT NULL;
# UPDATE account
# SET name = CONCAT(first_name, ' ', last_name)
# WHERE first_name IS NOT NULL AND last_name IS NOT NULL;
# ALTER TABLE account
#     DROP COLUMN first_name,
#     DROP COLUMN last_name;
# SELECT * FROM account;
# --Uppgift 6
# DELETE FROM account
# WHERE gender = 'female'
#   AND CAST(CONCAT('19', SUBSTRING(ssn, 1, 2), '-', SUBSTRING(ssn, 3, 2), '-', SUBSTRING(ssn, 5, 2)) AS DATE) < '1970-01-01';

# --Uppgift 7
# SELECT gender,
#        AVG(YEAR(CURDATE()) -
#            CASE
#                WHEN SUBSTRING(ssn, 1, 2) <= SUBSTRING(YEAR(CURDATE()), 3, 2)
#                    THEN CONCAT('20', SUBSTRING(ssn, 1, 2))
#                ELSE CONCAT('19', SUBSTRING(ssn, 1, 2))
#                END) AS average_age
# FROM account
# GROUP BY gender;
