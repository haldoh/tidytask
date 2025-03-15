class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = current_user.tasks
  end

  def show; end

  def new
    @task = current_user.tasks.build
  end

  def edit; end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      redirect_to @task, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: t('.success')
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.expect(task: %i[title completed])
  end
end
