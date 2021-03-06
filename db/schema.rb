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

ActiveRecord::Schema.define(version: 20180129174108) do

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "images", force: :cascade do |t|
    t.text     "url"
    t.text     "description"
    t.integer  "superhero_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["superhero_id"], name: "index_images_on_superhero_id"
  end

  create_table "superheros", force: :cascade do |t|
    t.string   "page_id",                      null: false
    t.string   "name",                         null: false
    t.text     "urlslug"
    t.string   "identity"
    t.string   "align"
    t.string   "eye"
    t.string   "hair"
    t.string   "sex"
    t.string   "gsm"
    t.string   "alive"
    t.integer  "num_appearances",  default: 0
    t.string   "first_appearance"
    t.integer  "year",             default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "universe",         default: 0, null: false
    t.string   "slug"
    t.index ["slug"], name: "index_superheros_on_slug", unique: true
    t.index ["universe", "page_id", "name"], name: "index_superheros_on_universe_and_page_id_and_name", unique: true
  end

end
