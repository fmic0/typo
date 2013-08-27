 And /the following articles having categories exist/ do |article_table|
   article_table.hashes.each do |article|
     # each returned element will be a hash whose key is the table header.
     # you should arrange to add that movie to the database here.
     Article.create! article
   end
 end

 And /the following categories exist/ do |cat_table|
   cat_table.hashes.each do |cat|
     # each returned element will be a hash whose key is the table header.
     # you should arrange to add that movie to the database here.
     Category.create! cat
   end
 end

 #And /the following categorizations exist/ do |catz_table|
 #  categorization_table.hashes.each do |catz|
 #    # each returned element will be a hash whose key is the table header.
 #    # you should arrange to add that movie to the database here.
 #    Categorization.create! catz
 #  end
 #end 


 
 
