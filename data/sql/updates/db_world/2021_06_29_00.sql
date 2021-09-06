-- DB update 2021_06_28_00 -> 2021_06_29_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_28_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_28_00 2021_06_29_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1621508254911888350'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621508254911888350');

DELETE FROM `creature_loot_template` WHERE `Entry` = 205 AND `Reference` = 24042;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_29_00' WHERE sql_rev = '1621508254911888350';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
