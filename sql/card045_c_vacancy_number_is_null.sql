  select   mgs_mstr_adhoc_g_vacancy.vacancy_id
          ,mgs_mstr_adhoc_g_vacancy.vacancy_announcement_number
          ,mgs_mstr_adhoc_g_vacancy.vacancy_cpdf_code
          ,mgs_mstr_adhoc_g_vacancy.vacancy_hr_manager_name 
          ,mgs_mstr_adhoc_g_vacancy.vacancy_open_date
          ,mgs_mstr_adhoc_g_vacancy.vacancy_request_official
          ,mgs_mstr_adhoc_g_vacancy.vacancy_request_no
          ,mgs_mstr_adhoc_g_user_management.email
  from    hiring.mgs_mstr_adhoc_g_vacancy  
  left outer join hiring.mgs_mstr_adhoc_g_department      on  mgs_mstr_adhoc_g_vacancy.fk_v_department_id = mgs_mstr_adhoc_g_department.department_id
  left outer join hiring.mgs_mstr_adhoc_g_user_management  on  mgs_mstr_adhoc_g_user_management.user_id = mgs_mstr_adhoc_g_vacancy.vacancy_hr_manager
  left outer join hiring.mgs_mstr_adhoc_g_udf             on  mgs_mstr_adhoc_g_udf.fk_an_vacancy_id = mgs_mstr_adhoc_g_vacancy.vacancy_id
  where   mgs_mstr_adhoc_g_vacancy.vacancy_created_date >= '2021-10-01' 
  and     mgs_mstr_adhoc_g_vacancy.vacancy_request_no is null
  and     mgs_mstr_adhoc_g_udf.udf_field_label = 'HR Spec Assigned Branch'
  and     mgs_mstr_adhoc_g_udf.udf_field_value not in ('J', 'Executive Resources')
  and mgs_mstr_adhoc_g_user_management.email = 'jessica.crockwell@gsa.gov';