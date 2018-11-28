class TasksController < ApplicationController
  before_action :set_list
  before_action :set_task, only: [:edit, :update, :destroy, :up, :down]

  def new
    @task = Task.new
    render :form
  end

  def create
    @task = @list.tasks.new(task_params)
    if @task.save

      redirect_to board_path(@list.board_id)
    else
      render :form
    end
  end

  def edit
    render :form
  end

  def update
    if @task.update(task_params)
      redirect_to board_path(@list.board_id)
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to board_path(@list.board_id)
  end

  def up
    task1 = Task.where('priority > ?', @task.priority).order(:priority).first
    @task.priority = task1.priority + 1
    @task.save
    redirect_to board_path(@list.board_id)
  end

  def down
    task1 = Task.where('priority < ?', @task.priority).order(:priority).last
    @task.priority = task1.priority - 1
    @task.save
    redirect_to board_path(@list.board_id)
  end

  private
    def task_params
      params.require(:task).permit(:title, :priority, :body)
    end

    def set_list
      @list = List.find(params[:list_id])
    end

    def set_task
      @task = Task.find(params[:id])
    end
end