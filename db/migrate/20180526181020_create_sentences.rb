class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.string :content
      t.string :user_id
    end
  end
end
