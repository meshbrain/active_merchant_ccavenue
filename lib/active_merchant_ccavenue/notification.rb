module ActiveMerchant #:nodoc:
    module Billing #:nodoc:
        module Integrations #:nodoc:
            module Ccavenue
                class Notification < ActiveMerchant::Billing::Integrations::Notification
                    def valid?
                        verify_checksum(
                            self.security_key,
                            ActiveMerchant::Billing::Integrations::Ccavenue.merchant_id,
                            self.payment_id,
                            self.gross,
                            self.status,
                            ActiveMerchant::Billing::Integrations::Ccavenue.work_key
                        )
                    end

                    def complete?
                        'Y' == self.status
                    end

                    def payment_id
                        params['Order_Id']
                    end

                    def transaction_id
                        params['nb_order_no']
                    end

                    def security_key
                        params['Checksum']
                    end

                    # the money amount we received in X.2 decimal.
                    def gross
                        params['Amount']
                    end

                    def status
                        params['AuthDesc']
                    end
                    
                    private

                    def verify_checksum(checksum, *args)
                        require 'zlib'
                        Zlib.adler32(args.join('|'), 1).to_s.eql?(checksum)
                    end
                end
            end
        end
    end
end
