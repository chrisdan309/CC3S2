class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table 'reviews' do |t|
      t.integer    'potatoes'
      t.text       'comments'
      t.belongs_to :moviegoer
      t.belongs_to :movie

    end
  end
end
