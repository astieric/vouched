shared_examples_for "it has_search_type" do
  describe "as has_search_type" do
    describe :has_search_type do
      it "should have a search type" do
        search_type_class = Factory.create(described_class.to_s.downcase.to_sym) 
        search_type_class.search_type.should eql described_class.to_s.downcase
      end
    end
  end
end
