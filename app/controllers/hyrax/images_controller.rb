# Generated via
#  `rails generate hyrax:work Image`
module Hyrax
  # Generated controller for Image
  class ImagesController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    self.curation_concern_type = ::Image
    skip_authorize_resource :only => :thumbnail

    # Use this line if you want to use a custom presenter
    self.show_presenter = Hyrax::ImagePresenter

    def thumbnail
      redirect_to presenter.thumbnail_path
    end
  end
end
