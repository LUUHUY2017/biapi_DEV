USE [biapi_dev]
GO
/****** Object:  UserDefinedFunction [dbo].[fc_GetDataByDayAndSiteInTable_poc_data_in_out_avg_time_ByOrg_month]    Script Date: 03/18/2020 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fc_GetDataByDayAndSiteInTable_poc_data_in_out_avg_time_ByOrg_week](@organization_id int, @week int, @year int)

returns @tblVal table
(
		 site_id int
		, site_name nvarchar(50)
		, week_val int
		, visits float
		, shoppers float
)
as
begin
	insert into @tblVal
	select site_id, site_name, DATEPART(week, convert(date, d.start_time)) week_val, isnull(sum(d.num_to_enter),0) visits, isnull(sum(d.num_to_enter - d.staff_traffic), 0) shoppers 
	from sites s inner join dbo.poc_data_in_out_avg_time d on s.id = d.site_id
	where s.actived = 1 and s.deleted = 0 and s.organization_id = @organization_id and DATEPART(week, convert(date, d.start_time)) = @week 
	and DATEPART(year, convert(date, d.start_time)) = @year
	group by site_id, site_name, DATEPART(week, convert(date, d.start_time))
	--order by site_id

	return
end


--SELECT * FROM fc_GetDataByDayAndSiteInTable_poc_data_in_out_avg_time_ByOrg_week(6,5, 2020);