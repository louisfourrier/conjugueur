require 'test_helper'

class TenseEntriesControllerTest < ActionController::TestCase
  setup do
    @tense_entry = tense_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tense_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tense_entry" do
    assert_difference('TenseEntry.count') do
      post :create, tense_entry: { begin_content: @tense_entry.begin_content, important_content: @tense_entry.important_content, order: @tense_entry.order, tense_id: @tense_entry.tense_id, total_content: @tense_entry.total_content, verb_id: @tense_entry.verb_id }
    end

    assert_redirected_to tense_entry_path(assigns(:tense_entry))
  end

  test "should show tense_entry" do
    get :show, id: @tense_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tense_entry
    assert_response :success
  end

  test "should update tense_entry" do
    patch :update, id: @tense_entry, tense_entry: { begin_content: @tense_entry.begin_content, important_content: @tense_entry.important_content, order: @tense_entry.order, tense_id: @tense_entry.tense_id, total_content: @tense_entry.total_content, verb_id: @tense_entry.verb_id }
    assert_redirected_to tense_entry_path(assigns(:tense_entry))
  end

  test "should destroy tense_entry" do
    assert_difference('TenseEntry.count', -1) do
      delete :destroy, id: @tense_entry
    end

    assert_redirected_to tense_entries_path
  end
end
