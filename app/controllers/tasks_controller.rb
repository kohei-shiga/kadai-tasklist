class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    
    def index
        @tasks = current_user.tasks.order(id: :desc)
    end
    
    def show
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = current_user.tasks.build(task_params)
        
        if @task.save
            flash[:success] = "新規タスクを作成しました。"
            redirect_to @task
        else
            flash.now[:danger] = "新規タスクの作成に失敗しました。"
            render :new
        end
    end
    
    def edit
    end
    
    def update

       if @task.update(task_params)
           flash[:success] = 'タスクが正常に編集されました。'
           redirect_to @task
       else
           flash.now[:danger] = 'タスクの編集に失敗しました。'
           render :edit
       end
    end
    
    def destroy
        @task.destroy
        
        flash[:success] = 'タスクが正常に削除されました。'
        redirect_to tasks_url
    end
    
    private
    def set_task
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            redirect_to root_url
        end
    end
    
    def task_params
        params.require(:task).permit(:content, :status)
    end
end
