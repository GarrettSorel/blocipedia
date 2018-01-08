class CreateCollaborators < ActiveRecord::Migration[5.1]
  def change
    create_table :collaborators do |t|
      t.references :user, foreign_key: true
      t.references :wiki, foreign_key: true
    end
  end
end
