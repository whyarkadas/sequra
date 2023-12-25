class ScheduledTasksController < ApplicationController
  before_action :set_scheduled_task, only: %i[ show update destroy ]

  # GET /scheduled_tasks
  def index
    @scheduled_tasks = ScheduledTask.all

    render json: @scheduled_tasks
  end

  # GET /scheduled_tasks/1
  def show
    render json: @scheduled_task
  end

  # POST /scheduled_tasks
  def create
    @scheduled_task = ScheduledTask.new(scheduled_task_params)

    if @scheduled_task.save
      render json: @scheduled_task, status: :created, location: @scheduled_task
    else
      render json: @scheduled_task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /scheduled_tasks/1
  def update
    if @scheduled_task.update(scheduled_task_params)
      render json: @scheduled_task
    else
      render json: @scheduled_task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /scheduled_tasks/1
  def destroy
    @scheduled_task.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scheduled_task
      @scheduled_task = ScheduledTask.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def scheduled_task_params
      params.require(:scheduled_task).permit(:merchant_id, :scheduled_at)
    end
end
