module HappyTime
  module Rails
    class Engine < ::Rails::Engine
      ActionView::Base.send :include, HappyTime::ViewHelpers
    end
  end
end