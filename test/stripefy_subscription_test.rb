require File.expand_path('../test_helper', __FILE__)

class StripefySubscriptionTest < Test::Unit::TestCase

  def setup
    @model = StripefyTestModel.new
    StripefyTestModel.class_eval do
      stripefy :subscription
    end
  end

  def test_process_subscription
    assert @model.respond_to?(:process_subscription)
  end

  def test_stripe_customer
    assert @model.respond_to?(:stripe_customer)
  end

  def test_stripe_charges
    assert @model.respond_to?(:stripe_charges)
  end

  def test_stripe_id
    assert @model.respond_to?(:stripe_id)
  end

  def test_active_subscription
    assert @model.respond_to?(:active_subscription?)
  end

  def test_number_of_payments
    assert @model.respond_to?(:number_of_payments)
  end

  def test_total_payed
    assert @model.respond_to?(:total_payed)
  end

  def test_last_payment_epoch
    assert @model.respond_to?(:last_payment_epoch)
  end

end
