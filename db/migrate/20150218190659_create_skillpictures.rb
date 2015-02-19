class CreateSkillpictures < ActiveRecord::Migration
  def change
  create_table :skillpictures, force: true do |t|
    t.string   "alt_text",          default: ""
    t.string   "hint",              default: ""
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  end
end
