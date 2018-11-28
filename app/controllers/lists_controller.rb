class ListsController < ApplicationController
  before_action :set_board, except: [:up, :down]
  before_action :set_list, only: [:show, :edit, :update, :destroy, :up, :down]

  def index
  end

  def new
    @list = List.new
  end

  def create
    @list = @board.lists.create(list_params)
    if @list.save
      redirect_to board_path(@board)

    else
      render :new
    end
  end

  def edit
  end

  def update
    if @list.update(list_params)
      redirect_to board_path(@board)
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @list.destroy
    redirect_to board_path(@board)
  end

  def up
    list1 = List.where('priority > ?', @list.priority).order(:priority).first
    @list.priority = list1.priority + 1
    @list.save
    redirect_to board_path(@list.board_id)
  end

  def down
    list1 = List.where('priority < ?', @list.priority).order(:priority).last
    @list.priority = list1.priority - 1
    @list.save
    redirect_to board_path(@list.board_id)
  end

  private
    def list_params
      params.require(:list).permit(:title, :priority)
    end

    def set_board
      @board = Board.find(params[:board_id])
    end

    def set_list
      @list = List.find(params[:id])
    end
end