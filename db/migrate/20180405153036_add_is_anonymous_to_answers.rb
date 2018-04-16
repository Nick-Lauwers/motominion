class AddIsAnonymousToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :is_anonymous, :boolean
  end
end
