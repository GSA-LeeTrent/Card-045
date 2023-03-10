SELECT qms_error_code, count(qms_error_code) FROM aca.sa_staffacquisitionlistitem GROUP BY qms_error_code;

SELECT short_error_description, qms_error_code, assigned_to_user_id, assigned_to_user_name, assigned_to_org_id, assigned_to_org_name
FROM aca.sa_staffacquisitionlistitem
WHERE qms_error_code IN ('MGS:VACPAR:001', 'MGS:VACPAR:002')
ORDER BY assigned_to_user_name;

SELECT DISTINCT assigned_to_user_name, assigned_to_org_name 
FROM aca.sa_staffacquisitionlistitem
WHERE qms_error_code IN ('MGS:VACPAR:001', 'MGS:VACPAR:002')
ORDER BY assigned_to_user_name;

SELECT  v.qms_stfacq_error_id, v.qms_error_code, v.assigned_to_user_name, u.email_address, v.assigned_to_org_name, o.org_label AS 'QMS Organization'
FROM aca.sa_staffacquisitionlistitem v
JOIN aca.sec_user u ON u.user_id = v.assigned_to_user_id
JOIN aca.sec_org o ON o.org_id = u.orgid
WHERE qms_error_code IN ('MGS:VACPAR:001', 'MGS:VACPAR:002')
ORDER BY assigned_to_user_name;