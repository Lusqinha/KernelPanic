class AddDraftToPost < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :draft, :boolean, default: true
  end
end
