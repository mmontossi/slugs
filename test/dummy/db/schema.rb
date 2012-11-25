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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120924010158) do

  create_table "simples", :force => true do |t|
    t.string  "name"
    t.integer "age"
    t.string  "slug"
  end

  create_table "translatables", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "translatables_i18n", :force => true do |t|
    t.integer  "translatable_id", :null => false
    t.string   "locale",          :null => false
    t.string   "name",            :null => false
    t.integer  "age",             :null => false
    t.string   "slug",            :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "translatables_i18n", ["created_at"], :name => "index_translatables_i18n_on_created_at"
  add_index "translatables_i18n", ["locale"], :name => "index_translatables_i18n_on_locale"
  add_index "translatables_i18n", ["name"], :name => "index_translatables_i18n_on_name"
  add_index "translatables_i18n", ["translatable_id"], :name => "index_translatables_i18n_on_translatable_id"
  add_index "translatables_i18n", ["updated_at"], :name => "index_translatables_i18n_on_updated_at"

end
