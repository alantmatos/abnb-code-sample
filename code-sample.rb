def create
    new_reservation = Reservation.new(reservation_params)
    user_selected_size = params[:washer_id]
    user_selected_time = params[:reservation]
    is_requested_time_available = checkReservations(user_selected_time, user_selected_size)   

    if is_requested_time_available
      new_reservation.save
      render json: new_reservation, status: :created
    else
        render json: new_reservation.errors, status: :unprocessable_entity
    end
end 
 
 
def checkReservations(user_selected_time, user_selected_size)
      reservations_array = Reservation.where(washer_id: user_selected_size)

      desired_time = DateTime.parse(user_selected_time)
      next_available_time = desired_time + 40.minutes
      prev_available_time = desired_time - 40.minutes

      reservations_array.each { | reservation |
      if reservation.reservation > next_available_time ||  reservation.reservation < prev_available_time
          return true
        else
          return false
        end
       }    
 end