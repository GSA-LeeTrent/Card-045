 declare c_udf_value_format cursor for
  select distinct mgs_mstr_adhoc_g_vacancy.vacancy_id,
         mgs_mstr_adhoc_g_vacancy.vacancy_announcement_number, 
         mgs_mstr_adhoc_g_vacancy.vacancy_cpdf_code,
         mgs_mstr_adhoc_g_certificate.certificate_name, 
		 mgs_mstr_adhoc_g_applicant.applicant_last_name,
         mgs_mstr_adhoc_g_udf.udf_field_value,
         mgs_mstr_adhoc_g_user_management.email
  from   hiring.mgs_mstr_adhoc_g_vacancy, hiring.mgs_mstr_adhoc_g_application, hiring.mgs_mstr_adhoc_g_certificate,
         hiring.mgs_mstr_adhoc_g_udf, hiring.mgs_mstr_adhoc_g_applicant, hiring.mgs_mstr_adhoc_g_user_management
  where  hiring.mgs_mstr_adhoc_g_vacancy.vacancy_id = hiring.mgs_mstr_adhoc_g_application.fk_an_vacancy_id 
   and   hiring.mgs_mstr_adhoc_g_vacancy.vacancy_id = hiring.mgs_mstr_adhoc_g_certificate.fk_c_vacancy_id
   and   hiring.mgs_mstr_adhoc_g_application.fk_an_applicant_id = hiring.mgs_mstr_adhoc_g_applicant.applicant_id
   and   hiring.mgs_mstr_adhoc_g_vacancy.vacancy_id = hiring.mgs_mstr_adhoc_g_udf.fk_an_vacancy_id
   and   hiring.mgs_mstr_adhoc_g_user_management.user_id = hiring.mgs_mstr_adhoc_g_vacancy.vacancy_hr_manager
   and   hiring.mgs_mstr_adhoc_g_application.application_select_date >= '2021-10-01'
   and   hiring.mgs_mstr_adhoc_g_application.application_status_display IN ('Selected','Hired','Declined')
   and   hiring.mgs_mstr_adhoc_g_udf.udf_field_label = 'Selection PAR #'
   and   exists (select 'x' from hiring.mgs_mstr_adhoc_g_vacancy_request_numbers
                   where mgs_mstr_adhoc_g_vacancy_request_numbers.request_number = mgs_mstr_adhoc_g_udf.udf_field_value
                   and   mgs_mstr_adhoc_g_vacancy_request_numbers.request_number not regexp  '^[0-9]+[CU]$')
   and   hiring.mgs_mstr_adhoc_g_vacancy.vacancy_id NOT IN ( select distinct fk_an_vacancy_id From hiring.mgs_mstr_adhoc_g_udf
                                                              where mgs_mstr_adhoc_g_udf.udf_field_label = 'HR Spec Assigned Region' 
                                                                and mgs_mstr_adhoc_g_udf.udf_field_value not in ('J', 'Executive Resources'));