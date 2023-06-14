class Rosegold::Action(T)
  # TODO try channel size 1 so #succeed/#fail aren't rendezvous
  getter channel : Channel(Bool) = Channel(Bool).new
  getter target : T
  getter check : Proc(Bool)

  def initialize(@target : T, @check : Proc(Bool) = Proc(Bool).new { true }); end

  def succeed
    @channel.send true
  end

  def fail(msg : String)
    Log.warn { msg }
    @channel.send false
  end

  def join
    channel.receive
  end
end
