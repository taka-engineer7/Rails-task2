class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.user = current_user

    if @room.save
      redirect_to @room, notice: "施設が作成されました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])

    if @room.update(room_params)
      redirect_to @room, notice: "施設情報が更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :price, :address, :image)
  end
end
