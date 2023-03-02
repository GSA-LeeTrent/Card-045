DELIMITER $$
CREATE DEFINER=`vcrawley`@`%` PROCEDURE `nhrdw_mgs_adhoc_g_udf_validate`(
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

  declare l_vacancy_id                         varchar(255) default null;
  declare l_vacancy_announcement_number        varchar(255) default null;   
  declare l_vacancy_cpdf_code                  varchar(255) default null;      
  declare l_certificate_name                   varchar(255) default null;    
  declare l_applicant_last_name                varchar(255) default null;  
  declare l_udf_field_value                    varchar(200) default null;
  declare l_user_email_address                 varchar(255) default null;     

  declare l_qms_routing_key_field_1            varchar(255)   default null;    
  declare l_qms_routing_key_field_2            varchar(255)   default null;    
  declare l_qms_routing_key_field_3            varchar(255)   default null;    
  declare l_qms_routing_key_field_4            varchar(255)   default null;    
  declare l_qms_routing_key_field_5            varchar(255)   default null;         
  
  
  declare c_udf_is_null cursor for
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
   and   hiring.mgs_mstr_adhoc_g_udf.udf_field_label IS NULL
   and   hiring.mgs_mstr_adhoc_g_vacancy.vacancy_id NOT IN ( select distinct fk_an_vacancy_id From hiring.mgs_mstr_adhoc_g_udf
                                                              where mgs_mstr_adhoc_g_udf.udf_field_label = 'HR Spec Assigned Region' 
                                                                and mgs_mstr_adhoc_g_udf.udf_field_value not in ('J', 'Executive Resources')); 
  

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
    
 declare continue handler for not found set l_rownotfound = true;

 declare exit handler for sqlexception, sqlwarning
 begin
    rollback;
    resignal;
 end;  

  set l_rownotfound := false;

  open c_udf_is_null;  

  c_udf_is_null_loop: loop 

       set l_rownotfound := false;                
	     set l_proc := 'Selection PAR Number Null Cursor';    
       
	     fetch  c_udf_is_null into  l_vacancy_id,
                                    l_vacancy_announcement_number,
									l_vacancy_cpdf_code,
									l_certificate_name,   
                                    l_applicant_last_name, 
									l_udf_field_value,
                                    l_user_email_address;
                                   
       if ( l_rownotfound = true )  
       then          
              close c_udf_is_null;
              leave c_udf_is_null_loop;
       end if; 
       
       
       
       call nhrdw_mgs_routing_key (            
                                          l_vacancy_announcement_number  
                                         ,l_vacancy_cpdf_code 
                                         ,l_qms_routing_key_field_1         
                                         ,l_qms_routing_key_field_2         
                                         ,l_qms_routing_key_field_3         
                                         ,l_qms_routing_key_field_4         
                                         ,l_qms_routing_key_field_5         
                                  );
                                         
       call nhrdw_qms_notifications_api 
                                (
                                       p_transaction_control_id                                  
                                     ,'MGS'
                                     ,'Selection PAR Number'
                                     ,'MGS:SELPAR:001'      
                                     ,l_user_email_address
                                     ,'MGS'
                                     ,'MGS:SELPAR:001'     
                                     ,concat(l_certificate_name,' ',l_applicant_last_name)
                                     ,null 
                                     ,null 
                                     ,null 
                                     ,null 
                                     ,null 
                                     ,null 
                                     ,null  
                                     ,l_vacancy_announcement_number 
                                     ,l_certificate_name
                                     ,null
                                     ,l_applicant_last_name
                                     ,null 
                                     ,null
                                     ,null
                                     ,null
                                     ,null
                                     ,null
                                     ,l_qms_routing_key_field_1 
                                     ,l_qms_routing_key_field_2 
                                     ,l_qms_routing_key_field_3 
                                     ,l_qms_routing_key_field_4 
                                     ,l_qms_routing_key_field_5 
                                  );                                            
       
 
     
  end loop;        


  set l_rownotfound := false;

  open c_udf_value_format;  

  c_udf_value_format_loop: loop 

       set l_rownotfound := false;                
	     set l_proc := 'Selection Number Format';    
       
	     fetch  c_udf_value_format into l_vacancy_id,
                                        l_vacancy_announcement_number,
									    l_vacancy_cpdf_code,
									    l_certificate_name,   
                                        l_applicant_last_name, 
									    l_udf_field_value,
                                        l_user_email_address;
                                   
       if ( l_rownotfound = true )  
       then          
              close c_udf_value_format;
              leave c_udf_value_format_loop;
       end if; 
       
       call nhrdw_mgs_routing_key (            
                                          l_vacancy_announcement_number  
                                         ,l_vacancy_cpdf_code 
                                         ,l_qms_routing_key_field_1         
                                         ,l_qms_routing_key_field_2         
                                         ,l_qms_routing_key_field_3         
                                         ,l_qms_routing_key_field_4         
                                         ,l_qms_routing_key_field_5         
                                  );
       
       call nhrdw_qms_notifications_api 
                                (
                                       p_transaction_control_id                                                                                                                           
                                     ,'MGS'                                                                                                                       
                                     ,'Selection PAR Number'                                                                                                        
                                     ,'MGS:SELPAR:002'                                                                                                            
                                     ,l_user_email_address                                                                                                        
                                     ,'MGS'                                                                                                                       
                                     ,'MGS:SELPAR:002'                                                                                                            
                                     ,concat(l_certificate_name,' ',l_applicant_last_name)                                                                                                                
                                     ,null                                                                                                                        
                                     ,null                                                                                                                        
                                     ,null                                                                                                                        
                                     ,null                                                                                                                        
                                     ,null                                                                                                                        
                                     ,null                                                                                                                                                                                                              
                                     ,null                                                                                                                        
                                     ,l_vacancy_announcement_number                                                                                               
                                     ,l_certificate_name                                                                                                        
                                     ,l_applicant_last_name                                                                                                   
                                     ,l_udf_field_value                                                                                                  
                                     ,null                                                                                                                        
                                     ,null                                                                                                                        
                                     ,null                                                                                                                        
                                     ,null                                                                                                                        
                                     ,null                                                                                                                        
                                     ,null                                                                                                                        
                                     ,l_qms_routing_key_field_1                                                                                                                  
                                     ,l_qms_routing_key_field_2                                                                                                                  
                                     ,l_qms_routing_key_field_3                                                                                                                  
                                     ,l_qms_routing_key_field_4                                                                                                                  
                                     ,l_qms_routing_key_field_5                                                                               
                                  );                                            
       
 
     
  end loop;        
       
end$$
DELIMITER ;
