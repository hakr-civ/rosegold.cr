class Rosegold::Clientbound::UpdateScore < Rosegold::Clientbound::Packet
  property \
    entity_name : String

  def initialize(@entity_name)
  end

  def self.read(packet)
    self.new(
      packet.read_var_string,
    )
  end
end
