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

ActiveRecord::Schema.define(version: 20150313125758) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "name",                     null: false
    t.string   "path",       default: "/", null: false
    t.text     "content",    default: "",  null: false
    t.integer  "position"
    t.string   "handler"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "documents", ["path", "handler"], name: "index_documents_on_path_and_handler", unique: true, using: :btree
  add_index "documents", ["path"], name: "index_documents_on_path", using: :btree
  add_index "documents", ["position"], name: "index_documents_on_position", using: :btree

  create_table "extra_categories", force: :cascade do |t|
    t.integer "product_id",        null: false
    t.integer "extra_category_id", null: false
  end

  add_index "extra_categories", ["product_id", "extra_category_id"], name: "index_extra_categories_on_product_id_and_extra_category_id", unique: true, using: :btree

  create_table "order_items", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.decimal  "price",      precision: 8, scale: 2
    t.decimal  "sum",        precision: 8, scale: 2
    t.integer  "product_id"
    t.integer  "count",                              default: 1, null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "order_id"
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "name",         default: "",    null: false
    t.string   "company_name", default: "",    null: false
    t.string   "phone",        default: "",    null: false
    t.string   "email",        default: "",    null: false
    t.string   "details_file"
    t.text     "comment",      default: "",    null: false
    t.boolean  "real",         default: false, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "state",        default: 0,     null: false
  end

  create_table "product_categories", force: :cascade do |t|
    t.integer  "product_category_id"
    t.string   "name",                              null: false
    t.string   "path",                default: "/", null: false
    t.integer  "position"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "product_categories", ["position"], name: "index_product_categories_on_position", using: :btree
  add_index "product_categories", ["product_category_id", "path"], name: "index_product_categories_on_product_category_id_and_path", unique: true, using: :btree
  add_index "product_categories", ["product_category_id"], name: "index_product_categories_on_product_category_id", using: :btree

  create_table "product_couples", id: false, force: :cascade do |t|
    t.integer "product_id"
    t.integer "couple_id"
  end

  add_index "product_couples", ["product_id", "couple_id"], name: "index_product_couples_on_product_id_and_couple_id", unique: true, using: :btree

  create_table "product_photos", force: :cascade do |t|
    t.integer "product_id"
    t.string  "src"
    t.integer "position"
  end

  add_index "product_photos", ["position"], name: "index_product_photos_on_position", using: :btree
  add_index "product_photos", ["product_id"], name: "index_product_photos_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.integer  "product_category_id"
    t.string   "name",                                                      null: false
    t.string   "path_id",                                                   null: false
    t.string   "factory",                                     default: "",  null: false
    t.string   "factory_url",                                 default: "",  null: false
    t.string   "factory_country",                             default: "",  null: false
    t.text     "description",                                 default: "",  null: false
    t.string   "fabric",                                      default: "",  null: false
    t.string   "size",                                        default: "",  null: false
    t.decimal  "wear_pct",            precision: 4, scale: 2, default: 0.0
    t.string   "code",                                        default: "",  null: false
    t.decimal  "price",               precision: 8, scale: 2
    t.string   "warranty",                                    default: "",  null: false
    t.integer  "position"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.text     "keywords",                                    default: "",  null: false
  end

  add_index "products", ["position"], name: "index_products_on_position", using: :btree
  add_index "products", ["product_category_id", "path_id"], name: "index_products_on_product_category_id_and_path_id", unique: true, using: :btree
  add_index "products", ["product_category_id"], name: "index_products_on_product_category_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string  "key",                         null: false
    t.string  "value"
    t.integer "position"
    t.string  "kind",     default: "string", null: false
  end

  add_index "settings", ["position"], name: "index_settings_on_position", using: :btree

  create_table "slides", force: :cascade do |t|
    t.string  "src"
    t.text    "content",  default: "", null: false
    t.integer "position"
  end

  add_index "slides", ["position"], name: "index_slides_on_position", using: :btree

  add_foreign_key "order_items", "orders", on_delete: :cascade
  add_foreign_key "order_items", "products", on_delete: :nullify
end
