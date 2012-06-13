Stripefy
========

Get your model ready to interact with Stripe.com and it's ruby gem
stripe

Installation
------------
Include 'gem install stripefy' in your Gemfile and run bundle.

Usage
-----
There are 2 ways to use this gem. You can either have subscriptions,
or one time payments (pending).

### Subscriptions
First, you need to associate your model to a customer in
Stripe.com. To do this, let's first generate a migration to add a new
field to your model

      rails g migration Model stripe_id:string

You can use any name you like for the field to save the customer
id. We recommend using stripe_id.

Now you need to go to your Stripe.com control panel and create one or
several plans you will be charging users with. Write down the ids of
those plans.

Now it's time to stripefy your model to have access to all the awesome
features Stripe provides.

class Model < ActiveRecord::Base
  stripefy :subscription
  # stripefy :subscription, :stripe_customer_id
end

stripefy accepts 2 parameters. The first one is the type of payments
you want to handle, whether it is :subscription or
:one_time_payment, for this case use subscriptions.
The last parameter is also  optional and is the field to
store the customer id, by default it is :stripe_id

### Creating your customer

Available methods
-----------------

        create_stripe_customer(token, plan, email, args)
This method will create a customer for stripe and add it to the
instance you are calling this method from. There are no required
arguments, you can just create a customer with out parameters. For
simplicity i have split the arguments from the api, showing only the
most common once and leaving the rest in the optional args dictionary.

If you place a plan and a token, the user will be charged inmediately
and the account will be considered active.

Example:
                u = User.create(:email => "test@test.com")
                u.create_stripe_customer("CARD_TOKEN", u.stripe, u.email)
                u.stripe_customer
                # TODO: Returns STRIPE CUSTOMER

       create_subscription(plan, token=nil)
Returns true if a subscription within the given plan for the user 
could be created, false if it couldn't be created. The token is
optional as it will try to use the stripe customer card.

       stripe_customer
Returns the Stripe::Customer object for the instance.

       stripe_active?
Returns true if the user has a subscription to a plan and has a
current payment.

       stripe_subscribed?
Returns true if the user is currently subscribed to some plan. It
doesn't mean necessarily that the user is active, just subscribed.

       stripe_charges
Returns a list of all the charges made to the user.

       stripe_cancel_subscription(active_until_payment_due)
Cancels the subscription of a user. Unless you pass it a true
parameter, the account will be made inactive immediately, otherwise it
will be made inactive the date the last payment is due.

       stripe_update_customer(plan_id)
Changes costumer plan to the plan with the id specified in the
plan id parameter.

                
TODO
----
- One Time payments
- Handle plans creation
