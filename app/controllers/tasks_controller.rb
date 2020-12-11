class TasksController < ApplicationController
    
    def index
        @tasks = Task.all
    end
    
    def show
        @task = Task.find(params[:id])
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = Task.new(task_params)
        
        if @task.save
            flash[:success] = "新規タスクを作成しました。"
            redirect_to @task
        else
            flash.now[:danger] = "新規タスクの作成に失敗しました。"
            render :new
        end
    end
    
    def edit
        @task = Task.find(params[:id])
    end
    
    def update
       @task = Task.find(params[:id])
       
       if @task.update(task_params)
           flash[:success] = 'タスクが正常に編集されました。'
           redirect_to @task
       else
           flash.now[:danger] = 'タスクの編集に失敗しました。'
           render :edit
       end
    end
    
    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        
        flash[:success] = 'タスクが正常に削除されました。'
        redirect_to tasks_url
    end
    
    private
    
    def task_params
        params.require(:task).permit(:content)
    end
end
