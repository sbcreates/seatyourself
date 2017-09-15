class ReservationsController < ApplicationController

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reservation = @restaurant.reservations.new
    @selected_time=DateTime.new(params[:reservation]["reservation_time(1i)"].to_i,params[:reservation]["reservation_time(2i)"].to_i,params[:reservation]["reservation_time(3i)"].to_i, params[:reservation]["reservation_time(4i)"].to_i)

    @year = params[:reservation]["reservation_time(1i)"].to_i
    @month = params[:reservation]["reservation_time(2i)"].to_i
    @day = params[:reservation]["reservation_time(3i)"].to_i

    if @year && @month && @day
    else
      redirect_to 'http://google.com'
    end
  end


  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reservation = @restaurant.reservations.new

    @reservation.reservation_time = params[:reservation][:reservation_time]
    @reservation.party_size = params[:reservation][:party_size]
    @reservation.user_id = session[:user_id]

    if current_user == nil
      flash[:notice] = "Please Log in first to make a Booking!"
      redirect_to root_path
    elsif @reservation.save
      flash[:notice] = "You're reservation has been book!"
      redirect_to restaurant_reservation_path @restaurant,@reservation
    else
      render :index
    end

  end

  def render_capacity_error
  end

  def show
  end

  private

  def load_all_reservation
    @reservatoin
  end

end
