require File.expand_path("../stripefy/version", __FILE__)
require "active_record"
require "active_support"
require "stripe"

module Stripefy
  def stripefy(*args)
    if args.blank? or args[0].blank?
      raise ArgumentError
    end

    @type = args[0]
    @stripe_id_column = args[1]

    require File.expand_path("../stripefy/stripefy", __FILE__)
    include Stripefy
  end
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Stripefy
end
