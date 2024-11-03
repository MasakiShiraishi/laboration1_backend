USE BookStore;
SELECT CURRENT_USER();

# utvecklarkonto
CREATE USER 'developer'@'%' IDENTIFIED BY 'deve123';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER ON BookStore.* TO 'developer'@'%';

CREATE TABLE t (
    item VARCHAR(10)
);
DROP TABLE t;

# Webserverkonto
CREATE USER 'webserver'@'%' IDENTIFIED BY 'web123';
GRANT SELECT, INSERT, UPDATE, DELETE ON BookStore.* TO 'webserver'@'%';

SELECT * FROM BookStore.author;
INSERT INTO author (author_id, first_name, last_name, birth_date) VALUES
          (4, 'Test', 'from webserver', '1966-03-04');
DELETE FROM author WHERE author_id = 4;
