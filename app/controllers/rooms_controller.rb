class RoomsController < ApplicationController
  def own
    @rooms = current_user.rooms
  end

  def index
    @rooms = Room.all

    if params[:area].present?
      @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%")
    end

    if params[:keyword].present?
      @rooms = @rooms.where("name LIKE ? OR description LIKE ?", "%#{params[:keyword]}%")
    end
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
