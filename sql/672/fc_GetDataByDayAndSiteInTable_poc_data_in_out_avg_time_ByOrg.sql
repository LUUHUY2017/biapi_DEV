USE [biapi_dev]
GO
/****** Object:  UserDefinedFunction [dbo].[fc_GetDataByDayAndSiteInTable_poc_data_in_out_avg_time_ByOrg]    Script Date: 03/18/2020 16:40:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER function [dbo].[fc_GetDataByDayAndSiteInTable_poc_data_in_out_avg_time_ByOrg](@organization_id int, @sub_day int)

returns @tblVal table
(
		 site_id int
		, site_name nvarchar(50)
		, day_val date
		, visits float
		, shoppers float
)
as
begin
	insert into @tblVal
	select site_id, site_name, convert(date, d.start_time) date_val, isnull(sum(d.num_to_enter),0) visits, isnull(sum(d.num_to_enter - d.staff_traffic), 0) shoppers 
	from sites s inner join dbo.poc_data_in_out_avg_time d on s.id = d.site_id
	where s.actived = 1 and s.deleted=0 and s.organization_id = @organization_id and convert(date, d.start_time) = convert(date, dateadd(day, -1 * @sub_day, getdate()))
	group by site_id, site_name, convert(date, d.start_time)

	return
end
