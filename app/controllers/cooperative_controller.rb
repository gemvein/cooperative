class CooperativeController < ActionController::Base

  before_filter :configure_permitted_parameters, if: :devise_controller?

  include Rails.application.routes.url_helpers
  include Rails.application.routes.mounted_helpers
  include Devise::Controllers::Helpers

  protect_from_forgery
  before_filter :set_locale

  rescue_from CanCan::AccessDenied, :with => :access_denied
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  rescue_from ActiveRecord::RecordInvalid, :with => :object_error
  
  #add_breadcrumb :home.l, '/'

  def not_found
    render :status => 404, :layout => 'cooperative', :file => "#{Rails.root}/public/404"
  end

  def access_denied
    authenticate_user! and render :status => 403, :layout => 'cooperative', :file => "#{Rails.root}/public/403"
  end

  def object_error(exception)
    @exception = exception
    respond_to do |format|
      format.html { render :status => 422, :layout => 'cooperative', :file => "layouts/422" }
      format.js { render :status => 422, :file => 'layouts/422' }
    end

  end

protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :nickname
  end

private
  def set_locale
    I18n.local = params[:lang] if params[:lang].present?
  end
  
  def polymorphic_parent_class
    polymorphic_resource.classify.constantize
  end

  def polymorphic_parent_name
    polymorphic_resource.capitalize.singularize
  end

  def polymorphic_parent_id
    params[(polymorphic_resource.singularize + '_id').to_sym]
  end

  def polymorphic_parent
    polymorphic_parent_class.find(polymorphic_parent_id)
  end

  def polymorphic_object
    params[:id] ? polymorphic_parent_class.find(params[:id]) : nil
  end

  def polymorphic_resource
    params[:nesting_resource] || request.fullpath.split('/')[1] || nil
  end

  def activity_params(performer, event, target, options = {})
    performer.require(:id)
    event.require(:to_s)
    target.require(:id)
    options.permit(:root, :topic)
  end
end
