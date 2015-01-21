module FormHelpers

    def test_content_ineditability(sel, val)
      el = find sel
      expect(el).to have_content val
      expect(!el['contenteditable'] || el['disabled']).to be
    end

    def test_content_editability(sel, init_val)
      el = find sel
      expect(el).to have_content init_val
      expect(el['contenteditable'] && !el['disabled']).to be
      expect(page).to have_no_content "Undo?"
      el.set "some input"
      el.set "some input"  # XXX driver quirks
      expect(el).to have_content "some input"
      expect(page).to have_selector "#{sel}.editing"
      expect(page).to have_content "Undo? (3)"
      expect(page).to have_no_content "Loaded"
      click_on "Undo? (2)"
      expect(page).to have_no_content "Undo?"
      expect(page).to have_content "Loaded"
      expect(el).to have_content init_val
    end

end
