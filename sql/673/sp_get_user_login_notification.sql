USE [biapi_dev]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetDataByDayAndSiteInTable_poc_data_in_out_avg_time_ByOrg]    Script Date: 03/20/2020 10:31:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_get_user_login_notification]
AS
BEGIN
	SELECT u.*, o.organization_name, o.subdomain_name
	FROM users u INNER JOIN organizations o ON u.organization_id = o.id
	LEFT JOIN (
		SELECT * FROM user_email_module WHERE report_type = 8 AND deleted = 1
	) uem ON u.id = uem.user_id
	WHERE u.actived = 1 AND u.deleted = 0 AND o.actived = 1 AND o.deleted = 0 AND uem.id IS NULL
END
