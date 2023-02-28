SELECT COUNT(*) FROM aca.qms_stfacq_error WHERE data_item_id = 309 AND resolved_at is NULL;
-- 424
SELECT COUNT(*) FROM new_hrdw.nhrdw_qms_notifications_current_v WHERE data_item_id = 309;
-- 424
SELECT COUNT(*) FROM aca.sa_staffacquisitionlistitem WHERE qms_error_code IN ('MGS:VACPAR:001','MGS:VACPAR:002') AND resolved_at IS NULL;
-- 424


        
        