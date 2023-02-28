SELECT u.user_id, u.email_address, u.display_name, u.OrgId, o.org_id, o.org_code, o.org_label
FROM aca.sec_user u
JOIN aca.sec_org o ON o.org_id = u.orgid
WHERE user_id = 44;