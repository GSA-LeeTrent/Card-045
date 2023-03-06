=======================================================================================================================
  select  mgs_mstr_adhoc_g_cert_application.applicant_par_number
  from    hiring.mgs_mstr_adhoc_g_cert_application
  join 		hiring.mgs_mstr_adhoc_g_applicant on mgs_mstr_adhoc_g_applicant.applicant_id = mgs_mstr_adhoc_g_cert_application.fk_an_applicant_id
  join hiring.mgs_mstr_adhoc_g_application  on     mgs_mstr_adhoc_g_cert_application.fk_an_organization_id      = mgs_mstr_adhoc_g_application.fk_an_organization_id
                                           and     mgs_mstr_adhoc_g_cert_application.fk_an_vacancy_id           = mgs_mstr_adhoc_g_application.fk_an_vacancy_id
                                           and     mgs_mstr_adhoc_g_cert_application.application_grade          = mgs_mstr_adhoc_g_application.application_grade
                                           and     mgs_mstr_adhoc_g_cert_application.fk_an_applicant_id         = mgs_mstr_adhoc_g_application.fk_an_applicant_id
                                           and     mgs_mstr_adhoc_g_application.application_status    = 900
                                           and     mgs_mstr_adhoc_g_application.application_status_sa = 900
                                           and     mgs_mstr_adhoc_g_application.APPLICATION_SELECT_DATE >= '2021-10-01'
  and   	mgs_mstr_adhoc_g_cert_application.applicant_par_number is not null 
  and     mgs_mstr_adhoc_g_cert_application.applicant_par_number not REGEXP  '^[0-9]+[CU]$';
=======================================================================================================================
select	mgs_mstr_adhoc_g_cert_application.applicant_par_number
from    hiring.mgs_mstr_adhoc_g_cert_application
join 	hiring.mgs_mstr_adhoc_g_applicant on mgs_mstr_adhoc_g_applicant.applicant_id = mgs_mstr_adhoc_g_cert_application.fk_an_applicant_id
join 	hiring.mgs_mstr_adhoc_g_application on mgs_mstr_adhoc_g_cert_application.fk_an_organization_id      = mgs_mstr_adhoc_g_application.fk_an_organization_id
and     mgs_mstr_adhoc_g_cert_application.fk_an_vacancy_id = mgs_mstr_adhoc_g_application.fk_an_vacancy_id
and     mgs_mstr_adhoc_g_cert_application.application_grade = mgs_mstr_adhoc_g_application.application_grade
and     mgs_mstr_adhoc_g_cert_application.fk_an_applicant_id = mgs_mstr_adhoc_g_application.fk_an_applicant_id
and     mgs_mstr_adhoc_g_application.application_status    = 900
and     mgs_mstr_adhoc_g_application.application_status_sa = 900
and     mgs_mstr_adhoc_g_application.APPLICATION_SELECT_DATE >= '2021-10-01'
and   	mgs_mstr_adhoc_g_cert_application.applicant_par_number is not null 
and     mgs_mstr_adhoc_g_cert_application.applicant_par_number not regexp  '^[0-9]+[CU]$'
and  mgs_mstr_adhoc_g_cert_application.applicant_par_number not regexp  '^[0-9]+[CU], [0-9]+[CU]$'
and  mgs_mstr_adhoc_g_cert_application.applicant_par_number not regexp  '^[0-9]+[CU], [0-9]+[CU], [0-9]+[CU]$'
and  mgs_mstr_adhoc_g_cert_application.applicant_par_number not regexp  '^[0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU]$'
and  mgs_mstr_adhoc_g_cert_application.applicant_par_number not regexp  '^[0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU]$'
and  mgs_mstr_adhoc_g_cert_application.applicant_par_number not regexp  '^[0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU]$'
and  mgs_mstr_adhoc_g_cert_application.applicant_par_number not regexp  '^[0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU]$'
and  mgs_mstr_adhoc_g_cert_application.applicant_par_number not regexp  '^[0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU]$'
and  mgs_mstr_adhoc_g_cert_application.applicant_par_number not regexp  '^[0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU]$'
and  mgs_mstr_adhoc_g_cert_application.applicant_par_number not regexp  '^[0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU]$'  
and  mgs_mstr_adhoc_g_cert_application.applicant_par_number not regexp  '^[0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU], [0-9]+[CU]$';
  
  