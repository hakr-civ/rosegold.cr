class Rosegold::Clientbound::ScoreboardObjective < Rosegold::Clientbound::Packet
  property \
    objective_name : String,
    mode : UInt8,
    objective_value : Rosegold::Chat?

  def initialize(@objective_name, @mode, @objective_value = nil)
  end

  def self.read(packet)
    self.new(
      packet.read_var_string,
      packet.read_byte
    ).tap do |p|
      p.objective_value = Rosegold::Chat.from_json(packet.read_var_string) if p.mode == 0
    end
  end
end
