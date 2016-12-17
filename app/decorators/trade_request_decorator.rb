class TradeRequestDecorator < Draper::Decorator
  delegate_all

  def intention
    "#{object.kind}ing"
  end

end
