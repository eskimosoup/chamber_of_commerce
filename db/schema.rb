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

ActiveRecord::Schema.define(version: 20230203140906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "additional_contents", force: :cascade do |t|
    t.string   "area"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "button_link"
    t.text     "button_text"
  end

  create_table "advertisements", force: :cascade do |t|
    t.string   "name",                                     null: false
    t.string   "url"
    t.string   "image_large",                              null: false
    t.string   "image_medium",                             null: false
    t.string   "image_small",                              null: false
    t.datetime "publish_at",                               null: false
    t.datetime "expire_at"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.float    "longitude"
    t.float    "latitude"
    t.string   "postcode"
    t.decimal  "postcode_radius", precision: 16, scale: 6
  end

  create_table "article_categories", force: :cascade do |t|
    t.string   "title",                          null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "slug"
    t.boolean  "member_related", default: false
  end

  add_index "article_categories", ["slug"], name: "index_article_categories_on_slug", using: :btree

  create_table "articles", force: :cascade do |t|
    t.string   "title",                                      null: false
    t.integer  "article_category_id"
    t.text     "summary"
    t.text     "content"
    t.string   "image"
    t.datetime "date"
    t.boolean  "display",             default: true
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "suggested_url"
    t.string   "slug"
    t.string   "layout",              default: "full_image"
    t.string   "caption"
  end

  add_index "articles", ["article_category_id"], name: "index_articles_on_article_category_id", using: :btree
  add_index "articles", ["slug"], name: "index_articles_on_slug", unique: true, using: :btree

  create_table "attendee_event_agendas", force: :cascade do |t|
    t.integer  "attendee_id"
    t.integer  "event_agenda_id"
    t.decimal  "price",           precision: 8, scale: 2, default: 0.0
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  add_index "attendee_event_agendas", ["attendee_id"], name: "index_attendee_event_agendas_on_attendee_id", using: :btree
  add_index "attendee_event_agendas", ["event_agenda_id"], name: "index_attendee_event_agendas_on_event_agenda_id", using: :btree

  create_table "attendees", force: :cascade do |t|
    t.integer  "event_booking_id"
    t.string   "phone_number"
    t.string   "email"
    t.text     "dietary_requirements"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "forename"
    t.string   "surname"
  end

  add_index "attendees", ["event_booking_id"], name: "index_attendees_on_event_booking_id", using: :btree

  create_table "event_agendas", force: :cascade do |t|
    t.string   "name",                                                    null: false
    t.integer  "event_category_id"
    t.time     "start_time"
    t.time     "end_time"
    t.text     "description"
    t.integer  "maximum_capacity"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.integer  "event_id"
    t.decimal  "price",             precision: 8, scale: 2, default: 0.0
    t.integer  "table_size",                                default: 10
    t.decimal  "table_discount",    precision: 5, scale: 2, default: 0.0
    t.boolean  "must_book"
  end

  add_index "event_agendas", ["event_category_id"], name: "index_event_agendas_on_event_category_id", using: :btree
  add_index "event_agendas", ["event_id"], name: "index_event_agendas_on_event_id", using: :btree

  create_table "event_bookings", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "forename",                                 null: false
    t.string   "company_name"
    t.string   "industry"
    t.string   "nature_of_business"
    t.string   "phone_number"
    t.string   "email"
    t.boolean  "paid",                     default: false
    t.integer  "attendees_count",          default: 0
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "stripe_charge_id"
    t.boolean  "refunded",                 default: false
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "town"
    t.string   "postcode"
    t.string   "surname"
    t.string   "payment_method"
    t.string   "stripe_payment_intent_id"
    t.boolean  "booked_on_full_event",     default: false
  end

  add_index "event_bookings", ["event_id"], name: "index_event_bookings_on_event_id", using: :btree

  create_table "event_categories", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "name",                         null: false
    t.boolean  "has_tables"
    t.boolean  "food_event"
    t.boolean  "bookable",      default: true
    t.string   "suggested_url"
    t.string   "slug"
    t.integer  "position"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "event_category_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "event_category_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "event_category_anc_desc_idx", unique: true, using: :btree
  add_index "event_category_hierarchies", ["descendant_id"], name: "event_category_desc_idx", using: :btree

  create_table "event_locations", force: :cascade do |t|
    t.string   "address_line_1", null: false
    t.string   "address_line_2"
    t.string   "city",           null: false
    t.string   "region"
    t.string   "post_code"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "location_name"
    t.string   "slug"
  end

  create_table "event_offices", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",                                            null: false
    t.integer  "event_agendas_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "image"
    t.integer  "event_location_id"
    t.text     "description"
    t.boolean  "display",                          default: true
    t.integer  "event_agendas_count",              default: 0
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "suggested_url"
    t.string   "slug"
    t.text     "summary"
    t.text     "booking_confirmation_information"
    t.integer  "event_bookings_count",             default: 0
    t.string   "eventbrite_link"
    t.boolean  "allow_booking",                    default: true
    t.integer  "event_office_id"
    t.datetime "booking_deadline"
    t.string   "layout"
    t.string   "caption"
    t.text     "fully_booked_content"
  end

  add_index "events", ["event_agendas_id"], name: "index_events_on_event_agendas_id", using: :btree
  add_index "events", ["event_location_id"], name: "index_events_on_event_location_id", using: :btree
  add_index "events", ["event_office_id"], name: "index_events_on_event_office_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "industries", force: :cascade do |t|
    t.string   "name",          null: false
    t.integer  "chamber_db_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "internal_promotions", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "image"
    t.string   "link"
    t.string   "area",                      null: false
    t.boolean  "display",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "text"
  end

  create_table "magazines", force: :cascade do |t|
    t.string   "name",                        null: false
    t.string   "file"
    t.date     "date"
    t.string   "image"
    t.boolean  "display",      default: true
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "external_url"
  end

  create_table "member_industries", force: :cascade do |t|
    t.integer  "member_id"
    t.integer  "industry_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "member_industries", ["industry_id"], name: "index_member_industries_on_industry_id", using: :btree
  add_index "member_industries", ["member_id"], name: "index_member_industries_on_member_id", using: :btree

  create_table "member_logins", force: :cascade do |t|
    t.integer  "member_id"
    t.string   "username"
    t.string   "password_digest"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.boolean  "active",               default: true
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "contact_name"
  end

  add_index "member_logins", ["member_id"], name: "index_member_logins_on_member_id", using: :btree

  create_table "member_offers", force: :cascade do |t|
    t.integer  "member_id"
    t.string   "title",        null: false
    t.text     "summary",      null: false
    t.text     "description"
    t.string   "website_link"
    t.string   "image"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "verified"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "slug"
  end

  add_index "member_offers", ["member_id"], name: "index_member_offers_on_member_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.string   "company_name"
    t.text     "address"
    t.string   "telephone"
    t.string   "website"
    t.string   "email"
    t.boolean  "verified"
    t.text     "nature_of_business"
    t.integer  "member_login_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "slug"
    t.integer  "member_offers_count", default: 0
    t.string   "fax"
    t.string   "post_code"
    t.integer  "chamber_db_id"
    t.boolean  "in_csv",              default: true
  end

  add_index "members", ["chamber_db_id"], name: "index_members_on_chamber_db_id", using: :btree
  add_index "members", ["member_login_id"], name: "index_members_on_member_login_id", using: :btree

  create_table "memberships_enquiries", force: :cascade do |t|
    t.string   "forename"
    t.string   "surname"
    t.string   "telephone"
    t.string   "email_address"
    t.string   "company_name"
    t.string   "postcode"
    t.integer  "memberships_package_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.text     "message"
  end

  add_index "memberships_enquiries", ["memberships_package_id"], name: "index_memberships_enquiries_on_memberships_package_id", using: :btree

  create_table "memberships_groups", force: :cascade do |t|
    t.integer  "position",      default: 0
    t.string   "title"
    t.text     "summary"
    t.text     "content"
    t.string   "image"
    t.string   "slug"
    t.string   "suggested_url"
    t.boolean  "display",       default: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "memberships_groups", ["slug"], name: "index_memberships_groups_on_slug", using: :btree

  create_table "memberships_how_heards", force: :cascade do |t|
    t.integer  "position",   default: 0
    t.string   "title",                     null: false
    t.boolean  "display",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "memberships_join_reasons", force: :cascade do |t|
    t.integer  "position",   default: 0
    t.string   "title"
    t.boolean  "display",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "memberships_packages", force: :cascade do |t|
    t.integer  "position",                                    default: 0
    t.string   "title"
    t.decimal  "cost",                precision: 8, scale: 2,                null: false
    t.boolean  "display",                                     default: true
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.decimal  "special_offer_price", precision: 8, scale: 2
  end

  create_table "memberships_payment_how_heards", force: :cascade do |t|
    t.integer  "memberships_payment_id"
    t.integer  "memberships_how_heard_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "memberships_payment_how_heards", ["memberships_how_heard_id"], name: "index_memberships_how_heards_on_memberships_how_heard_id", using: :btree
  add_index "memberships_payment_how_heards", ["memberships_payment_id"], name: "index_memberships_payment_how_heards_on_memberships_payment_id", using: :btree

  create_table "memberships_payment_join_reasons", force: :cascade do |t|
    t.integer  "memberships_payment_id"
    t.integer  "memberships_join_reason_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "memberships_payment_join_reasons", ["memberships_join_reason_id"], name: "index_memberships_join_reasons_on_memberships_join_reason_id", using: :btree
  add_index "memberships_payment_join_reasons", ["memberships_payment_id"], name: "index_memberships_join_reasons_on_memberships_payment_id", using: :btree

  create_table "memberships_payments", force: :cascade do |t|
    t.string   "company_name",                                                           null: false
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "county"
    t.string   "postcode"
    t.string   "business_activity"
    t.integer  "number_of_employees"
    t.string   "website"
    t.string   "telephone"
    t.string   "legal_status"
    t.date     "business_start_date"
    t.string   "linkedin"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "primary_contact_title"
    t.string   "primary_contact_forename"
    t.string   "primary_contact_surname"
    t.string   "primary_contact_role"
    t.string   "primary_contact_telephone"
    t.string   "primary_contact_email_address"
    t.string   "company_number"
    t.string   "vat_number"
    t.string   "accounts_contact_title"
    t.string   "accounts_contact_forename"
    t.string   "accounts_contact_surname"
    t.string   "accounts_contact_role"
    t.string   "accounts_contact_telephone"
    t.string   "accounts_contact_email_address"
    t.integer  "memberships_package_id"
    t.string   "memberships_package_title"
    t.decimal  "memberships_package_cost",       precision: 8, scale: 2
    t.decimal  "total_paid",                     precision: 8, scale: 2
    t.boolean  "paid",                                                   default: false
    t.string   "stripe_charge_id"
    t.string   "stripe_payment_intent_id"
    t.string   "hashed_id"
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
  end

  add_index "memberships_payments", ["hashed_id"], name: "index_memberships_payments_on_hashed_id", using: :btree
  add_index "memberships_payments", ["memberships_package_id"], name: "index_memberships_payments_on_memberships_package_id", using: :btree

  create_table "newsletter_signups", force: :cascade do |t|
    t.string   "email_address"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "optimadmin_administrators", force: :cascade do |t|
    t.string   "username",               null: false
    t.string   "email",                  null: false
    t.string   "role",                   null: false
    t.string   "auth_token"
    t.string   "password_digest",        null: false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.datetime "password_changed_at"
  end

  add_index "optimadmin_administrators", ["auth_token"], name: "index_optimadmin_administrators_on_auth_token", using: :btree
  add_index "optimadmin_administrators", ["email"], name: "index_optimadmin_administrators_on_email", using: :btree
  add_index "optimadmin_administrators", ["username"], name: "index_optimadmin_administrators_on_username", using: :btree

  create_table "optimadmin_documents", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "document",    null: false
    t.string   "module_name"
    t.integer  "module_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "optimadmin_external_links", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "optimadmin_images", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "image",       null: false
    t.integer  "module_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "module_name"
  end

  create_table "optimadmin_links", force: :cascade do |t|
    t.string   "menu_resource_type"
    t.integer  "menu_resource_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "optimadmin_menu_item_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "optimadmin_menu_item_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "menu_item_anc_desc_idx", unique: true, using: :btree
  add_index "optimadmin_menu_item_hierarchies", ["descendant_id"], name: "menu_item_desc_idx", using: :btree

  create_table "optimadmin_menu_items", force: :cascade do |t|
    t.string   "menu_name",       limit: 100
    t.string   "name",            limit: 100
    t.integer  "parent_id"
    t.boolean  "deletable",                   default: true
    t.boolean  "new_window",                  default: false
    t.string   "title_attribute", limit: 100
    t.integer  "position",                    default: 0
    t.integer  "link_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.boolean  "display",                     default: true
  end

  add_index "optimadmin_menu_items", ["link_id"], name: "index_optimadmin_menu_items_on_link_id", using: :btree

  create_table "optimadmin_module_pages", force: :cascade do |t|
    t.string   "name"
    t.string   "route"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "optimadmin_site_settings", force: :cascade do |t|
    t.string   "key"
    t.string   "value"
    t.string   "environment"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title",                        null: false
    t.text     "content"
    t.string   "image"
    t.boolean  "display",       default: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "slug"
    t.string   "suggested_url"
    t.string   "style"
    t.string   "layout"
    t.string   "page_type"
  end

  create_table "patrons", force: :cascade do |t|
    t.string   "name",                       null: false
    t.string   "image",                      null: false
    t.string   "link"
    t.boolean  "display",    default: true
    t.integer  "position",   default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "no_follow",  default: false
  end

  add_foreign_key "articles", "article_categories"
  add_foreign_key "attendee_event_agendas", "attendees"
  add_foreign_key "attendee_event_agendas", "event_agendas"
  add_foreign_key "attendees", "event_bookings"
  add_foreign_key "event_agendas", "event_categories"
  add_foreign_key "event_agendas", "events"
  add_foreign_key "event_bookings", "events"
  add_foreign_key "member_industries", "industries"
  add_foreign_key "member_industries", "members"
  add_foreign_key "member_logins", "members"
  add_foreign_key "member_offers", "members"
  add_foreign_key "memberships_enquiries", "memberships_packages"
  add_foreign_key "memberships_payment_how_heards", "memberships_how_heards"
  add_foreign_key "memberships_payment_how_heards", "memberships_payments"
  add_foreign_key "memberships_payment_join_reasons", "memberships_join_reasons"
  add_foreign_key "memberships_payment_join_reasons", "memberships_payments"
  add_foreign_key "memberships_payments", "memberships_packages"
end
