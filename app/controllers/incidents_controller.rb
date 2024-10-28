class IncidentsController < ApplicationController
  def index
    @incidents = Incident.order(created_at: :desc)
  end

  def show
    @incident = Incident.find(params[:id])
  end

  def new
    @incident = Incident.new
  end

  def create
    @incident = Incident.new(incident_params)
    suggested_priority = LlmService.classify_priority(@incident.description)
    
    respond_to do |format|
      format.json {
        render json: { 
          suggested_priority: suggested_priority,
          incident: @incident.as_json
        }
      }
      format.html { 
        @incident.suggested_priority = suggested_priority
        if @incident.save
          redirect_to incidents_path, notice: 'Incident created successfully'
        else
          render :new, status: :unprocessable_entity
        end
      }
    end
  end

  def check_priority
    description = params[:description]
    suggested_priority = LlmService.classify_priority(description)
    render json: { priority: suggested_priority }
  end

  def save_incident
    @incident = Incident.new(incident_params)
    if @incident.save
      redirect_to incidents_path, notice: 'Incident created successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @incident = Incident.find(params[:id])
    @incident.destroy

    respond_to do |format|
      format.html { redirect_to incidents_path, notice: 'Incident was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def incident_params
    params.require(:incident).permit(
      :title, 
      :description, 
      :status, 
      :submitted_priority,
      :suggested_priority,
      :final_priority
    )
  end
end
