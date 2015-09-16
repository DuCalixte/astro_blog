class CreateAstroBlogs < ActiveRecord::Migration
  def change
    create_table :astro_blogs, :id => false do |t|
      t.string :uuid, :limit => 50, :null => false
      t.string :title
      t.text :description
      t.string :url
      t.text :explanation
      t.string :picture_url
      t.datetime :date

      t.timestamps null: false
    end
    add_index(:astro_blogs, [:title, :url], :unique => true,
      :name => 'astro_blogs_title_with_link')
  end
end
