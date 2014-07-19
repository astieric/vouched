class CreateTranslations < ActiveRecord::Migration
  def self.up
    create_table :translations do |t|
      t.string   :term_id,    :limit => 36
      t.integer  :phrase_id
      t.integer  :priority,   :default => 1
    end

    add_index :translations, :term_id
    add_index :translations, :phrase_id
  end

  def self.down
    drop_table :translations
  end
end
