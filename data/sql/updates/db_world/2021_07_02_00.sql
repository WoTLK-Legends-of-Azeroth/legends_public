-- DB update 2021_07_01_01 -> 2021_07_02_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_01_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_01_01 2021_07_02_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1624549962929118300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624549962929118300');

UPDATE `quest_template_addon` SET `ExclusiveGroup` = -1074 WHERE `ID` IN (1074, 1077); -- Ineptitude + Chemicals = Fun [1074], Special Delivery for Gaxim [1077]

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_02_00' WHERE sql_rev = '1624549962929118300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
