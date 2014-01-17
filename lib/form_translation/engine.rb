module FormTranslation
  class Engine < ::Rails::Engine
    initializer 'form_translation' do |app|
      ActiveSupport.on_load(:action_view) do
        require 'form_translation/view_helper'
        ActionView::Base.send(:include, FormTranslation::ViewHelper)
      end
    end
  end
end
