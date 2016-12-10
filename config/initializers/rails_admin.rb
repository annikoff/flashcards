# frozen_string_literal: true
RailsAdmin.config do |config|
  config.parent_controller = '::ApplicationController'
  config.authenticate_with do
    require_login
  end
  config.current_user_method(&:current_user)

  ## == Pundit ==
  config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    show
    edit
    delete

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
  config.excluded_models = ['Authentication']
end
