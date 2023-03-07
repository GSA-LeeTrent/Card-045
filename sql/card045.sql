SELECT qms_error_code, count(qms_error_code) 
FROM new_hrdw.nhrdw_qms_notifications_current_v 
GROUP BY qms_error_code;

SELECT * FROM  new_hrdw.nhrdw_qms_notifications_current_v;


-- SELECT DISTINCT udf_field_label FROM hiring.mgs_mstr_adhoc_g_udf;

SELECT udf_field_label, udf_field_value FROM hiring.mgs_mstr_adhoc_g_udf WHERE udf_field_label = 'HR Spec Assigned Branch';