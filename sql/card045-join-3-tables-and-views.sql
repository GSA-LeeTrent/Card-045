SELECT 	t.assigned_to_user_id,
		u.user_id,
        u.email_address,
        v.notification_email_address,
        t.assigned_to_org_id,
        u.orgid,
        o.org_code,
        o.org_label,
        qms_routing_key_field_3,
        t.qms_stfacq_error_id,
		t.qms_key,
        v.qms_key,
		t.qms_error_code
FROM	aca.qms_stfacq_error t
JOIN 	aca.sec_user u ON u.user_id = t.assigned_to_user_id
JOIN 	aca.sec_org o ON o.org_id = u.orgid
JOIN    new_hrdw.nhrdw_qms_notifications_current_v v ON v.qms_key = t.qms_key
WHERE 	t.data_item_id = 309
AND 	t.resolved_at IS NULL;


-- ELECT 	qms_stfacq_error_id, qms_key, created_at, resolved_at, deleted_at
-- FROM	aca.qms_stfacq_error
-- WHERE 	data_item_id = 309
-- AND 	resolved_at IS NULL
-- AND qms_key NOT IN (select qms_key from new_hrdw.nhrdw_qms_notifications_current_v where data_item_id = 309);
