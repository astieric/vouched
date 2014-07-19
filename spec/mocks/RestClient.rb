module RestClient
  def self.post *args
    @random_number = { "node_id" => rand(10000) }.to_json
    @random_number
  end
  def self.get_last_id
    @random_number
  end
end
