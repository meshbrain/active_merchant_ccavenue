#require File.dirname(__FILE__) + '/active_merchant_ccavenue/helper.rb'
#require File.dirname(__FILE__) + '/active_merchant_ccavenue/notification.rb'

module ActiveMerchant #:nodoc:
    module Billing #:nodoc:
        module Integrations #:nodoc:
            module Ccavenue
                #autoload :Return, File.dirname(__FILE__) + '/active_merchant_ccavenue/return.rb'
                autoload :Helper, File.dirname(__FILE__) + '/active_merchant_ccavenue/helper.rb'
                autoload :Notification, File.dirname(__FILE__) + '/active_merchant_ccavenue/notification.rb'

                mattr_accessor :merchant_id
                mattr_accessor :work_key
                mattr_accessor :service_url

                self.service_url = 'https://www.ccavenue.com/shopzone/cc_details.jsp'

                def self.setup
                    yield(self)
                end

                def self.notification(post)
                    Notification.new(post)
                end
            end
        end
    end
end
