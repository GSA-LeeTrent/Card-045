SELECT qms_error_code, count(qms_error_code) 
FROM new_hrdw.nhrdw_qms_notifications_current_v 
GROUP BY qms_error_code;

SELECT * FROM  new_hrdw.nhrdw_qms_notifications_current_v;