  -- declare c_onboard_value_format cursor for
    select mgs_mstr_adhoc_g_position.record_id,
	       mgs_mstr_adhoc_g_position.vacancy_number,  
           mgs_mstr_adhoc_g_new_hire.last_name, 
		   mgs_mstr_adhoc_g_position.par_number,
           ifnull(mgs_mstr_adhoc_g_position.ao_email, mgs_mstr_adhoc_g_position.hr_staff_email)
      from hiring.mgs_mstr_onboarding_gs, hiring.mgs_mstr_adhoc_g_new_hire, hiring.mgs_mstr_adhoc_g_position,
	       hiring.mgs_mstr_adhoc_g_user_management
     where hiring.mgs_mstr_onboarding_gs.record_id = hiring.mgs_mstr_adhoc_g_new_hire.record_id
       and hiring.mgs_mstr_adhoc_g_new_hire.record_id = hiring.mgs_mstr_adhoc_g_position.record_id  
	   and hiring.mgs_mstr_adhoc_g_position.hr_staff_username = hiring.mgs_mstr_adhoc_g_user_management.user_id
       and hiring.mgs_mstr_onboarding_gs.assign_onboarding_team_dt >=  '2021-10-01'
       and exists (select 'x' from hiring.mgs_mstr_adhoc_g_vacancy_request_numbers
                   where mgs_mstr_adhoc_g_vacancy_request_numbers.request_number = mgs_mstr_adhoc_g_position.par_number
                   and   mgs_mstr_adhoc_g_vacancy_request_numbers.request_number not regexp  '^[0-9]+[CU]$');
				   
				   
-- NO ROWS RETURNED IN DEV			  

-- 16 ROWS RETURN IN TEST 



    select  mgs_mstr_adhoc_g_position.par_number
      from  hiring.mgs_mstr_adhoc_g_positiont
	 where  mgs_mstr_adhoc_g_position.par_number not regexp  '^[0-9]+[CU]$';