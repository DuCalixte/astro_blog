class CreateAstroBlogs < ActiveRecord::Migration
  def change
    create_table :astro_blogs, :id => false do |t|
      t.string :uuid, :limit => 50, :null => false
      t.string :title
      t.string :description
      t.string :url
      t.text :explanation
      t.string :picture_url
      t.datetime :date

      t.timestamps null: false
    end
  end
end
