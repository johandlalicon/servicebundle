class JsonWebToken
    require 'pry'
      SECRET_KEY = Rails.application.secrets.secret_key_base. to_s
    
      def self.encode(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, SECRET_KEY)
      end
    
      def self.decode(token)
        
        decoded = JWT.decode(token, SECRET_KEY)
        
        puts "Decoded Token: #{decoded.inspect}" 
        HashWithIndifferentAccess.new decoded
        
      end
    end

# class Dummy
#     def self.get_Date
#         Time.now.strftime('%F')
#     end
# end