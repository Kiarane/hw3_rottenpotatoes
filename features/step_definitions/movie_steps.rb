# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

# Make sure that one string (regexp) occurs before or after another one
# on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  assert false, "Unimplemented"
end

Then /I should see (none|all) of the movies/ do |filter|
  db_size = 0
  db_size = Movie.all.size if filter == "all"
  page.find(:xpath, "//table[@id=\"movies\"]/tbody[count(tr) = #{db_size} ]")
end

# Make it easier to express checking or unchecking several boxes at once
# "When I uncheck the following ratings: PG, G, R"
# "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(',').each do |rating|
    rating = "ratings_" + rating
 if uncheck
      uncheck (rating)
    else
      check (rating)
    end
  end
end

Then /I should see all of the movies/ do
  movies = Movie.all
  
  if movies.size == 10
    movies.each do |movie|
      assert page.body =~ /#{movie.title}/m, "#{movie.title} did not appear"
    end
  else
    false
  end
end

Then /I should not see any movies/ do
  movies = Movie.all
  movies.each do |movie|
    assert true unless page.body =~ /#{movie.title}/m
  end
end
