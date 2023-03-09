SELECT q.data_item_id, n.DATA_ITEM_ID, q.error_list_id, n.error_list_id, q.qms_error_code, n.QMS_ERROR_CODE
FROM aca.qms_master_error_list q
JOIN new_hrdw.nhrdw_qms_master_error_list n ON n.ERROR_LIST_ID = q.error_list_id
WHERE q.error_list_id > 271;