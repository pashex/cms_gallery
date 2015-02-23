RSpec.shared_examples "imageable" do
  let(:imageable) { described_class.new }

  it "should create thumb and medium versions of uploaded image" do
    imageable.update(image: File.open('spec/files/tux.png'))
    expect(imageable.image_url(:thumb)).to match /tux.png/
    expect(imageable.image_url(:medium)).to match /tux.png/
  end

end
