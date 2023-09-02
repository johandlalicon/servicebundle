class GraphqlController < ApplicationController
  require 'pry'
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session
  

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      session: session,
      current_user: current_user
    }
    result = ServiceBundleSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?
    handle_error_in_development(e)
  end

  private

  def current_user
    
    authorization_header = request.headers['Authorization']
    if authorization_header.present?
      
      token = authorization_header.split(' ').last
      
        decoded_token = JsonWebToken.decode(token)
        
        if decoded_token[0][0]["user_id"]
          user = User.find_by(id: decoded_token[0][0]["user_id"])  
        raise GraphQL::ExecutionError, 'User not found' unless user
        user
        
        elsif decoded_token[0][0]["merchant_id"]
          
          user = Merchant.find_by(id: decoded_token[0][0]["merchant_id"]) 
          
        raise GraphQL::ExecutionError, 'Merchant not found' unless user
        
          user
        end

    elsif session[:token] 
        
        decoded_token = JsonWebToken.decode(session[:token])
        
        if decoded_token[0][0]["user_id"]
          user = User.find_by(id: decoded_token[0][0]["user_id"])  
        raise GraphQL::ExecutionError, 'User not found' unless user

        user
        
        elsif decoded_token[0][0]["merchant_id"]
          
          user = Merchant.find_by(id: decoded_token[0][0]["merchant_id"]) 
          
        # raise GraphQL::ExecutionError, 'Merchant not found' unless user
          user
        end
    else
      nil
    end
      
  end

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end
end
