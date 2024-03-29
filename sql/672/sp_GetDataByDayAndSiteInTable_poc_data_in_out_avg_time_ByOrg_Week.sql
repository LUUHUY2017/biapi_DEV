USE [biapi_dev]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetDataByDayAndSiteInTable_poc_data_in_out_avg_time_ByOrg_Month]    Script Date: 03/18/2020 13:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- select * from dbo.fc_GetDataByDayAndSiteInTable_poc_data_in_out_avg_time_ByOrg(29, 1)
--select * from dbo.fc_get_site_in_role(29, 184)

CREATE PROCEDURE [dbo].[sp_GetDataByDayAndSiteInTable_poc_data_in_out_avg_time_ByOrg_Week]
@organization_id int
as
begin
	DECLARE @week INT = (SELECT DATEPART(week, convert(date, getdate())));
	DECLARE @year INT = (SELECT DATEPART(year, convert(date, getdate())));
	SELECT a.*, b.week_val day_val_pre, b.visits visits_pre, b.shoppers shoppers_pre
	, CASE WHEN b.visits = 0 THEN 0 ELSE ROUND((a.visits - b.visits)/a.visits * 100 , 2) END visits_percen
	, CASE WHEN b.shoppers = 0 THEN 0 ELSE ROUND((a.shoppers - b.shoppers)/a.shoppers * 100 , 2) END shoppers_percen
	FROM dbo.fc_GetDataByDayAndSiteInTable_poc_data_in_out_avg_time_ByOrg_week(@organization_id, @week - 1, @year) a INNER JOIN dbo.fc_GetDataByDayAndSiteInTable_poc_data_in_out_avg_time_ByOrg_week(@organization_id, @week - 2, @year) b on a.site_id = b.site_id

end
