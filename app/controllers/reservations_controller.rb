class ReservationsController < ApplicationController

  def index
    @reservations = Reservation.all
  end

  def confirm
    @room = Room.find(params[:reservation][:room_id])

    if params[:reservation][:id].present?
      @reservation = Reservation.find(params[:reservation][:id])
      @reservation.user_id = current_user.id
      @reservation.assign_attributes(reservation_params)
    else
      @reservation = Reservation.new(reservation_params)
      @reservation.user_id = current_user.id
    end

    if @reservation.invalid?
          puts "========== バリデーションエラーの中身 =========="
  puts @reservation.errors.full_messages
  puts "=================================================="
      render "/rooms/show", status: :unprocessable_entity
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id

    if @reservation.save
      redirect_to reservations_path
    else
      redirect_to room_path(@reservation.room_id)
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])

    if @reservation.update(reservation_params)
      redirect_to reservations_path
    else
      render :edit
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy

    redirect_to reservations_path
  end

  private

  def reservation_params
    params.require(:reservation).permit(:checkin_at, :checkout_at, :guest_count, :user_id, :room_id, :id)
  end
end
