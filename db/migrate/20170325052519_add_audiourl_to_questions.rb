class AddAudiourlToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :audiourl, :string
  end
end
