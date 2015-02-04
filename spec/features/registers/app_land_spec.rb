feature 'App Land' do
  include RegistersHelper

  scenario "unsuspecting visitor comes along" do

    # Play with some fields

    visit root_path
    expect(page).to have_content "Unsaved"
    test_content_editability '.register .title', "Yo Wishlist"
    test_content_editability '#wish-1234567890bar', "Whisky bar"
    test_content_editability '.register .subtitle', /since/
    test_content_ineditability '#wish-1234567890pony', "Pony"
    test_content_editability '#wish-1234567890new', "What would you want?"

    expect(page).to have_selector '#wish-1234567890girl.completion-new'
    find('#wish-1234567890new').set "Bike"
    expect(page).to have_no_selector '#wish-1234567890girl.completion-new'
    expect(page).to have_selector '#wish-1234567890new.completion-new.editing'
    expect(page).to have_no_content "Saved"
    expect(page).to have_content "Saved"
    expect(page).to have_no_selector '#wish-1234567890new.editing'

    find('.bg-colorpicker').click
    expect(page).to have_no_content "Undo?"
    find('.colorpicker-saturation').click
    expect(page).to have_content "Undo? (3)"
    expect(page).to have_no_content "Loaded"
    click_on "Undo? (2)"
    expect(page).to have_no_content "Undo?"
    expect(page).to have_no_selector '.colorpicker-saturation'
    expect(page).to have_content "Loaded"

    key1 = register_uri_to_key(current_url)
    expect(key1).not_to be_nil

    # Check a refresh to bring on a new wish register

    visit root_path
    expect(page).to have_content "Unsaved"
    test_content_editability '.register .title', "Yo Wishlist"
    key2 = register_uri_to_key(current_url)
    expect(key2).not_to be_nil
    expect(key2).not_to eq key1

  end

  scenario "a visitor follows a link to a wish register (edited by another user)" do

    # Make some edits in a new wish register and capture its key
    visit root_path
    expect(page).to have_content "Unsaved"

    title_el = find('.register .title')
    subtitle_el = find('.register .subtitle')

    key = register_uri_to_key(current_url)

    # XXX mock firebase persistence - save - https://gist.github.com/costa/43ddf9ae5c51791aeab6
    firebase_val = nil
    firebase_mock = double
    allow(Firebase::Client).to receive(:new).and_return firebase_mock
    allow(firebase_mock).to(
      receive(:set) do |path, val|
        firebase_val = val  if path == "registers/#{key}"
        double :success? => true
      end
    )

    title_el.set "some title input"
    expect(page).to have_no_content "Saved"
    expect(page).to have_content "Saved"
    subtitle_el.set "some subtitle input"
    expect(page).to have_no_content "Saved"
    expect(page).to have_content "Saved"

    # Visit another register via refresh

    visit root_path  # NOTE page DOES reload
    expect(page).to have_content "Unsaved"

    expect(page).to have_no_content "some title input"
    title_el.set "some other input"
    expect(page).to have_content "Saved"

    # Check if accessing the first register brings the edited values

    visit register_key_to_path(key)  # NOTE page does NOT reload
    # XXX mock firebase persistence - load - https://github.com/katowulf/mockfirebase/commit/60e75119a6e420ad7ddff1334b32f304e70ca1ed#commitcomment-9591744
    execute_script "window.MOCK_FIREBASE = #{{"null/registers/#{key}" => firebase_val}.to_json};"

    expect(title_el).to have_content "some title input"
    expect(subtitle_el).to have_content "some subtitle input"

  end

end
