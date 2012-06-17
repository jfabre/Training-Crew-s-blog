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

ActiveRecord::Schema.define(:version => 20120617181644) do

  create_table "albums", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string    "title"
    t.string    "slug"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "categorizations", :force => true do |t|
    t.integer   "post_id"
    t.integer   "category_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string    "user"
    t.string    "website"
    t.text      "text"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "post_id"
    t.integer   "reply_to"
    t.string    "ip_address"
  end

  create_table "images", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "title"
    t.string    "description"
    t.integer   "album_id"
    t.integer   "height",      :default => 600, :null => false
    t.integer   "width",       :default => 800, :null => false
  end

  create_table "posts", :force => true do |t|
    t.string    "slug"
    t.string    "title"
    t.date      "published_at"
    t.string    "excerpt"
    t.text      "body"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "category_id"
    t.boolean   "is_published", :default => false, :null => false
  end

  add_index "posts", ["published_at", "slug"], :name => "index_posts_on_published_at_and_slug", :unique => true

  create_table "users", :force => true do |t|
    t.string    "username"
    t.string    "password"
    t.string    "site_url"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "videos", :force => true do |t|
    t.string    "name"
    t.text      "description"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.text      "embed"
  end

end
