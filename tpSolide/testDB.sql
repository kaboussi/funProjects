PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "students" (
	"student_id"	INTEGER NOT NULL,
	"first_name"	TEXT NOT NULL,
	"last_name"	TEXT NOT NULL,
	"email"	TEXT NOT NULL,
	"apogee"	INTEGER NOT NULL, chosen_group INT,
	PRIMARY KEY("student_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "groups" (
	"group_number"	INTEGER NOT NULL,
	"capacity"	INTEGER NOT NULL, current_capacity INT,
	PRIMARY KEY("group_number")
);
INSERT INTO "groups" VALUES(1,14,0);
INSERT INTO "groups" VALUES(2,15,0);
INSERT INTO "groups" VALUES(3,12,0);
INSERT INTO "groups" VALUES(4,9,0);
INSERT INTO "groups" VALUES(5,13,0);
INSERT INTO "groups" VALUES(6,12,0);
INSERT INTO "groups" VALUES(7,14,0);
INSERT INTO "groups" VALUES(8,10,0);
INSERT INTO "groups" VALUES(9,13,0);
INSERT INTO "groups" VALUES(10,10,0);
INSERT INTO "groups" VALUES(11,14,0);
INSERT INTO "groups" VALUES(12,14,0);
DELETE FROM sqlite_sequence;
CREATE INDEX "idx_first_last_name" ON "students" (
	"first_name",
	"last_name"
);
CREATE VIEW students_and_groups as
SELECT (
    s.student_id,
	s.da
)
FROM students s
JOIN groups g WHERE g.group_number = s.chosen_group
GROUP BY (g.group_number, s.student_id);
CREATE TRIGGER student_after_added
	AFTER INSERT on students
	FOR EACH ROW
BEGIN
	UPDATE groups
	SET current_capacity = current_capacity + 1
	WHERE chosen_group = group_number;
END;
COMMIT;
