class TimeSheetsController < ApplicationController

	def index
		@work_infos = WorkingInfo.includes(:user, :project).where("created_at::date = ?", Date.today)
	end

	def new
		@projects = Project.order(:name)
		@employees = User.order(:first_name)
	end

	def create
		work_info = params[:projects].zip(params[:employees],params[:number_of_hours],params[:description])
		if work_info.present?
			work_info.each do |info|
				work_info = WorkingInfo.create(project_id: info[0], user_id: info[1], number_of_hours: info[2], description: info[3])
			end
			redirect_to time_sheets_path
		else
			render :new
		end
	end
end
