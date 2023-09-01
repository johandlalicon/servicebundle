module Mutations
  class CreateUser < BaseMutation
    require "pry"
    class AuthProviderSignupData < Types::BaseInputObject
      argument :credentials, Types::AuthProviderCredentialsInputType, required: false
    end

    field :token, String, null: true  # Include this line to specify the token field
    field :user, Types::UserType, null: true

    argument :auth_provider, AuthProviderSignupData, required: false

    def resolve(auth_provider: nil)
      user = User.create!(
        email: auth_provider&.[](:credentials)&.[](:email),
        password: auth_provider&.[](:credentials)&.[](:password)
      )

      if user.save
        token = JsonWebToken.encode(user_id: user.id)
        context[:session][:token] = token
      else
        raise GraphQL::ExecutionError, user.errors.full_messages.join(", ")
      end

      { user: user, token: token }  # Include the token in the response

    end
  end
end
