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

ActiveRecord::Schema.define(version: 20141202164835) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercices", force: true do |t|
    t.integer  "question_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercicings", force: true do |t|
    t.integer  "exercice_id"
    t.integer  "tense_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exercicings", ["exercice_id"], name: "index_exercicings_on_exercice_id", using: :btree
  add_index "exercicings", ["tense_id"], name: "index_exercicings_on_tense_id", using: :btree

  create_table "modes", force: true do |t|
    t.text     "name"
    t.text     "description"
    t.text     "markup"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tenses_count", default: 0
    t.integer  "order",        default: 0
  end

  add_index "modes", ["order"], name: "index_modes_on_order", using: :btree

  create_table "questions", force: true do |t|
    t.integer  "exercice_id"
    t.integer  "tense_entry_id"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["exercice_id"], name: "index_questions_on_exercice_id", using: :btree
  add_index "questions", ["tense_entry_id"], name: "index_questions_on_tense_entry_id", using: :btree

  create_table "synonymings", force: true do |t|
    t.integer  "verb_id"
    t.integer  "synonym_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "synonymings", ["synonym_id"], name: "index_synonymings_on_synonym_id", using: :btree
  add_index "synonymings", ["verb_id"], name: "index_synonymings_on_verb_id", using: :btree

  create_table "tense_entries", force: true do |t|
    t.text     "total_content"
    t.text     "begin_content"
    t.text     "important_content"
    t.integer  "order"
    t.integer  "verb_id"
    t.integer  "tense_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tense_entries", ["important_content"], name: "index_tense_entries_on_important_content", using: :btree
  add_index "tense_entries", ["order"], name: "index_tense_entries_on_order", using: :btree
  add_index "tense_entries", ["tense_id"], name: "index_tense_entries_on_tense_id", using: :btree
  add_index "tense_entries", ["verb_id"], name: "index_tense_entries_on_verb_id", using: :btree

  create_table "tenses", force: true do |t|
    t.text     "name"
    t.text     "description"
    t.text     "markup"
    t.integer  "mode_id"
    t.integer  "entry_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tenses", ["mode_id"], name: "index_tenses_on_mode_id", using: :btree

  create_table "verbs", force: true do |t|
    t.string   "content"
    t.string   "group"
    t.text     "employ"
    t.text     "auxiliary"
    t.text     "definition"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_letter"
    t.text     "page_content"
    t.string   "html_name"
    t.integer  "letters_count", default: 0
    t.text     "research_name"
    t.string   "slug"
  end

  add_index "verbs", ["content"], name: "index_verbs_on_content", using: :btree
  add_index "verbs", ["research_name"], name: "index_verbs_on_research_name", using: :btree
  add_index "verbs", ["slug"], name: "index_verbs_on_slug", using: :btree

end
