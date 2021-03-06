# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
      Movie.create!(movie)
  end
#   fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# When /^(?:|I )press "([^"]*)"$/ do |button|
#   click_button(button)
# end

# Then /^(?:|I )should see "([^"]*)"$/ do |text|
#   if page.respond_to? :should
#     page.should have_content(text)
#   else
#     assert page.has_content?(text)
#   end
# end

# Then /^(?:|I )should not see "([^"]*)"$/ do |text|
#   if page.respond_to? :should
#     page.should have_no_content(text)
#   else
#     assert page.has_no_content?(text)
#   end
# end

# When /^(?:|I )check "([^"]*)"$/ do |field|
#   check(field)
# end

# When /^(?:|I )uncheck "([^"]*)"$/ do |field|
#   uncheck(field)
# end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
    entire_html = page.body
    regexp = /#{e1}.*#{e2}/m  
    expect(entire_html).to match(regexp)
#   fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
#   fail "Unimplemented"
  modified_list = rating_list.split(", ")
#   func = 0
#   if uncheck
#       func = uncheck
#   else
#       func = check
#   end
  prefix = "ratings_"
  modified_list.each do |each_rating|
      if uncheck
          uncheck(prefix + each_rating)
      else
          check(prefix + each_rating)
      end
  end  
  #add ratings_ before the element
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  entire_html = page.body
    
  def count_em(string, substring)
      string.scan(/(?=#{substring})/).count
  end

  occurrences = count_em(entire_html, "<tr>")
#   occurrences = entire_html.count('<tr>')
#   Movie.count.should be occurrences.to_i
#   expect(Movie.count).to eq(occurrences) 
  expect(Movie.count).to eq(occurrences - 1) 


#   fail "Unimplemented"
end
