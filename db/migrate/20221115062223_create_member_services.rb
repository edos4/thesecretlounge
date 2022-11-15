class CreateMemberServices < ActiveRecord::Migration[6.0]
  def change
    create_table :member_services do |t|
      t.references :member, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
