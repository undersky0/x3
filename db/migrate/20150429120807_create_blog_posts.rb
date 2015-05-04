class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :author_name
      t.string :title
      t.text :keywords
      t.string :slug
      t.text :content

      t.timestamps
    end
  end
end
