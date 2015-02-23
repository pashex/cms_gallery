require 'rails_helper'
require 'support/imageable'

RSpec.describe GalleryImage, :type => :model do
  it { should belong_to(:gallery) }

  it_should_behave_like "imageable"
end
