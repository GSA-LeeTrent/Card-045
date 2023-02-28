SELECT	system_name
		,qms_error_code
		,qms_short_description
        ,notification_email_address
        ,qms_routing_key_field_3
FROM 	new_hrdw.nhrdw_qms_notifications_current_v
WHERE	data_item_id= 309
ORDER BY notification_email_address;


-- SELECT DISTINCT qms_error_code FROM new_hrdw.nhrdw_qms_notifications_current_v WHERE data_item_id = 309;