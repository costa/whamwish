feature 'App Land' do

  scenario "unsuspecting visitor comes along" do

    # Play with some fields

    visit root_path
    test_content_editability '.register .title', "Yo Wishlist"
    expect(page).to have_content "Unsaved"
    test_content_editability '#wish-1234567890bar', "Whisky bar"
    test_content_editability '.register .subtitle', /since/
    test_content_ineditability '#wish-1234567890pony', "Pony"
    test_content_editability '#wish-1234567890new', "What would you want?"

    find('.bg-colorpicker').click
    expect(page).to have_no_content "Undo?"
    find('.colorpicker-saturation').click
    expect(page).to have_content "Undo? (3)"
    expect(page).to have_no_content "Loaded"
    click_on "Undo? (2)"
    expect(page).to have_no_content "Undo?"
    expect(page).to have_no_selector '.colorpicker-saturation'
    expect(page).to have_content "Loaded"

    expect(page).to have_selector '#wish-1234567890girl.completion-new'
    find('#wish-1234567890new').set "Bike"
    expect(page).to have_no_selector '#wish-1234567890girl.completion-new'
    expect(page).to have_selector '#wish-1234567890new.completion-new.editing'
    expect(page).to have_no_content "Saved"
    expect(page).to have_content "Saved"
    expect(page).to have_no_selector '#wish-1234567890new.editing'

    anchor1 = current_url.split('#').last
    expect(anchor1).to match /^reg\/\h\h\h\h-\h\h\h\h-\h\h\h\h-\h\h\h\h$/

    visit root_path
    expect(page).to have_content "Unsaved"
    test_content_editability '.register .title', "Yo Wishlist"
    anchor2 = current_url.split('#').last
    expect(anchor2).to match /^reg\/\h\h\h\h-\h\h\h\h-\h\h\h\h-\h\h\h\h$/
    expect(anchor2).not_to eq anchor1
  end

end
