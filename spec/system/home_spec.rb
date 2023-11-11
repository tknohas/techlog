require 'rails_helper'

RSpec.describe 'Homes', type: :system do
  before do
    driven_by(:rack_test)
  end

  it "topページにアクセスできること" do
    visit "/"
    expect(page).to have_content('Home#top')
  end
end
