class PagesController < ApplicationController
  before_action :set_auth
  before_action :find_question, only: [:index, :abdv]

  def leaderboard
    @users=User.all.order(updated_at: :desc)
    @users=@users.sort_by(&:score).reverse
    @users = @users.paginate(page: params[:page], per_page: 10)
    @id=1
  end

	def index
    if @question == nil
      redirect_to victory_path
    end
	end

  def abdv
    answer = params[:myAnswer]
    puts answer
    right_answer = @question.answer
    puts "htll"
    puts right_answer
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

	def home
     user=current_user
  end

  def victory
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

  def find_question
    if Question.exists?(id: current_score/10+1)
      @question = Question.find(current_score/10+1)
    else
      @question = nil
    end
  end

end
