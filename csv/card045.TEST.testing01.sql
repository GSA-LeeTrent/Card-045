SELECT  v.qms_stfacq_error_id, v.qms_key, v.assigned_to_user_name,  v.assigned_to_org_name, 
		u.email_address AS 'QMS Email Address',	o.org_label AS 'QMS Organization', 
        cadw.notification_email_address AS 'CADW Email Address', cadw.qms_routing_key_field_3 AS 'CADW Organization'
FROM aca.sa_staffacquisitionlistitem v
JOIN aca.sec_user u ON u.user_id = v.assigned_to_user_id
JOIN aca.sec_org o ON o.org_id = u.orgid
JOIN new_hrdw.nhrdw_qms_notifications_current_v cadw ON cadw.qms_key = v.qms_key
WHERE v.qms_error_code IN ('MGS:VACPAR:001', 'MGS:VACPAR:002')
ORDER BY assigned_to_user_name;

SELECT DISTINCT notification_email_address AS 'CADW Email Address', qms_routing_key_field_3 AS 'CADW Organization'
FROM new_hrdw.nhrdw_qms_notifications_current_v
WHERE qms_error_code IN ('MGS:VACPAR:001', 'MGS:VACPAR:002')
AND LOWER(notification_email_address) NOT IN (SELECT LOWER(email_address) FROM aca.sec_user)
ORDER BY notification_email_address;