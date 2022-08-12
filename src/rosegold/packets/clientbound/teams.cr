class Rosegold::Clientbound::Teams < Rosegold::Clientbound::Packet
  property \
    team_name : String

  def initialize(@team_name)
  end

  def self.read(packet)
    self.new(
      packet.read_var_string
    )
  end
end
