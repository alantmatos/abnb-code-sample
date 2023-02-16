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


=begin

This is from an app I'm creating for the friend of a family member; this person would like to open a Laundromat 
and was thinking about having an option where customers could make a Reservation, making sure they will have a 
washer available at the time they requested. 
The shared link is the piece of code that was most challenging for me, In order to achieve such feature, 
I retrieve an array with reservations that matches the same washer size as the one selected by the user on 
the frontend, then check if there is enough time from one reservation to another, If Yes, the method checkReservations 
will return it allowing the code to proceed to save the request.
The backend logic is not done though. I will implement a reservation number, which can be used to cancel a reservation. 
A stretch goal for this project is to only display on the frontend the day/times where reservations are available. 

=end


