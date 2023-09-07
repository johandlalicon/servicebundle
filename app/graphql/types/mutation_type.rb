module Types
  class MutationType < Types::BaseObject
    field :update_status, mutation: Mutations::UpdateStatus
    field :create_booking, mutation: Mutations::CreateBooking
    field :add_service, mutation: Mutations::AddService
    field :add_category, mutation: Mutations::AddCategory
    field :merchant_sign_in, mutation: Mutations::MerchantSignIn
    field :sign_in_user, mutation: Mutations::SignInUser
    field :create_user, mutation: Mutations::CreateUser
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end
  end
end
