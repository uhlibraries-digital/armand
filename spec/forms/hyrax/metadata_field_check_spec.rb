# Generated via
#  `rails generate hyrax:work Image`
require 'rails_helper'
include Warden::Test::Helpers

# NOTE: If you generated more than one work, you have to set "js: true"
RSpec.feature 'Fill in all metadata fields', js: false do
  context 'a logged in user' do
    let(:user_attributes) do
      { email: 'test@example.com' }
    end
    let(:user) do
      User.new(user_attributes) { |u| u.save(validate: false) }
    end
    let(:admin_set_id) { AdminSet.find_or_create_default_admin_set_id }
    let(:permission_template) { Hyrax::PermissionTemplate.find_or_create_by!(source_id: admin_set_id) }
    let(:workflow) { Sipity::Workflow.create!(active: true, name: 'test-workflow', permission_template: permission_template) }

    before do
      # Create a single action that can be taken
      Sipity::WorkflowAction.create!(name: 'submit', workflow: workflow)

      # Grant the user access to deposit into the admin set.
      Hyrax::PermissionTemplateAccess.create!(
        permission_template_id: permission_template.id,
        agent_type: 'user',
        agent_id: user.user_key,
        access: 'deposit'
      )
      login_as user
    end

    scenario do
      # stub_request(:get, "https://github.com/mozilla/geckodriver/releases").
      #    with(
      #      headers: {
      #  	  'Accept'=>'*/*',
      #  	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      #  	  'Host'=>'github.com',
      #  	  'User-Agent'=>'Ruby'
      #      }).
      #    to_return(status: 200, body: "", headers: {})
      visit '/concern/images/new?locale=en'
      expect(page).to have_content "Add New Image"
      click_link "Files" # switch tab
      expect(page).to have_content "Add files"
      expect(page).to have_content "Add folder"
      within('span#addfiles') do
        attach_file("files[]", "#{Hyrax::Engine.root}/spec/fixtures/image.jp2", visible:false)
      end
      click_link "Descriptions" # switch tab
      click_link "Additional fields"
      fill_in('Title', with: 'My Test Work', :match => :prefer_exact)
      select('Public Domain', from: 'Rights', :match => :prefer_exact)
      fill_in('Access Rights', with: 'Public', :match => :prefer_exact)
      fill_in('Creator', with: 'UH', :match => :prefer_exact)
      fill_in('Description', with: 'This is a Test', :match => :prefer_exact)
      fill_in('Publisher', with: 'Public', :match => :prefer_exact)
      fill_in('Subject', with: 'Symbolism', :match => :prefer_exact)
      fill_in('Language', with: 'ENG', :match => :prefer_exact)
      fill_in('Identifier', with: 'old coog logo', :match => :prefer_exact)
      fill_in('Alternative Title', with: 'Rspec Test', :match => :prefer_exact)
      fill_in('Series title', with: 'UH Symbols', :match => :prefer_exact)
      fill_in('Date', with: '01/01/2001', :match => :prefer_exact)
      fill_in('Format', with: 'PNG', :match => :prefer_exact)
      select('Image', from: 'Type', :match => :prefer_exact)
      fill_in('Extent', with: 'N/A', :match => :prefer_exact)
      fill_in('Provenance', with: 'UH Domain', :match => :prefer_exact)
      fill_in('ArchivesSpace Uri', with: 'http://fatest.lib.uh.edu/repositories/2/archival_objects/12363', :match => :prefer_exact)
      fill_in('Donor', with: 'UH', :match => :prefer_exact)
      fill_in('Rights Holder', with: 'ABCD', :match => :prefer_exact)
      fill_in('Note', with: 'Test', :match => :prefer_exact)
      fill_in('Related Item', with: 'None', :match => :prefer_exact)
      fill_in('Digital Object ARK', with: 'ark:/ABC/123', :match => :prefer_exact)
      fill_in('Genre', with: 'Logos', :match => :prefer_exact)
      fill_in('Place', with: 'Library', :match => :prefer_exact)
      fill_in('Time period', with: 'Old', :match => :prefer_exact)
      fill_in('Preservation location', with: 'UH', :match => :prefer_exact)
      find('body').click
      choose('image_visibility_open')
      expect(page).to have_content('Please note, making something visible to the world')
      #click_on('Save')

    end
  end
end
