SELECT	qms_error_code,
		short_error_description,
        assigned_to_user_id,
        assigned_to_user_name,
        assigned_to_org_id,
        assigned_to_org_name
        FROM aca.sa_staffacquisitionlistitem
WHERE qms_error_code IN ('MGS:VACPAR:001','MGS:VACPAR:002')
AND resolved_at IS NULL;