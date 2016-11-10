
Given /the following movies exist:/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(title: movie["title"], rating: movie["rating"], release_date: movie["release_date"])
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
   expect(page.body) =~ (/#{e1}.+#{e2}/)
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  split_list = rating_list.split(',')
  split_list.each do |element|
    element.gsub!('"','')
  end
  if uncheck  
    split_list.each do |item|
     uncheck "ratings_#{item}"
    end
  else
    split_list.each do |item|
     check "ratings_#{item}"
    end
  end
end

Then /I should see all the movies/ do
  expect(page).to have_content(movie["title"])
end
