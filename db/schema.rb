# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150219201854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "albums", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "albumable_id"
    t.string   "albumable_type"
    t.integer  "cover"
    t.string   "token"
  end

  add_index "albums", ["albumable_id", "albumable_type"], name: "index_albums_on_albumable_id_and_albumable_type", using: :btree

  create_table "assets", force: true do |t|
    t.string   "type"
    t.integer  "assetable_id"
    t.string   "assetable_type"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "assets", ["assetable_id", "assetable_type"], name: "index_assets_on_assetable_id_and_assetable_type", using: :btree

  create_table "attachables", force: true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "gallery_id"
  end

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "token_secret"
  end

  add_index "authentications", ["uid"], name: "index_authentications_on_uid", using: :btree
  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "avatars", force: true do |t|
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "avatarable_id"
    t.string   "avatarable_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "avatars", ["avatarable_id", "avatarable_type"], name: "index_avatars_on_avatarable_id_and_avatarable_type", using: :btree

  create_table "cards", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: true do |t|
    t.string   "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "contact_froms", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "messge"
    t.string   "message_title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "craps", force: true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.float    "name"
    t.float    "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.integer  "location_id"
    t.string   "location_name"
    t.string   "event_type"
    t.string   "privacy"
    t.string   "about"
    t.string   "headline"
    t.string   "eventable_type"
    t.integer  "eventable_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "flaggings", force: true do |t|
    t.string   "flaggable_type"
    t.integer  "flaggable_id"
    t.string   "flagger_type"
    t.integer  "flagger_id"
    t.string   "flag"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "flaggings", ["flag", "flaggable_type", "flaggable_id"], name: "index_flaggings_on_flag_and_flaggable_type_and_flaggable_id", using: :btree
  add_index "flaggings", ["flag", "flagger_type", "flagger_id", "flaggable_type", "flaggable_id"], name: "access_flag_flaggings", using: :btree
  add_index "flaggings", ["flaggable_type", "flaggable_id"], name: "index_flaggings_on_flaggable_type_and_flaggable_id", using: :btree
  add_index "flaggings", ["flagger_type", "flagger_id", "flaggable_type", "flaggable_id"], name: "access_flaggings", using: :btree

  create_table "friends", force: true do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "pic"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "profile_url"
  end

  add_index "friends", ["uid"], name: "index_friends_on_uid", using: :btree

  create_table "friendships", force: true do |t|
    t.string   "status"
    t.datetime "created_at"
    t.integer  "user_id"
    t.integer  "friend_id"
  end

  add_index "friendships", ["friend_id"], name: "index_friendships_on_friend_id", using: :btree
  add_index "friendships", ["user_id", "friend_id", "status"], name: "index_friendships_on_user_id_and_friend_id_and_status", unique: true, using: :btree
  add_index "friendships", ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", using: :btree
  add_index "friendships", ["user_id"], name: "index_friendships_on_user_id", using: :btree

  create_table "galleries", force: true do |t|
    t.integer  "gallerable_id"
    t.string   "gallerable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "location_id"
    t.string   "group_type"
    t.string   "privacy"
    t.string   "about"
    t.integer  "membership_id"
    t.integer  "event_id"
    t.string   "headline"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
  end

  add_index "groups", ["location_id"], name: "index_groups_on_location_id", using: :btree
  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "invitations", force: true do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "invited_id"
    t.string   "invited_type"
    t.integer  "inviteable_id"
    t.string   "inviteable_type"
    t.datetime "sent_at"
    t.string   "status"
  end

  add_index "invitations", ["inviteable_id", "inviteable_type"], name: "index_invitations_on_inviteable_id_and_inviteable_type", using: :btree
  add_index "invitations", ["invited_id", "invited_type", "inviteable_id", "inviteable_type"], name: "fk_one_invite_per_user_per_entity", unique: true, using: :btree
  add_index "invitations", ["invited_id", "invited_type"], name: "index_invitations_on_inviter_id_and_inviter_type", using: :btree

  create_table "invites", force: true do |t|
    t.string   "token"
    t.date     "sent_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
    t.integer  "inviteable_id"
    t.string   "inviteable_type"
    t.string   "status"
  end

  add_index "invites", ["inviteable_id", "inviteable_type", "status"], name: "index_invites_on_inviteable_id_and_inviteable_type_and_status", using: :btree

  create_table "localfeeds", force: true do |t|
    t.string   "city"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "ward_id"
    t.string   "locality"
    t.string   "political"
  end

  add_index "localfeeds", ["city"], name: "index_localfeeds_on_city", using: :btree
  add_index "localfeeds", ["location_id"], name: "index_localfeeds_on_location_id", using: :btree

  create_table "locations", force: true do |t|
    t.string   "address"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "postcode"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "actor_id"
    t.string   "country"
    t.string   "country_code"
    t.string   "postal_code"
    t.string   "city"
    t.string   "political"
    t.string   "locality"
    t.string   "sublocality"
    t.string   "street_address"
    t.string   "google_address"
    t.integer  "ward_id"
    t.integer  "mappable_id"
    t.string   "mappable_type"
    t.string   "type"
  end

  add_index "locations", ["mappable_id", "mappable_type"], name: "index_locations_on_mappable_id_and_mappable_type", using: :btree

  create_table "mailboxer_conversation_opt_outs", force: true do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: true do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "mappedfriends", force: true do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "pic"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "profile_url"
  end

  create_table "maps", force: true do |t|
    t.integer  "mappable_id"
    t.string   "mappable_type"
    t.integer  "location_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "maptest3s", force: true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.string   "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: true do |t|
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "pictures", force: true do |t|
    t.integer  "album_id"
    t.string   "image"
    t.string   "description"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "album_token"
    t.string   "file"
  end

  add_index "pictures", ["album_id"], name: "index_pictures_on_album_id", using: :btree

  create_table "places", force: true do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "location_id"
    t.integer  "locationable_id"
    t.string   "locationable_type"
  end

  create_table "prelaunches", force: true do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.date     "age"
    t.string   "website"
    t.string   "phoneNo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.string   "actor_id"
    t.text     "about"
    t.string   "skills"
    t.string   "interests"
    t.string   "university"
    t.string   "college"
    t.string   "school"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.text     "about"
    t.integer  "user_id"
    t.integer  "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name",              limit: 40
    t.string   "authorizable_type", limit: 40
    t.integer  "authorizable_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "scribbles", force: true do |t|
    t.string   "post"
    t.string   "posted_by"
    t.integer  "promotes"
    t.integer  "demotes"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "actor_id"
    t.integer  "user_id"
    t.integer  "scribbled_id"
    t.string   "scribbled_type"
    t.string   "file"
  end

  add_index "scribbles", ["scribbled_id", "scribbled_type"], name: "index_scribbles_on_scribbled_id_and_scribbled_type", using: :btree
  add_index "scribbles", ["user_id"], name: "index_scribbles_on_user_id", using: :btree

  create_table "skill_fields", force: true do |t|
    t.string   "name"
    t.string   "field_type"
    t.boolean  "required"
    t.integer  "skill_type_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "skill_fields", ["skill_type_id"], name: "index_skill_fields_on_skill_type_id", using: :btree

  create_table "skill_locations", force: true do |t|
    t.integer  "skill_id"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "skill_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "skill_id"
    t.string   "description"
  end

  create_table "skillpictures", force: true do |t|
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

  create_table "skills", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "skill_type_id"
    t.string   "necessary_resources"
    t.string   "level"
    t.string   "required_experience"
    t.datetime "start_date"
    t.integer  "max_students"
    t.integer  "min_students"
    t.decimal  "price",               precision: 8, scale: 2
    t.integer  "user_id"
    t.integer  "location_id"
    t.time     "activity_duration"
    t.string   "teachers_title"
  end

  add_index "skills", ["skill_type_id"], name: "index_skills_on_skill_type_id", using: :btree
  add_index "skills", ["user_id"], name: "index_skills_on_user_id", using: :btree

  create_table "uploads", force: true do |t|
    t.integer  "uploadable_id"
    t.string   "uploadable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "actor_id",                            null: false
    t.string   "profile_id"
    t.integer  "location_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.integer  "user_id"
  end

  add_index "users", ["actor_id"], name: "index_users_on_actor_id", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["profile_id"], name: "index_users_on_profile_id", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.boolean  "vote",          default: false, null: false
    t.integer  "voteable_id",                   null: false
    t.string   "voteable_type",                 null: false
    t.integer  "voter_id"
    t.string   "voter_type"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "votes", ["voteable_id", "voteable_type"], name: "index_votes_on_voteable_id_and_voteable_type", using: :btree
  add_index "votes", ["voter_id", "voter_type"], name: "index_votes_on_voter_id_and_voter_type", using: :btree

  create_table "wards", force: true do |t|
    t.integer  "location_id"
    t.integer  "warded_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "city"
    t.string   "locality"
    t.string   "political"
    t.string   "warded_type"
  end

  add_index "wards", ["warded_id"], name: "index_wards_on_warded_id", using: :btree

  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", name: "notifications_on_conversation_id", column: "conversation_id"

  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", name: "receipts_on_notification_id", column: "notification_id"

end
