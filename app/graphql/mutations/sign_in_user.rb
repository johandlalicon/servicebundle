module Mutations
  require 'pry'
  class SignInUser < BaseMutation
    null true

    argument :credentials, Types::AuthProviderCredentialsInputType, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true
    field :merchant, Types::MerchantType, null: true
    field :user_type, String, null: true

    def resolve(credentials: nil)
      return unless credentials

      user = User.find_by(email: credentials[:email])
      merchant = Merchant.find_by(email: credentials[:email])
      
      unless user && user.authenticate(credentials[:password])
        unless merchant && merchant.authenticate(credentials[:password])
          raise GraphQL::ExecutionError, 'Invalid username or password'
        end
      end

      if user
        
        token = JsonWebToken.encode(user_id: user.id)
        
        context[:session][:token] = token

        { user: user, user_type: 'User', token: token }
      elsif merchant
        
        token = JsonWebToken.encode(merchant_id: merchant.id)
        
        context[:session][:token] = token
        
        { merchant: merchant, user_type: 'Merchant', token: token }
      else
        raise GraphQL::ExecutionError, 'Invalid username or password'
      end
    end
  end
end
