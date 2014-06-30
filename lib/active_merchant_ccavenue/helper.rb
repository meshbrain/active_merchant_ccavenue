module ActiveMerchant #:nodoc:
    module Billing #:nodoc:
        module Integrations #:nodoc:
            module Ccavenue
                class Helper < ActiveMerchant::Billing::Integrations::Helper
                    mapping :amount, 'Amount'
                    mapping :order, 'Order_Id'
                    mapping :customer, 
                      :name       => 'billing_cust_name',
                      :email      => 'billing_cust_email',
                      :phone      => 'billing_cust_tel',
                      :address    => 'billing_cust_address',
                      :country    => 'billing_cust_country'
                    mapping :delivery, 
                      :name       => 'delivery_cust_name',
                      :email      => 'delivery_cust_email',
                      :phone      => 'delivery_cust_tel',
                      :address    => 'delivery_cust_address',
                      :country    => 'delivery_cust_country'
                      

                    def redirect(mapping = {})
                        add_field 'Redirect_Url', mapping[:return_url]
                        add_field 'Merchant_Id', ActiveMerchant::Billing::Integrations::Ccavenue.merchant_id
                        add_field 'Checksum', get_checksum(
                            ActiveMerchant::Billing::Integrations::Ccavenue.merchant_id,
                            self.fields[self.mappings[:order]],
                            self.fields[self.mappings[:amount]],
                            mapping[:return_url],
                            ActiveMerchant::Billing::Integrations::Ccavenue.work_key
                        )
                    end

                    private

                    def get_checksum(*args)
                        require 'zlib'
                        Zlib.adler32 args.join('|'), 1
                    end
                end
            end
        end
    end
end
