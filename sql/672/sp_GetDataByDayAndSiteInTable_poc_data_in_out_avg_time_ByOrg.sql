USE [biapi_dev]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetDataByDayAndSiteInTable_poc_data_in_out_avg_time_ByOrg]    Script Date: 03/18/2020 16:39:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- select * from dbo.fc_GetDataByDayAndSiteInTable_poc_data_in_out_avg_time_ByOrg(29, 1)
--select * from dbo.fc_get_site_in_role(29, 184)

ALTER proc [dbo].[sp_GetDataByDayAndSiteInTable_poc_data_in_out_avg_time_ByOrg]
@organization_id int
as
begin
	
		SELECT a.*, b.day_val day_val_pre, b.visits visits_pre, b.shoppers shoppers_pre
		, CASE WHEN b.visits = 0 THEN 0 ELSE ROUND((a.visits - b.visits)/a.visits * 100 , 2) END visits_percen
		, CASE WHEN b.shoppers = 0 THEN 0 ELSE ROUND((a.shoppers - b.shoppers)/a.shoppers * 100 , 2) END shoppers_percen
		FROM  dbo.fc_GetDataByDayAndSiteInTable_poc_data_in_out_avg_time_ByOrg(@organization_id, 1) a INNER JOIN dbo.fc_GetDataByDayAndSiteInTable_poc_data_in_out_avg_time_ByOrg(@organization_id, 2) b on a.site_id = b.site_id

end
