require 'rails/generators'
module FormTranslation
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc 'install form_translation'
      source_root File.expand_path('../templates', __FILE__)

      def copy_initializer_file
        copy_file 'form_translation.rb', 'config/initializers/form_translation.rb'
      end
    end
  end
end
