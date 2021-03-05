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
      # load curation_concern manually because we need to skip authorize for thumbnail use
      begin
        curation_concern = _curation_concern_type.find(params[:id])
      rescue
        raise Hyrax::ObjectNotFoundError
      end
      path = Hyrax::Engine.routes.url_helpers.download_path(curation_concern.thumbnail_id, file: 'thumbnail')
      redirect_to path
    end
  end
end
