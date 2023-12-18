class CreateMoviegoers < ActiveRecord::Migration[7.0]
  def change
    create_table 'moviegoers' do |t|
      t.string 'name'
      t.string 'provider'
      t.string 'uid'
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end
end
