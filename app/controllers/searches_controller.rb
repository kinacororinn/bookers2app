class SearchesController < ApplicationController
  before_action :authenticate_user!
  def search
    @model = params["range"]
    @value = params["word"]
    @how = params["search"]
    @datas = search_for(@how, @model, @value)
    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @books = Book.looks(params[:search], params[:word])
    end
  end

  def index
  end

  def show
  end
  private

  def match(model, value)                     #def search_forでhowがmatchだった場合の処理
    if model == 'user'                        #modelがuserの場合の処理
      User.where(name: value)                 #whereでvalueと完全一致するnameを探します
    elsif model == 'book'
      Book.where(title: value)
    end
  end

  def forward(model, value)
    if model == 'User'
      User.where("name LIKE ?", "#{value}%")
    elsif model == 'book'
      Book.where("title LIKE ?", "#{value}%")
    end
  end

  def backward(model, value)
    if model == 'user'
      User.where("name LIKE ?", "%#{value}")
    elsif model == 'book'
      Book.where("title LIKE ?", "%#{value}")
    end
  end

  def partical(model, value)
    if model == 'user'
      User.where("name LIKE ?", "%#{value}%")
    elsif model == 'book'
      Book.where("title LIKE ?", "%#{value}%")
    end
  end

  def search_for(how, model, value)       #searchアクションで定義した情報が引数に入っている
    case how                              #検索方法のhowの中身がどれなのかwhenの条件分岐の中から探す処理
    when 'match'
      match(model, value)                 #検索方法の引数に(model, value)を定義している
    when 'forward'                        #例えばhowがmatchの場合は def match の処理に進みます
      forward(model, value)
    when 'backward'
      backward(model, value)
    when 'partical'
      partical(model, value)
    end
  end
end
