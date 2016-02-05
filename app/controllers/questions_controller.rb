class QuestionsController < ApplicationController
  load_and_authorize_resource
  before_action :load_subjects, except: [:index, :destroy]

  def index
    @questions = current_user.questions.paginate page: params[:page]
  end

  def create
    @question.user_id = current_user.id
    if @question.save
      flash[:success] = t "question.success"
      redirect_to questions_path
    else
      render :new
    end
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t "question.update_success"
      redirect_to questions_path
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    flash[:success] = t "question.deleted"
    redirect_to questions_path
  end

  private
  def question_params
    params.require(:question).permit :content, :question_type,
      :subject_id, :status, answers_attributes: [:id, :content, :correct_answer]
  end

  def load_subjects
    @subjects = Subject.all
  end
end
