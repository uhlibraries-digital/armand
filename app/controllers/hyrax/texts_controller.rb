# Generated via
#  `rails generate hyrax:work Text`
module Hyrax
  # Generated controller for Text
  class TextsController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    self.curation_concern_type = ::Text

    # Use this line if you want to use a custom presenter
    self.show_presenter = Hyrax::TextPresenter

    def thumbnail
      redirect_to presenter.thumbnail_path
    end
  end
end
