 declare c_cert_app_par_number_format cursor for
  select   mgs_mstr_adhoc_g_cert_application.fk_an_cert_id 
          ,mgs_mstr_adhoc_g_cert_application.fk_an_cert_sequence_number
          ,mgs_mstr_adhoc_g_cert_application.fk_an_applicant_id
          ,mgs_mstr_adhoc_g_cert_application.fk_an_vacancy_id
          ,mgs_mstr_adhoc_g_cert_application.application_grade
          ,mgs_mstr_adhoc_g_cert_application.application_status_display
          ,mgs_mstr_adhoc_g_cert_application.application_public_status
          ,mgs_mstr_adhoc_g_certificate.certificate_name
          ,mgs_mstr_adhoc_g_applicant.applicant_email
          ,mgs_mstr_adhoc_g_applicant.applicant_last_name
          ,concat(COALESCE(mgs_mstr_adhoc_g_applicant.applicant_last_name,' '), ', ', COALESCE(mgs_mstr_adhoc_g_applicant.applicant_first_name,' '))
          ,mgs_mstr_adhoc_g_certificate.staging_area_number
          ,mgs_mstr_adhoc_g_certificate.certificate_notif_recps
          ,mgs_mstr_adhoc_g_cert_application.applicant_par_number
          ,mgs_mstr_adhoc_g_vacancy.vacancy_announcement_number   
          ,mgs_mstr_adhoc_g_vacancy.vacancy_cpdf_code   
          ,mgs_mstr_adhoc_g_cert_application.application_date 
          ,mgs_mstr_adhoc_g_user_management.email 
  from    hiring.mgs_mstr_adhoc_g_cert_application
  join hiring.mgs_mstr_adhoc_g_certificate  on     mgs_mstr_adhoc_g_cert_application.fk_an_organization_id      = mgs_mstr_adhoc_g_certificate.fk_c_organization_id
                                           and     mgs_mstr_adhoc_g_cert_application.fk_an_vacancy_id           = mgs_mstr_adhoc_g_certificate.fk_c_vacancy_id
                                           and     mgs_mstr_adhoc_g_cert_application.fk_an_cert_id              = mgs_mstr_adhoc_g_certificate.certificate_id 
                                           and     mgs_mstr_adhoc_g_cert_application.fk_an_cert_sequence_number = mgs_mstr_adhoc_g_certificate.certificate_sequence_number
  join hiring.mgs_mstr_adhoc_g_applicant    on     mgs_mstr_adhoc_g_applicant.applicant_id                      = mgs_mstr_adhoc_g_cert_application.fk_an_applicant_id
  join hiring.mgs_mstr_adhoc_g_vacancy      on     mgs_mstr_adhoc_g_cert_application.fk_an_vacancy_id           = mgs_mstr_adhoc_g_vacancy.vacancy_id  
  join hiring.mgs_mstr_adhoc_g_application  on     mgs_mstr_adhoc_g_cert_application.fk_an_organization_id      = mgs_mstr_adhoc_g_application.fk_an_organization_id
                                           and     mgs_mstr_adhoc_g_cert_application.fk_an_vacancy_id           = mgs_mstr_adhoc_g_application.fk_an_vacancy_id
                                           and     mgs_mstr_adhoc_g_cert_application.application_grade          = mgs_mstr_adhoc_g_application.application_grade
                                           and     mgs_mstr_adhoc_g_cert_application.fk_an_applicant_id         = mgs_mstr_adhoc_g_application.fk_an_applicant_id
                                           and     mgs_mstr_adhoc_g_application.application_status    = 900
                                           and     mgs_mstr_adhoc_g_application.application_status_sa = 900
                                           and     mgs_mstr_adhoc_g_application.APPLICATION_SELECT_DATE >= '2021-10-01'
--  left outer join hiring.mgs_mstr_adhoc_g_users        on  mgs_mstr_adhoc_g_users.user_id = mgs_mstr_adhoc_g_vacancy.vacancy_hr_manager 
  left outer join hiring.mgs_mstr_adhoc_g_user_management        on  mgs_mstr_adhoc_g_user_management.user_id = mgs_mstr_adhoc_g_certificate.certificate_created_by
  left outer join hiring.mgs_mstr_adhoc_g_udf on  mgs_mstr_adhoc_g_udf.fk_an_vacancy_id = mgs_mstr_adhoc_g_cert_application.fk_an_vacancy_id 
  where   mgs_mstr_adhoc_g_cert_application.applicant_par_number is not null 
  and     mgs_mstr_adhoc_g_cert_application.applicant_par_number not REGEXP  '^[0-9]+[CU]$'
  and     mgs_mstr_adhoc_g_udf.udf_field_label = 'HR Spec Assigned Branch'
  and     mgs_mstr_adhoc_g_cert_application.application_status_display = 'HIRED'
  and     mgs_mstr_adhoc_g_udf.udf_field_value not in ('J', 'Executive Resources');