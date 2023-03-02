DELIMITER $$
CREATE DEFINER=`vcrawley`@`%` PROCEDURE `nhrdw_mgs_adhoc_g_onboarding_validate`(
   in p_transaction_control_id            bigint
 )
begin


  
  declare l_errmsg  TEXT;  
  declare l_hrdw_version varchar(200)  default 'HRDW Patch 80.0';
  declare l_rownotfound                int default false;
  declare l_descr                      varchar(255) default null;
  declare l_notification_message_text  text default null;
  declare l_notification_key_text      text default null;
  declare l_error_list_id              bigint default null;
  declare l_qms_key                    varchar(255) default null;
  declare l_proc                       varchar(200);

  declare l_record_id                          varchar(255) default null; 
  declare l_vacancy_announcement_number        varchar(255) default null;    
  declare l_last_name                          varchar(255) default null;  
  declare l_par_number                         varchar(255) default null; 
  declare l_routing_address                    varchar(255) default null;

  declare l_qms_routing_key_field_1            varchar(255)   default null;    
  declare l_qms_routing_key_field_2            varchar(255)   default null;    
  declare l_qms_routing_key_field_3            varchar(255)   default null;    
  declare l_qms_routing_key_field_4            varchar(255)   default null;    
  declare l_qms_routing_key_field_5            varchar(255)   default null;         
  
  
  declare c_onboard_is_null cursor for
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
     and hiring.mgs_mstr_adhoc_g_position.par_number is null;
  

  declare c_onboard_value_format cursor for
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
    
 declare continue handler for not found set l_rownotfound = true;

 declare exit handler for sqlexception, sqlwarning
 begin
    rollback;
    resignal;
 end;  

  set l_rownotfound := false;

  open c_onboard_is_null;  

  c_onboard_is_null_loop: loop 

       set l_rownotfound := false;                
	     set l_proc := 'Selection PAR Number Null Cursor';    
       
	     fetch  c_onboard_is_null into  l_record_id,
                                    l_vacancy_announcement_number,
									l_last_name,
									l_par_number,
                                    l_routing_address;
                                   
       if ( l_rownotfound = true )  
       then          
              close c_onboard_is_null;
              leave c_onboard_is_null_loop;
       end if; 
       
       
       
 /*      call nhrdw_mgs_routing_key (            
                                          l_vacancy_announcement_number  
                                         ,l_vacancy_cpdf_code 
                                         ,l_qms_routing_key_field_1         
                                         ,l_qms_routing_key_field_2         
                                         ,l_qms_routing_key_field_3         
                                         ,l_qms_routing_key_field_4         
                                         ,l_qms_routing_key_field_5         
                                  );*/
                                         
       call nhrdw_qms_notifications_api 
                                (
                                       p_transaction_control_id                                  
                                     ,'MGS'
                                     ,'Onboarding PAR Number'
                                     ,'MGS:ONBPAR:001'      
                                     ,l_routing_address
                                     ,'MGS'
                                     ,'MGS:ONBPAR:001'     
                                     ,l_record_id
                                     ,null 
                                     ,null 
                                     ,null 
                                     ,null 
                                     ,null 
                                     ,null 
                                     ,null  
                                     ,l_vacancy_announcement_number 
                                     ,l_last_name
                                     ,null
                                     ,null
                                     ,null 
                                     ,null
                                     ,null
                                     ,null
                                     ,null
                                     ,null
                                     ,'STAFFING' 
                                     ,'GS' 
                                     ,l_routing_address 
                                     ,l_qms_routing_key_field_4 
                                     ,l_qms_routing_key_field_5 
                                  );                                            
       
 
     
  end loop;        


  set l_rownotfound := false;

  open c_onboard_value_format;  

  c_onboard_value_format_loop: loop 

       set l_rownotfound := false;                
	     set l_proc := 'Selection Number Format';    
       
	     fetch  c_onboard_value_format into l_record_id,
                                        l_vacancy_announcement_number,
									    l_last_name,
									    l_par_number,
                                        l_routing_address;
                                   
       if ( l_rownotfound = true )  
       then          
              close c_onboard_value_format;
              leave c_onboard_value_format_loop;
       end if; 
       
/*       call nhrdw_mgs_routing_key (            
                                          l_vacancy_announcement_number  
                                         ,l_vacancy_cpdf_code 
                                         ,l_qms_routing_key_field_1         
                                         ,l_qms_routing_key_field_2         
                                         ,l_qms_routing_key_field_3         
                                         ,l_qms_routing_key_field_4         
                                         ,l_qms_routing_key_field_5         
                                  );*/
       
       call nhrdw_qms_notifications_api 
                                (
                                       p_transaction_control_id                                                                                                                           
                                     ,'MGS'                                                                                                                       
                                     ,'Onboarding PAR Number'                                                                                                        
                                     ,'MGS:ONBPAR:002'                                                                                                            
                                     ,l_routing_address                                                                                                        
                                     ,'MGS'                                                                                                                       
                                     ,'MGS:ONBPAR:002'                                                                                                            
                                     ,l_record_id                                                                                                                
                                     ,null                                                                                                                        
                                     ,null                                                                                                                        
                                     ,null                                                                                                                        
                                     ,null                                                                                                                        
                                     ,null                                                                                                                        
                                     ,null                                                                                                                                                                                                              
                                     ,null                                                                                                                        
                                     ,l_vacancy_announcement_number                                                                                               
                                     ,l_last_name                                                                                                        
                                     ,l_par_number                                                                                                   
                                     ,null                                                                                                  
                                     ,null                                                                                                                        
                                     ,null                                                                                                                        
                                     ,null                                                                                                                        
                                     ,null                                                                                                                        
                                     ,null                                                                                                                        
                                     ,null                                                                                                                        
                                     ,'STAFFING'                                                                                                                  
                                     ,'GS'                                                                                                                  
                                     ,l_routing_address                                                                                                                  
                                     ,l_qms_routing_key_field_4                                                                                                                  
                                     ,l_qms_routing_key_field_5                                                                               
                                  );                                            
       
 
     
  end loop;        
       
end$$
DELIMITER ;
