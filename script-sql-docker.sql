-- ===== ORIGINESURDITE =====
CREATE TABLE ORIGINESURDITE (
                                id INT NOT NULL AUTO_INCREMENT,
                                natureSurdite VARCHAR(255) NOT NULL,
                                PRIMARY KEY (id)
) ENGINE=InnoDB;

INSERT INTO ORIGINESURDITE (id, natureSurdite) VALUES
                                                   (1,'Congénitale'),
                                                   (2,'Acquise'),
                                                   (3,'Héréditaire');


-- ===== HANDICAPASSOCIE =====
CREATE TABLE HANDICAPASSOCIE (
                                 id INT NOT NULL AUTO_INCREMENT,
                                 nomHandicap VARCHAR(255) NOT NULL,
                                 PRIMARY KEY (id)
) ENGINE=InnoDB;

INSERT INTO HANDICAPASSOCIE (id, nomHandicap) VALUES
                                                  (1,'Cécité'),
                                                  (2,'Mobilité réduite'),
                                                  (3,'Trouble cognitif');


-- ===== PROFESSIONNEL =====
CREATE TABLE PROFESSIONNEL (
                               id INT NOT NULL AUTO_INCREMENT,
                               libellePro VARCHAR(255) NOT NULL,
                               PRIMARY KEY (id)
) ENGINE=InnoDB;

INSERT INTO PROFESSIONNEL (id, libellePro) VALUES
                                               (1,'Audioprothésiste'),
                                               (2,'Orthophoniste'),
                                               (3,'Pédiatre');


-- ===== CSPPARENT =====
CREATE TABLE CSPPARENT (
                           id INT NOT NULL AUTO_INCREMENT,
                           libelleCsp VARCHAR(255) NOT NULL,
                           PRIMARY KEY (id)
) ENGINE=InnoDB;

INSERT INTO CSPPARENT (id, libelleCsp) VALUES
                                           (1,'Cadre'),
                                           (2,'Ouvrier'),
                                           (3,'Profession libérale');


-- ===== PARENT =====
CREATE TABLE PARENT (
                        id INT NOT NULL AUTO_INCREMENT,
                        nom VARCHAR(255) NOT NULL,
                        prenom VARCHAR(255) NOT NULL,
                        dateNaissance DATE NULL,
                        idCsp INT NULL,
                        PRIMARY KEY (id),
                        FOREIGN KEY (idCsp) REFERENCES CSPPARENT(id)
                            ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

INSERT INTO PARENT (id, nom, prenom, dateNaissance, idCsp) VALUES
                                                               (1,'Dupont','Jean','1980-11-22',1),
                                                               (2,'Martin','Sophie','1982-04-10',2),
                                                               (3,'Bernard','Paul','1979-08-05',3);


-- ===== patients =====
CREATE TABLE patients (
                          id INT NOT NULL AUTO_INCREMENT,
                          name VARCHAR(255) NOT NULL,
                          prenom VARCHAR(255) NOT NULL,
                          date_of_birth DATE NULL,
                          ageDespistageSurdite INT NULL,
                          agePremierImplant INT NULL,
                          ageDeuxiemeImplant INT NULL,
                          idOrigineSurdite INT NULL,
                          idPro INT NULL,
                          created_at DATETIME NULL,
                          updated_at DATETIME NULL,
                          PRIMARY KEY (id),
                          FOREIGN KEY (idOrigineSurdite) REFERENCES ORIGINESURDITE(id)
                              ON UPDATE CASCADE ON DELETE SET NULL,
                          FOREIGN KEY (idPro) REFERENCES PROFESSIONNEL(id)
                              ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

INSERT INTO patients (id, name, prenom, date_of_birth, ageDespistageSurdite, agePremierImplant, ageDeuxiemeImplant, idOrigineSurdite, idPro, created_at, updated_at) VALUES
                                                                                                                                                                         (1,'Dupont','Marie','2015-06-15',2,3,5,1,2,NULL,NULL),
                                                                                                                                                                         (2,'Martin','Lucas','2014-03-22',1,2,NULL,2,1,NULL,NULL),
                                                                                                                                                                         (3,'Bernard','Clara','2016-12-05',3,4,6,3,3,NULL,NULL),
                                                                                                                                                                         (4,'MBAPPE','Kylian','1998-12-20',NULL,NULL,NULL,NULL,NULL,'2024-10-11 19:12:48','2024-10-11 19:12:48'),
                                                                                                                                                                         (5,'Mayombo','Riri','2024-10-02',NULL,NULL,NULL,NULL,NULL,'2024-10-16 12:04:05','2024-10-16 12:04:05'),
                                                                                                                                                                         (6,'MBAPPE','Kilian','2024-10-01',NULL,NULL,NULL,NULL,NULL,'2024-10-16 12:22:35','2024-10-16 12:22:35');


-- ===== ETREPARENT =====
CREATE TABLE ETREPARENT (
                            idParent INT NOT NULL,
                            idPatient INT NOT NULL,
                            PRIMARY KEY (idParent, idPatient),
                            FOREIGN KEY (idParent) REFERENCES PARENT(id)
                                ON UPDATE CASCADE ON DELETE CASCADE,
                            FOREIGN KEY (idPatient) REFERENCES patients(id)
                                ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO ETREPARENT (idParent, idPatient) VALUES
                                                 (1,1),
                                                 (2,2),
                                                 (3,3);


-- ===== HANDICAPER =====
CREATE TABLE HANDICAPER (
                            idPatient INT NOT NULL,
                            idHandicap INT NOT NULL,
                            PRIMARY KEY (idPatient, idHandicap),
                            FOREIGN KEY (idPatient) REFERENCES patients(id)
                                ON UPDATE CASCADE ON DELETE CASCADE,
                            FOREIGN KEY (idHandicap) REFERENCES HANDICAPASSOCIE(id)
                                ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO HANDICAPER (idPatient, idHandicap) VALUES
                                                   (1,1),
                                                   (2,2),
                                                   (3,3);


-- ===== ENQUETE =====
CREATE TABLE ENQUETE (
                         idPatient INT NOT NULL,
                         annee INT NOT NULL,
                         niveauComprehension INT NULL,
                         niveauExpression INT NULL,
                         indicateurScolarite VARCHAR(255) NULL,
                         nbHeuresHebdoOrthophonie INT NULL,
                         PRIMARY KEY (idPatient, annee),
                         FOREIGN KEY (idPatient) REFERENCES patients(id)
                             ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO ENQUETE (idPatient, annee, niveauComprehension, niveauExpression, indicateurScolarite, nbHeuresHebdoOrthophonie) VALUES
                                                                                                                                 (1,2022,5,4,'Primaire',2),
                                                                                                                                 (2,2023,4,5,'Primaire',3),
                                                                                                                                 (3,2023,5,5,'Collège',4);


-- ===== incidents =====
CREATE TABLE incidents (
                           id INT NOT NULL AUTO_INCREMENT,
                           patient_id INT NOT NULL,
                           incident_type VARCHAR(255) NULL,
                           description TEXT NOT NULL,
                           created_at DATETIME NULL,
                           updated_at DATETIME NULL,
                           severity INT NULL,
                           date DATE NULL,
                           PRIMARY KEY (id),
                           FOREIGN KEY (patient_id) REFERENCES patients(id)
                               ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO incidents (id, patient_id, incident_type, description, created_at, updated_at, severity, date) VALUES
                                                                                                               (1,2,NULL,'mal au dos','2024-10-15 15:15:33','2024-10-15 15:15:33',1,'2024-10-11'),
                                                                                                               (2,2,NULL,'Tousse depuis plusieurs et a du mal a respirer','2024-10-15 15:17:07','2024-10-15 15:17:07',1,'2024-10-01'),
                                                                                                               (3,4,NULL,'Mal au pied','2024-10-15 15:17:46','2024-10-15 15:17:46',2,'2024-07-18');
