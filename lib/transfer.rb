class Transfer
  attr_accessor :receiver, :amount, :sender, :status

  def initialize(sender, receiver, amount)
    @receiver = receiver
    @sender = sender
    @amount = amount
    @status = "pending"
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if @status == "pending" && @sender.valid? && receiver.valid? && @sender.balance > @amount
      @receiver.deposit(@amount)
      @sender.deposit(-@amount)
      @status = "complete"
    else @sender.balance < @amount
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete" && @sender.balance >= @amount && @sender.valid? && receiver.valid?
      @receiver.deposit(-@amount)
      @sender.deposit(@amount)
      @status = "reversed"
    else @sender.balance < @amount
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end
end
