class Journey

attr_reader :entry_station, :exit_station

def initialize
  @entry_station = nil
  @exit_station = nil
  # @in_journey = false
end

def in_journey?
  !!entry_station
end

# entry station has been called



end 