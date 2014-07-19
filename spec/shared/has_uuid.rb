shared_examples_for "it has_uuid" do
  describe "as has_uuid" do
    describe :has_uuid do
      it "should create uuid on creation" do
        uuid_class = Factory.create(described_class.to_s.downcase.to_sym) 
        uuid_class.id.should_not eql nil
      end
    end
  end
end
