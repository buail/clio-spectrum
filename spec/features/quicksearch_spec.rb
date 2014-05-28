require 'spec_helper'

describe 'QuickSearch landing page' do

# No, it shouldn't.  The home page should show ONLY the QuickSearch search box.
  # it "should display search fields for archives, catalog, new arrivals, journals" do
  #   visit root_path
  #   page.should have_css(".search_box.catalog option")
  #   page.should have_css(".search_box.new_arrivals option")
  #   page.should have_css(".search_box.academic_commons option")
  #   page.should have_css(".search_box.journals option")
  # end

  # NEXT-612 - Quick search page doesn't let you start over
  it "should have a 'Start Over' link", js: true do
    visit quicksearch_index_path('q' => 'borneo')
    page.should have_css('.result_set', count: 4)
    all('.result_set').each do |result_set|
      result_set.should have_css('.result')
    end

    find('.landing_across').should have_text('Start Over')
    within('.landing_across') do
      click_link('Start Over')
    end

    # Verify that we're now on the landing page
    page.should_not have_css('.result_set')
    page.should have_text('Quicksearch performs a combined search of')
  end

  # NEXT-1026 - Clicking 'All Results' for Libraries Website 
  # from Quicksearch shows an XML file
  # NEXT-1027 - Relabel 'All #### results' on Quicksearch
  # *** CATALOG ***
  it "should link to Catalog results correctly", js:true do
    visit quicksearch_index_path('q' => 'kitty')
    # page.save_and_open_page
    within('.results_header', :text => "Catalog") do
      click_link "View and filter all"
    end
    page.should have_text "You searched for: kitty"
  end
  # *** ARTICLES ***
  it "should link to Articles results correctly", js:true do
    visit quicksearch_index_path('q' => 'indefinite')
    within('.results_header', :text => "Articles") do
      click_link "View and filter all"
    end
    page.should have_text "You searched for: indefinite"
  end
  # *** ACADEMIC COMMONS ***
  it "should link to Academic Commons results correctly", js:true do
    visit quicksearch_index_path('q' => 'uncommon')
    # page.save_and_open_page
    within('.results_header', :text => "Academic Commons") do
      click_link "View and filter all"
    end
    page.should have_text "You searched for: uncommon"
  end
  # *** CATALOG ***
  it "should link to Libraries Website results correctly", js:true do
    visit quicksearch_index_path('q' => 'public')
    # page.save_and_open_page
    within('.results_header', :text => "Libraries Website") do
      should_not have_text "View and filter all"
      click_link "View all"
    end
    page.should have_text "You searched for: public"
  end


  # NEXT-849 - Quicksearch & Other Data Sources: "i" Information Content
  # NEXT-1048 - nothing happend when you click on the little round "i"
  it "should show popover i-button text in aggregates", js: true do
    # QUICKSEARCH
    visit quicksearch_index_path('q' => 'horse')
    within('.results_header[data-source=catalog]') do
      find('img').click
      find('.category_title').should have_text 'Contains library, books, videos, local resources'
    end
    within('.results_header[data-source=articles]') do
      find('img').click
      find('.category_title').should have_text "Contains articles, eBooks, electronic resources"
    end
    within('.results_header[data-source=academic_commons]') do
      find('img').click
      find('.category_title').should have_text 'Digital Repository of Research'
    end
    within('.results_header[data-source=library_web]') do
      find('img').click
      find('.category_title').should have_text 'Searches the libraries\' website'
    end

    # DISSERTATIONS
    visit dissertations_index_path('q' => 'horse')
    within('.results_header[data-source=catalog_dissertations]') do
      find('img').click
      find('.category_title').should have_text "Dissertations, Thesises from Columbia's Catalog"
    end
    within('.results_header[data-source=dissertations]') do
      find('img').click
      find('.category_title').should have_text "Dissertations from Columbia's Articles Database"
    end
    within('.results_header[data-source=ac_dissertations]') do
      find('img').click
      find('.category_title').should have_text "Dissertations from Columbia's Digital Repository"
    end

    # EBOOKS
    visit ebooks_index_path('q' => 'horse')
    within('.results_header[data-source=catalog_ebooks]') do
      find('img').click
      find('.category_title').should have_text "eBooks from Catalog"
    end
    within('.results_header[data-source=ebooks]') do
      find('img').click
      find('.category_title').should have_text "eBooks from Summon's repository of digitzed books"
    end


  end


end
