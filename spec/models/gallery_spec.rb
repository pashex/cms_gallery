require 'rails_helper'
require 'support/imageable'

RSpec.describe Gallery, :type => :model do
  it { should have_many(:gallery_images) }

  it_should_behave_like "imageable"
end
