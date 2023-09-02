module Mutations
  class MerchantSignIn < BaseMutation
    null true

    argument :credentials, Types::AuthProviderCredentialsInputType, required: false

    field :token, String, null: true
    field :merchant, Types::MerchantType, null: true

    def resolve(credentials: nil)
      
      return unless credentials

      merchant = Merchant.find_by email: credentials[:email]
      
      unless merchant && merchant.authenticate(credentials[:password])
     
        raise GraphQL::ExecutionError, 'Invalid username or password'
      end

      token = JsonWebToken.encode(user_id: merchant.id)

      context[:session][:token] = token
      
      { merchant: merchant, token: token  }
      
    end
  end
end
