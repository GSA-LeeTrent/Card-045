SELECT DISTINCT qms_key, notification_email_address, qms_routing_key_field_3
FROM new_hrdw.nhrdw_qms_notifications_current_v
WHERE data_item_id = 309
AND notification_email_address = 'jessica.crockwell@gsa.gov';

SELECT  v.qms_stfacq_error_id, v.qms_key, v.assigned_to_user_name,  v.assigned_to_org_name, 
		u.email_address AS 'QMS Email Address',	o.org_label AS 'QMS Organization', 
        cadw.notification_email_address AS 'CADW Email Address', cadw.qms_routing_key_field_3 AS 'CADW Organization'
FROM aca.sa_staffacquisitionlistitem v
JOIN aca.sec_user u ON u.user_id = v.assigned_to_user_id
JOIN aca.sec_org o ON o.org_id = u.orgid
JOIN new_hrdw.nhrdw_qms_notifications_current_v cadw ON cadw.qms_key = v.qms_key
WHERE v.qms_error_code IN ('MGS:VACPAR:001', 'MGS:VACPAR:002')
ORDER BY assigned_to_user_name;