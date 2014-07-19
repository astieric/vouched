shared_examples_for "it has_scope" do
  describe "as has_scope" do
    it "should have scope" do
      described_class.scopes[current_scope].should_not eql nil
    end
  end
end
