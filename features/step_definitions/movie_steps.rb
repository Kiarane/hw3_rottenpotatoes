# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
 assert movies_table.hashes.size == Movie.all.count
end

# Make sure that one string (regexp) occurs before or after another one
# on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  titles = page.all("table#movies tbody tr td[1]").map {|t| t.text}
    assert titles.index(e1) < titles.index(e2)
end



# Make it easier to express checking or unchecking several boxes at once
# "When I uncheck the following ratings: PG, G, R"
# "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
 
 rating_list.split(%r{\s*,\s*}).each_with_index {
     |name, index|
       if(!index) #first element
          %Q{I #{uncheck}check "ratings[#{name}]"}
        else
           %Q{I #{uncheck}check "ratings[#{name}]"}
        end
    }
end

When /^I press  "(.*?)"$/ do |arg1|
end

When /^I check the following rating: G,R,PG\-(\d+),PG$/ do |arg1|
  
end


Then /I should see (none|all) of the movies$/ do |orNot|
    rows = page.all("table#movies tbody tr td[1]").map {|t| t.text}
    if should == "none"
        assert rows.size == 0
    else
        assert rows.size == Movie.all.count
    end
end
