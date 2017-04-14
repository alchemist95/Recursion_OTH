  class PagesController < ApplicationController
  before_action :set_auth
  before_action :find_question, only: [:index, :abdv]
  before_action :open_on_day, only: [:index, :home, :victory]
  before_action :authenticate, only: [:index]

  def leaderboard
    flash.clear
    @users=User.all.order(updated_at: :desc)
    @users=@users.sort_by(&:score).reverse
    @id=1
  end

	def index
    if @question == nil
      redirect_to victory_path
    end

    if params[:answer].present? && params[:answer] == @question.answer
      user = current_user
      user.score = user.score+10
      user.save!
      find_question
      if @question == nil
        redirect_to victory_path
      else
        flash[:notice] = 'Correct Answer. Level Up!!'
      end
    end
	end

  def abdv
    answer = params[:myAnswer]
    right_answer = @question.answer
    if answer==right_answer
      user = current_user
      user.score = user.score+10
      user.save!
      find_question
      myHash = Hash.new
      if @question == nil
        myHash["Statement"] = "XXX"
        myHash["Score"] = current_score
      else
        myHash["Statement"] = @question.statement
        myHash["Image"] = @question.imageurl
        myHash["Score"] = current_score
      end
      myHash = myHash.to_json
    else
      myHash = Hash.new
      myHash["Score"] = -1;
      myHash = myHash.to_json
    end
      respond_to do |format|
      format.html {}
      format.json { render json: myHash}
    end
 
  end

  def wait
    flash[:error] = "Hunt begins at 1400 hrs"
  end

	def home
    flash.clear
    user=current_user
  end

  def victory
    flash.clear
    flash[:success] = "Your hunt ends here!!"
  end

  def explore
    if session[:score].nil?
      session[:score]=0
      session[:victor]=0
    end
    if session[:victor]==0
      my_id = session[:score]/10+1
      if session[:score]>=180
          session[:victor] = 1
          redirect_to victory_path
      else
      @question = Question.find(my_id)
    end
    end
  end

    def set_auth
      @auth=session[:omniauth] if session[:omniauth]
    end


  private

  def open_on_day
    if current_user && current_user.normal?
      redirect_to wait_path
    else
      return
    end
  end

  def find_question
    if Question.exists?(id: current_score/10+1)
      @question = Question.find(current_score/10+1)
    else
      @question = nil
    end
  end

end
