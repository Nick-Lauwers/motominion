class AddIsAnonymousToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :is_anonymous, :boolean
  end
end
