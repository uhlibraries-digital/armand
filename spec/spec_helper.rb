RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  def webmock_fixture(fixture)
    File.new File.expand_path(File.join("../fixtures", fixture), __FILE__)
  end

  def webmock_geoserver
    uri_template = Addressable::Template.new "https://geo.library.gsu.edu/geoserver/rest/workspaces/{workspace}/coveragestores/{id}/coverages/{id}.json"   
    stub_request(:get, uri_template)
      .to_return(body: webmock_fixture("maps/geoserver_response.json"), status: 200, headers: {})
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.example_status_persistence_file_path = 'spec/examples.txt'
  config.disable_monkey_patching!

  config.default_formatter = 'doc' if config.files_to_run.one?

  config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed
end