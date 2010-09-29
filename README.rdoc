= ActiveMerchantCcavenue

CCAvenue integration for ActiveMerchant.

== Installation

=== Requirements

You need to install the ActiveMerchant gem or rails plugin. More info about ActiveMerchant installation can be found at http://www.activemerchant.org/.

=== As a gem

Install the gem [recommended]:

  > sudo gem install active_merchant_ccavenue

To use the ActiveMerchantCcavenue gem in a Rails application, add the following line in your environment.rb:

  config.gem 'active_merchant_ccavenue'

=== As a Rails plugin

To add ActiveMerchantCcavenue as a plugin in a Rails application, run the following command in your application root:

  > ./script/plugin install git@github.com:meshbrain/active_merchant_ccavenue.git

== Configuration

Once you have a merchant account with CCAvenue, you need to generate your encryption key. This can be done in their 'Settings & Options -> Generate Working Key' page at the time of writing. Note them down and make sure your account is activated.

Then create an initializer, like initializers/payment.rb. Add the following lines:

  ActiveMerchant::Billing::Integrations::Ccavenue.setup do |cca|
    cca.merchant_id = M_blahpache_5678 #your CCAvenue merchant id from the working key generation page
    cca.work_key = 6abc0ty90e0v7jk9hj #your CCAvenue working key
  end
  CCAVENUE_ACCOUNT = 'youraccountname'

If ActiveMerchant's actionview helpers don't load automatically, add the line in your initializer:

  ActionView::Base.send :include, ActiveMerchant::Billing::Integrations::ActionViewHelper

== Example Usage

Once you've configured ActiveMerchantCcavenue, you need a checkout action; my view looks like:

  <% payment_service_for @order.order_id, CCAVENUE_ACCOUNT,
      :amount => @order.price,
      :currency => 'INR',
      :service => :ccavenue do |service| %>    
    <%  service.customer :name => current_user.name,
               :email => current_user.email,
               :phone => current_user.mobile %>    
    <%  service.redirect :return_url => confirm_order_url(@order) %>
    <%= submit_tag 'Proceed to payment' %>
  <% end %>

You also need a return or confirmation action; my action looks like:

  @notification = ActiveMerchant::Billing::Integrations::Ccavenue::Notification.new(request.raw_post)
  if @notification.payment_id.present?
    @order = Order.find_by_order_id(@notification.payment_id)
    if @notification.complete? and @notification.valid?
      @order.confirm!
    else
      @order.reject!
    end
  end

== Copyright

Copyright (c) 2010 Suman Debnath. See LICENSE for details.
