shared_examples_for "it has_vouches" do
  describe "as has_vouches" do
    it_should_behave_like "it has_vouches_as_grantor"
    it_should_behave_like "it has_vouches_as_requester"
  end
end

shared_examples_for "it has_vouches_as_grantor" do
  describe :has_vouches_as_grantor do
    it "should have vouches as grantor" do
      model_with_given_vouches = Factory.create(("#{described_class.to_s}_with_given_vouches").downcase.to_sym) 
      model_with_given_vouches.vouches_given.length.should eql 2
      model_with_given_vouches.vouches_given.each do |v|
        v.grantor.id.should eql model_with_given_vouches.id
      end

    end
  end
end

shared_examples_for "it has_vouches_as_requester" do
  describe :has_vouches_as_requester do
    it "should have vouches as requester" do
      model_with_requested_vouches = Factory.create(("#{described_class.to_s}_with_requested_vouches").downcase.to_sym) 
      model_with_requested_vouches.vouches_requested.length.should eql 2
      model_with_requested_vouches.vouches_requested.each do |v|
        v.requester.id.should eql model_with_requested_vouches.id
      end
    end
  end
end
