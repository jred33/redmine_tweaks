# Redmine Tweaks plugin for Redmine
# Copyright (C) 2013  AlphaNodes GmbH

require_dependency 'redmine/info'

# Create namespace module for override
module RedmineTweaks
  # Make it work in development environment
  unloadable
  
  module CustomHelpUrl
  
    # TODO: needs a restart of Redmine after custom_help_url setting value change
    # Override core Redmine::Info.help_url, when
    # Setting.plugin_redmine_custom_help_url['custom_help_url'] contains
    # a value otherwise fall back to core Redmine::Info.help_url value
    module Redmine
      module Info
        class << self
          def help_url
            Setting.plugin_redmine_tweaks['custom_help_url'] || 'http://www.redmine.org/guide'
          end
        end
      end
    end
  end
end


# Now include the namespace module into Redmine::Info module
unless Redmine::Info.included_modules.include? RedmineTweaks::CustomHelpUrl::Redmine::Info
    Redmine::Info.send(:include, RedmineTweaks::CustomHelpUrl::Redmine::Info)
end
