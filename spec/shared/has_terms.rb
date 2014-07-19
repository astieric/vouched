shared_examples_for "it has_terms" do
  describe "as has_terms" do
    describe :has_terms do
      it "should have terms" do
        model_with_terms = Factory.create(("#{described_class.to_s}_with_two_terms").downcase.to_sym) 
        model_with_terms.terms.length.should eql 2
      end
    end
  end
end
