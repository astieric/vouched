shared_examples_for "it has_coordinates" do
  describe "as has_coordinates" do
    describe :has_coordinates do
      it "should have coordinates" do
        Factory.create(described_class.to_s.downcase.to_sym).coordinates.should_not eql nil
      end
    end
  end
end