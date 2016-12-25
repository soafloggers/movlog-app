# frozen_string_literal: true

# MovlogAPP web service
class MovlogApp < Sinatra::Base
  get "/rooms/:location/?" do
    room_request = RoomRequest.call(params)
    results = FindRoomsFromApi.call(room_request)
    if results.success?
      content_type 'application/json'
      results.value
    else
      flash[:error] = result.value.message
    end
  end

  get "/flights/:origin/:destination/?" do
    room_request =  FlightRequest.call(params)
    results = FindFlightsFromApi.call(room_request)
    if results.success?
      content_type 'application/json'
      results.value
    else
      flash[:error] = 'Could not find any flights -- we are investigating!'
    end
  end
end
