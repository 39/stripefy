module Stripefy
  module Stripefy
    require "active_support"
    extend ActiveSupport::Concern
    
    included do
      delegate :subscription, :cancel_subscription, :update_subscription, :to => :stripe_customer, :allow_nil => true

      def process_subscription(user_data, card_token, plan_id)
        begin
          customer = Stripe::Customer.create(:email => user_data['email'],
                                           :card => card_token,
                                           :plan => plan_id)
          self.set_stripe_id(customer.id) if customer.present?
          return customer
        rescue Exception => e
          Rails.logger.fatal "Error when creating stripe customer: #{e.message}"
          return nil
        end
      end
      
      def stripe_customer
        begin
          @stripe_customer ||= Stripe::Customer.retrieve(self.stripe_id) unless self.stripe_id.nil?
        rescue Exception => e
          Rails.logger.fatal "Error when retriving stripe client #{self.stripe_id}: #{e.message}"
          return
        end
        @stripe_customer
      end
      
      def stripe_charges
        @stripe_charges = {}
        begin
          @stripe_charges = Stripe::Charge.all(:customer => self.stripe_id) unless self.stripe_id.nil?
        rescue Exception => e
          Rails.logger.fatal "Error when retriving stripe charges for customer #{self.stripe_id}: #{e.message}"
          return
        end
        @stripe_charges[:data]
      end
      
      def set_stripe_id(id)
        self.stripe_id = id
        self.save
      end
      
      def active_subscription?
        return false if self.stripe_id.nil? or self.stripe_customer.nil? or !self.stripe_customer.respond_to?(:subscription)
        self.subscription.status == "active"
      end
      
      def number_of_payments
        self.stripe_charges.nil? ? 0 : self.stripe_charges.size
      end
      
      def total_payed
        self.stripe_charges.nil? ? 0 : self.stripe_charges.sum(&:amount)
      end
      
      def last_payment_epoch
        if self.stripe_customer.nil?
          "0"
        else
          self.subscription.nil? ? "0" : self.subscription["current_period_start"]
        end
      end

      def available_plans
        Stripe::Plan.all['data']
      end

      def current_plan
        self.stripe_customer.subscription or self.stripe_customer.invoices['data'].last['lines']['subscriptions'].last['plan']
      end
    end
  end
end
