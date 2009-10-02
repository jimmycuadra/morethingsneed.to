# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091002053953) do

  create_table "comments", :force => true do |t|
    t.string   "name"
    t.text     "comment",    :null => false
    t.integer  "entry_id",   :null => false
    t.integer  "user_id"
    t.string   "ip",         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["entry_id"], :name => "index_comments_on_entry_id"
  add_index "comments", ["ip"], :name => "index_comments_on_ip"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "entries", :force => true do |t|
    t.string   "noun",                          :null => false
    t.string   "verb",                          :null => false
    t.boolean  "needs",      :default => false
    t.string   "ip",                            :null => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["ip"], :name => "index_entries_on_ip"
  add_index "entries", ["noun", "verb"], :name => "index_entries_on_noun_and_verb", :unique => true
  add_index "entries", ["user_id"], :name => "index_entries_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username",                               :null => false
    t.string   "email",                                  :null => false
    t.string   "crypted_password",                       :null => false
    t.string   "password_salt",                          :null => false
    t.string   "persistence_token",                      :null => false
    t.string   "single_access_token",                    :null => false
    t.string   "perishable_token",                       :null => false
    t.boolean  "active",              :default => false, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", :force => true do |t|
    t.integer  "entry_id",   :null => false
    t.integer  "user_id"
    t.string   "ip",         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "up_vote"
  end

  add_index "votes", ["entry_id", "user_id"], :name => "index_votes_on_entry_id_and_user_id", :unique => true
  add_index "votes", ["entry_id"], :name => "index_votes_on_entry_id"
  add_index "votes", ["ip"], :name => "index_votes_on_ip"
  add_index "votes", ["up_vote"], :name => "index_votes_on_up_vote"

end
