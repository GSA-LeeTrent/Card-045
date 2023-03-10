USE aca;
DROP FUNCTION aca.getOrgByRoutingKey;
USE aca;
DELIMITER $$
CREATE DEFINER=`HRDWCORPDATA`@`%` FUNCTION `getOrgByRoutingKey`(routingKey varchar(4)) RETURNS int(11)
BEGIN
    declare orgId int; 
    declare orgCode varchar(8);
    DECLARE CONTINUE HANDLER FOR NOT FOUND
	  BEGIN
		set orgId = -1;
	  END;    

    if routingKey = 'GS03' then 
		set orgCode = 'PBSSC';
	elseif routingKey = 'GS30' then
		set orgCode = 'FASSC';
	elseif routingKey = 'STF' OR routingKey = 'STF A' OR routingKey = 'STF B' then
		set orgCode = 'SSOSC';
    elseif routingKey = 'NRC' then
		set orgCode = 'NRC';
    elseif routingKey = 'PBS' OR routingKey = 'PBS A' OR routingKey = 'PBS B' OR routingKey = 'PBS C' then
		set orgCode = 'PBSSC';
    elseif routingKey = 'FAS' OR routingKey = 'FAS A' OR routingKey = 'FAS B' OR routingKey = 'FAS C' then
		set orgCode = 'FASSC';
	else
		set orgCode = 'GSA_OHRM';
    end if;
    
    set orgId = (select org_id from sec_org where org_code = orgCode);
    return orgId;
    
END$$
DELIMITER ;
